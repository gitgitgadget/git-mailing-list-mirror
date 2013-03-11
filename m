From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: ZSH segmentation fault while completing "git mv dir/"
Date: Mon, 11 Mar 2013 16:14:25 +0100
Message-ID: <513DF4D1.6000500@gmail.com>
References: <vpqd2v686fi.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, felipe.contreras@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 11 16:15:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF4RW-0008J7-Ju
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 16:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229Ab3CKPOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 11:14:45 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:45550 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab3CKPOo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 11:14:44 -0400
Received: by mail-ee0-f48.google.com with SMTP id t10so2296983eei.21
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=SEgiszzWmwMBqougluzYSA0BuANSnPRBLYo8++Xhc6o=;
        b=cPHWfLPU7q+ph0NKcUgKErdkYlmaROxRFgYCGP8H+NrAPxa5yT+B0vcPajwBWAIXm+
         7sNu2Vvrdy0DpqleHmjexIYj/8mlcJuyuorD5BGN0g0xrT/QG83DXs1lo6IdCWu/0Mgf
         DDiCCOohn+3OGqJWrzgKr11ytyztQBpvXDuyjr6nCVyk3XKfjpnXWsjMkIXA1yRFM/kw
         IY3FrCZ7LcUF1YcB2JSoNUCREC1bPnrgXjcjylO4CBIBOgv3ILI8nRWehDFs09ZRhVur
         Io2O8pXjz5p46DQl6n4Qq0SqkLTK7NUPN/CGl0Bnx9Uddulelxq7wLiniECBtg3pv/Xz
         NG3A==
X-Received: by 10.14.3.70 with SMTP id 46mr37555069eeg.2.1363014883061;
        Mon, 11 Mar 2013 08:14:43 -0700 (PDT)
Received: from [192.168.0.3] ([151.70.200.211])
        by mx.google.com with ESMTPS id a1sm24115119eep.2.2013.03.11.08.14.38
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 08:14:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <vpqd2v686fi.fsf@grenoble-inp.fr>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217879>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 11/03/2013 13:30, Matthieu Moy ha scritto:
> Hi,
> 
> Since the recent update to bash completion, I often get a segmentation
> fault from ZSH. This is most likely a bug in ZSH, but it would be cool
> to avoid triggering it from Git.
> 
> [...]
> moy@anie:~$ zsh --version
> zsh 4.3.10 (i686-pc-linux-gnu)
> 
> (this is ZSH packaged with Debian stable)
> 

I have the same system, but I can't reproduce the problem.
What is the content of your .zshrc file?


Regards  Manlio Perillo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlE99NAACgkQscQJ24LbaURIwgCbB9HmepRfvTqN2vh6H5/Ew7Mw
WQMAn3CSiFViQ7j62fuBVKg6WJK+Yg/0
=j4FV
-----END PGP SIGNATURE-----
