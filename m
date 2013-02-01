From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: Aw: Re: [PATCH v3 3/6] Change 'git' to 'Git' whenever the
 whole system is referred to #2
Date: Fri, 1 Feb 2013 19:04:00 +0100 (CET)
Message-ID: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net>
References: <7vzjzodfp1.fsf@alter.siamese.dyndns.org> <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davvid@gmail.com
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Fri Feb 01 19:04:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1KyU-0008Ow-0h
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600Ab3BASEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 13:04:06 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:57378 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752990Ab3BASEE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2013 13:04:04 -0500
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mx.arcor.de (Postfix) with ESMTP id 3B801D8085;
	Fri,  1 Feb 2013 20:03:59 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 4C1503C413B;
	Fri,  1 Feb 2013 19:04:00 +0100 (CET)
Received: from webmail18.arcor-online.net (webmail18.arcor-online.net [151.189.8.76])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 4268D305B1;
	Fri,  1 Feb 2013 19:04:00 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-02.arcor-online.net 4268D305B1
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1359741840; bh=Iy8i49dqwSod3p3MjSVziRVcu/4+Grgb+9F2qmT1Yiw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=leyk6oUlvxOovxAK8Z+Qn4WT/dk+syUg0XUHcuMl+XHw3sYe90mvK+LREV7yxkPMW
	 L4hUiaHnBTx80iDcZBuDdidplffm4ZzKDCTUU3fDN9aPwH0SzyLxXKSoCxQ9f8WoO+
	 Dnn030MmR3IpzVkKDlyhqXIpfqzGTq1I0DzvYqyc=
Received: from [188.105.106.49] by webmail18.arcor-online.net (151.189.8.76) with HTTP (Arcor Webmail); Fri, 1 Feb 2013 19:04:00 +0100 (CET)
In-Reply-To: <7vzjzodfp1.fsf@alter.siamese.dyndns.org>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.106.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215237>

 > 
> I think we have waited long enough and as far as I recall we didn't
> see any reports of misconversion or forgotten conversion, so I'll
> squash the fixes parked on the topic branch, whose tip is at
> bfb8e1eb6375afb (fixup! Change 'git' to 'Git' whenever the whole
> system is referred to #4, 2013-01-22), and merge the result to
> 'next' sometime tomorrow.
> 

Here are my final fixups on top of bfb8e1eb6375afb:
I morphed the remarks from Junio and David into patch form and
also did the reverse check for wrong usage of 'Git' instead of 'git'.
While doing the later I also noticed some small glitches and fixed them.
Squash at your will.

[PATCH 1/6] fixup! fixup! Change 'git' to 'Git' whenever the whole system is referred to #2
[PATCH 2/6] fixup! fixup! fixup! Change 'git' to 'Git' whenever the whole system is referred to #1
[PATCH 3/6] fixup! Documentation: avoid poor-man's small caps
[PATCH 4/6] Fix places where 'Git' should be 'git
[PATCH 5/6] Add a description for 'gitfile' to glossary
[PATCH 6/6] Use consistent links for User Manual and Everyday Git; Fix a quoting error


---
Thomas
