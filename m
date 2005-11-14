From: Franck <vagabon.xyz@gmail.com>
Subject: Re: Can't use gitk.
Date: Mon, 14 Nov 2005 15:31:20 +0100
Message-ID: <cda58cb80511140631n46fdce52n@mail.gmail.com>
References: <cda58cb80511140253s92f28e2g@mail.gmail.com>
	 <437870AF.8060607@op5.se>
	 <cda58cb80511140322v686e4ee0g@mail.gmail.com>
	 <43787831.3030404@op5.se>
	 <cda58cb80511140355q1add0ba5n@mail.gmail.com>
	 <43787E6E.8030702@op5.se>
	 <cda58cb80511140600k2c0188c4i@mail.gmail.com>
	 <59a6e5830511140604o12af40fdp1b05cc84962d5903@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 15:35:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbfN5-0002Y8-SG
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 15:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVKNObV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 09:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVKNObV
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 09:31:21 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:10825 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751132AbVKNObV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 09:31:21 -0500
Received: by zproxy.gmail.com with SMTP id 14so1281697nzn
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 06:31:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UE3bF8yLsRlF22f/oyKjplXoG7auwhIE6t0AZgTdaCbxJG2s3ANhYqVQTvSMgYBlSXDIhgM6heJvhwhmsJ87r7ToBx1FtKqvZ3X/HumxRDKveRM4IzNDEqrZ96BCRb5iq9HWzY9CbZCO+QTzfQOEnuh6wL2aSYYtZJRVvBlqyBE=
Received: by 10.36.247.78 with SMTP id u78mr4159347nzh;
        Mon, 14 Nov 2005 06:31:20 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Mon, 14 Nov 2005 06:31:20 -0800 (PST)
To: Wayne Scott <wsc9tt@gmail.com>
In-Reply-To: <59a6e5830511140604o12af40fdp1b05cc84962d5903@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11801>

2005/11/14, Wayne Scott <wsc9tt@gmail.com>:
> Probably you need to fix your .profile or .bashrc.   Set your PATH
> unconditionally and not just for interactive shells. In general
> anytime you make some setup in your shell conditional on being
> interactive it is just asking for problems.
>
> Test like this:
>    ssh localhost 'echo $PATH'
>

well I found a fix, but I don't know why it actually fixes things :)

I replaced in .bash_profile
        PATH=~/bin:$PATH
by
        PATH=$HOME/bin:$PATH

Any ideas ?

Thanks
--
               Franck
