From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request: git-log should accept sth like v2.6.26-rc8-227
Date: Thu, 10 Jul 2008 15:52:18 -0700
Message-ID: <7vk5ftnyhp.fsf@gitster.siamese.dyndns.org>
References: <200807102057.15063.toralf.foerster@gmx.de>
 <7vk5ftpnek.fsf@gitster.siamese.dyndns.org>
 <m3d4lledbn.fsf@localhost.localdomain>
 <7v8ww9pkv8.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807110022510.3279@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:53:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH514-0005nE-1w
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbYGJWwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbYGJWwe
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:52:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33612 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbYGJWwd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:52:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 60E0D2536A;
	Thu, 10 Jul 2008 18:52:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7EFC325367; Thu, 10 Jul 2008 18:52:26 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807110022510.3279@eeepc-johanness> (Johannes
 Schindelin's message of "Fri, 11 Jul 2008 00:24:28 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E17862D4-4ED2-11DD-9681-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88047>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 10 Jul 2008, Junio C Hamano wrote:
>
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> > Besides, it would be nice to have some command (git-rev-parse 
>> > perhaps?) which could take ambiguous commit-ish, and list all commit 
>> > which matches it.
>> 
>> Have fun writing it and send in a patch.
>
> Note that this really could be a patch, but not for rev-parse.  Patch 
> revision.c instead to parse the argument into _all_ matching revisions.

As Linus pointed out, that is "all _locally_ matching revisions".  It is
of dubious value in a distributed environment.
