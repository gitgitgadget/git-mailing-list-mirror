From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/4] Add git-sequencer test suite (t3350)
Date: Sat, 05 Jul 2008 11:16:55 -0700
Message-ID: <7vk5g0ryaw.fsf@gitster.siamese.dyndns.org>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
 <1214879914-17866-2-git-send-email-s-beyer@gmx.net>
 <1214879914-17866-3-git-send-email-s-beyer@gmx.net>
 <1214879914-17866-4-git-send-email-s-beyer@gmx.net>
 <20080705173130.GA8099@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 05 20:18:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFCKm-0005Q2-62
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 20:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbYGESRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 14:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbYGESRI
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 14:17:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbYGESRH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 14:17:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 40290225E4;
	Sat,  5 Jul 2008 14:17:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B0DD6225E0; Sat,  5 Jul 2008 14:16:59 -0400 (EDT)
In-Reply-To: <20080705173130.GA8099@leksak.fem-net> (Stephan Beyer's message
 of "Sat, 5 Jul 2008 19:31:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 91DE60B0-4ABE-11DD-A1DF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87457>

Stephan Beyer <s-beyer@gmx.net> writes:

> Hi,
>
> I've just noticed that those tag names:
>   +	git tag A &&
>   +	git tag B &&
>   +	git tag C &&
>   +	git tag D &&
>   +	git tag E &&
>   +	git tag F &&
>   +	git tag I &&
>   +ref refs/tags/CE
> are perhaps a bad idea, because they could also be an abbreviated SHA1.

I do not think we take a single letter abbrev so it should be fine.
