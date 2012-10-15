From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [Patch 3/5] Create html documents for all files in Documentation/RelNotes
Date: Mon, 15 Oct 2012 13:48:22 +0200
Message-ID: <507BF806.1030709@drmicha.warpmail.net>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net> <343092834.269729.1349538958985.JavaMail.ngmail@webmail08.arcor-online.net> <20121006192105.GA17895@sigill.intra.peff.net> <7vmwzyovg3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Thomas Ackermann <th.acker66@arcor.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 17:34:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNmgm-0005Qh-0m
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 17:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab2JOPed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 11:34:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33369 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751288Ab2JOPec (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 11:34:32 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1DE7320E44;
	Mon, 15 Oct 2012 11:34:32 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 15 Oct 2012 11:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=rN1ZHKvy3VPA7xZNzHuAkU
	UxrBA=; b=TXBH3s1q2SfjOnBQOLSdnpfJAcB1v14IGnBPC3b44GPHb3kf756c8D
	HABYPBcu/gcLU5jkOaAXpxLfub65lm6iGsppHdKf562i52O91lI5AZ32RW6dZ0rZ
	Sax2Ohod8tMlQc4Q35FOs8u6ioJzYSLTyXj2B42hBFzo1k4X+5zIs=
X-Sasl-enc: XAs4LM1afXP2EjlP8LtNpzhGXivJu978TszgkmRXYV9W 1350315271
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 68FD04827BC;
	Mon, 15 Oct 2012 11:34:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <7vmwzyovg3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207753>

Junio C Hamano venit, vidit, dixit 07.10.2012 22:53:
> Jeff King <peff@peff.net> writes:
> 
>> [1] I would not be surprised if they do not actually format all that
>>     well. Though they are written in an asciidoc-ish style, they have
>>     not traditionally been formatted, and I suspect there are many small
>>     errors (like improper quoting of metacharacters) in them.
> 
> They aren't even "errors". As far as I (who writes the release
> notes) am concerned, they are straight text without any asciidoc
> or markdown mark-up.

I'm wondering: If it's neither markdown nor markup then what is it:
marklevel, markeven or markstraight?

Seriously, if Thomas converts them into asciidoc it's an added benefit
(and I don't think you'd have to change your writing by much), but
RelNotes should not be in the standard make target.

On a different note: Is pdf really the format of choice for mobile
platforms? I'd expect something that is "formatted" (markup) but can
reflow text intrinsically, not only by making your pdf reader jump
through hoops. HTML?

Michael
