From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Thinning a repository
Date: Sun, 30 Nov 2014 13:34:00 +0100
Message-ID: <20141130123400.GG31751@paksenarrion.iveqy.com>
References: <m5f1uq$na7$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yuri D'Elia <wavexx@thregr.org>
X-From: git-owner@vger.kernel.org Sun Nov 30 13:27:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv3b3-0006Gw-Bu
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 13:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbaK3M1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 07:27:21 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33733 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbaK3M1U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 07:27:20 -0500
Received: by mail-lb0-f182.google.com with SMTP id f15so8048645lbj.27
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 04:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oSmiuA699qq+WCrMZyk98hDu6ONPxjvq8NKxleR0Hpg=;
        b=wtA+K4hlcN/GfW9xMTlLfWClLGooYOiQxEbUGaMEf1+jmaQGWAW6ewrMRx+imhNwaI
         BUSDBqeB8/AloUzcbCOiznuLg6d3PeGM9IeZYNNVTcF+dwCXPSlC8nuED6S0zzwt4BYU
         2OoY66MNeJ8FB3zR3GUCwQgBtwoa8iSrqrkr/PdvmXS4IA9J8o815EM1Zz/JNWpXYkkv
         jYkVBmloRDXqHfUjw1S4qCcs2IkO2PX6nlKgtTdF+2nA6U1CPQUMHkwtlLIBAkKYCEum
         JQZKZ2BdUy2PaH4/9O+Kiq5Ytu5bQKHgoYLKf30AzmFEb/gPgAjRAb6lcTCJ5jzCp0Kv
         sW2Q==
X-Received: by 10.112.162.101 with SMTP id xz5mr51366042lbb.49.1417350438729;
        Sun, 30 Nov 2014 04:27:18 -0800 (PST)
Received: from paksenarrion.paks.iveqy.com (c83-249-10-52.bredband.comhem.se. [83.249.10.52])
        by mx.google.com with ESMTPSA id zs7sm544140lbb.18.2014.11.30.04.27.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 04:27:18 -0800 (PST)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Xv3hQ-0005x8-KS; Sun, 30 Nov 2014 13:34:00 +0100
Content-Disposition: inline
In-Reply-To: <m5f1uq$na7$1@ger.gmane.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260449>

On Sun, Nov 30, 2014 at 01:18:34PM +0100, Yuri D'Elia wrote:
> Is there a quick way to reproduce the effect of a shallow clone on a
> local repository that doesn't involve filter-branch and/or re-clone?

I'm curious, why is it a bad thing to do a re-clone? If you clone your
local repo it would be really fast.

--=20
Med v=E4nlig h=E4lsning
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
