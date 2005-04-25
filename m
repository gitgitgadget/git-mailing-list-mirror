From: Rene Rebe <rene@exactcode.de>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 13:39:47 +0200
Organization: ExactCode
Message-ID: <426CD703.5040009@exactcode.de>
References: <426CD1F1.2010101@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 13:36:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ1sV-00050l-PS
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 13:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVDYLkv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 25 Apr 2005 07:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVDYLkv
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 07:40:51 -0400
Received: from mx01.qsc.de ([213.148.129.14]:53423 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S262591AbVDYLks (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 07:40:48 -0400
Received: from port-212-202-41-157.dynamic.qsc.de ([212.202.41.157] helo=exactcode.de)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1DQ1wy-00052g-00; Mon, 25 Apr 2005 13:40:28 +0200
Received: from localhost ([127.0.0.1])
	by exactcode.de with esmtp (Exim 4.22)
	id 1DQ1wx-0001ZH-QM; Mon, 25 Apr 2005 11:40:27 +0000
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
In-Reply-To: <426CD1F1.2010101@tiscali.de>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Matthias-Christian Ott wrote:
> The "git" didn't try store small variables, which aren't referenced, =
in=20
> the processor registers. It also didn't use the size_t type. I correc=
ted=20
> a C++ style comment too.

Well, modern compilers take register as a non-binding hint. Your=20
register storage specification for those loop counters will not make an=
y=20
change. You have not looked into the resulting binary?

Also // is valid C99 ...

Yours,

--=20
Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
             http://www.exactcode.de/ | http://www.t2-project.org/
             +49 (0)30  255 897 45

