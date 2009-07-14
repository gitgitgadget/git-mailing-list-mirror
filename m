From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Re: git-am: less strong format "mbox" detection
Date: Tue, 14 Jul 2009 10:35:58 +0200
Message-ID: <4A5C436E.8000304@viscovery.net>
References: <bb3a84e2b817268a88832dc7043383e4b91a3df3.1247553623.git.ni.s@laposte.net> <cb7bb73a0907140016r4807c008h9c98f76200e9c3a5@mail.gmail.com> <20090714082059.GA13808@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 14 10:38:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQdUo-0004SF-5u
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 10:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbZGNIgL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 04:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbZGNIgK
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 04:36:10 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:47716 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbZGNIgK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 04:36:10 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MQdUV-0005QM-Cn; Tue, 14 Jul 2009 10:36:06 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0B94A4E4; Tue, 14 Jul 2009 10:35:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090714082059.GA13808@vidovic>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123229>

Nicolas Sebrecht schrieb:
> Le 14/07/09, Giuseppe Bilotta a =E9crit :
>=20
>>> diff --git a/git-am.sh b/git-am.sh
>>> index d64d997..d10a8e0 100755
>>> --- a/git-am.sh
>>> +++ b/git-am.sh
>>> @@ -169,7 +169,7 @@ check_patch_format () {
>>>                read l2
>>>                read l3
>>>                case "$l1" in
>>> -               "From "* | "From: "*)
>>> +               "From "* | "From: "* | "X-Account-Key:"* | "Return-=
Path:"* | "Delivered-To:"*)
>=20
> And why should we accept "From "?

Because mbox format must begin with "From ".

The question is rather: Why should we accept anything else? The case ar=
m
in question is about detecting mbox format.

-- Hannes
