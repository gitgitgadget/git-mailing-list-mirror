From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-reset: Let -q hush "locally modified" messages
Date: Fri, 25 Jul 2008 14:24:21 -0700
Message-ID: <7vwsj9r722.fsf@gitster.siamese.dyndns.org>
References: <1217018948-32475-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 25 23:25:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMUn4-0002s6-M7
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 23:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbYGYVYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 17:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbYGYVYb
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 17:24:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbYGYVYa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 17:24:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 68C6540747;
	Fri, 25 Jul 2008 17:24:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C4A4040745; Fri, 25 Jul 2008 17:24:24 -0400 (EDT)
In-Reply-To: <1217018948-32475-1-git-send-email-s-beyer@gmx.net> (Stephan
 Beyer's message of "Fri, 25 Jul 2008 22:49:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 10C5A218-5A90-11DD-9A5F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90117>

Stephan Beyer <s-beyer@gmx.net> writes:

> git reset -q makes reset more quiet, but "locally modified" messages are
> still shown.  This patch makes them disappear, too.

Files being "locally modified" is not and error, so I think it is in line
with the spirit of what -q is meant to do.

It is an interface change, though.
