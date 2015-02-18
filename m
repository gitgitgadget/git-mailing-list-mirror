From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Wed, 18 Feb 2015 15:05:24 +0100
Message-ID: <vpqr3tn2u3f.fsf@anie.imag.fr>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com>
	<vpqtwyl90mx.fsf@anie.imag.fr>
	<340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com>
	<vpqiof14qu8.fsf@anie.imag.fr>
	<13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com>
	<vpqr3tozzs5.fsf@anie.imag.fr>
	<CA0F915F-74B1-4292-AFB8-D1A4C76C0137@gmail.com>
	<54E3804D.6020301@web.de> <vpq61azab52.fsf@anie.imag.fr>
	<E28114B6-86FA-4F4A-9D5F-BFC03B9D79B8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Fairuzan Roslan <fairuzan.roslan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 15:05:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO5Fx-0007rA-8c
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 15:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbbBROFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 09:05:33 -0500
Received: from mx2.imag.fr ([129.88.30.17]:37616 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387AbbBROFc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 09:05:32 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t1IE5MIg014562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Feb 2015 15:05:22 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1IE5OBe021813;
	Wed, 18 Feb 2015 15:05:24 +0100
In-Reply-To: <E28114B6-86FA-4F4A-9D5F-BFC03B9D79B8@gmail.com> (Fairuzan
	Roslan's message of "Wed, 18 Feb 2015 21:47:17 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 18 Feb 2015 15:05:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1IE5MIg014562
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1424873125.78845@bXqyKKpnmysH0UR5eTbh2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264018>

Fairuzan Roslan <fairuzan.roslan@gmail.com> writes:

> Client: OS X 10.9 - 10.10.2
> git client: git version 1.9.3 (Apple Git-50) and git version 2.2.1
>
> Server : Linux 3.2.40 (Synology DSM 5.1)
> AFP : Netatalk afpd 3.1.1

Any chance you can test this with a Mac OS server?

Perhaps because the server is not a Mac OS, it doesn't have the uchg
flag, and maps it to the w bit in the POSIX permission system (this is
pure speculation from me).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
