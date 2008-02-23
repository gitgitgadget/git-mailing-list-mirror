From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: Re: How small is git-packed mailing list vs zipped mailing list?
Date: Sat, 23 Feb 2008 06:34:54 +0100
Message-ID: <998d0e4a0802222134r1c96b39bt2d34f3fb2289c67f@mail.gmail.com>
References: <998d0e4a0802222103x7b42b849q950a2a3c9b0d3550@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 06:36:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSn3L-0001N2-Df
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 06:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbYBWFe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 00:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbYBWFe4
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 00:34:56 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:15819 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbYBWFez (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 00:34:55 -0500
Received: by wx-out-0506.google.com with SMTP id h31so609758wxd.4
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 21:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=42HkWNmbnYMIdwUFbAA3eIrofhzUU56HUn+by6yCBcw=;
        b=a2Q6IsakNyiXeOyG8AEOERWDlTm2nS/xvtUlBJncSQfBecd8RCmc3GxLOMrQBFu87ozzvowmeg3XV/7ppt0Kn+DlUMuRh4IEk/jWToZBB4L/PXEZjsw2pewWs4w0SnMcypIlihl1uSYSkVJUmwKQwqbJjvJ8GfruLrZqnoXSQek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FNZ9BUmu8p0A57qr9wc665vLJ2MWWCq+b0UCzv2EODsFDkygVYvTFAbgP4nTt+h5h9FPwaPWzyPfGu0dAZ2z/MaGMTagIHY+rTXXUnnatttRo3IOysMAc6E+44E1le9sCZyxHIuZ97QOFYH824MicvQcgMQC8+56ZBZHCy4bY1A=
Received: by 10.70.17.1 with SMTP id 1mr17522wxq.28.1203744894597;
        Fri, 22 Feb 2008 21:34:54 -0800 (PST)
Received: by 10.70.40.12 with HTTP; Fri, 22 Feb 2008 21:34:54 -0800 (PST)
In-Reply-To: <998d0e4a0802222103x7b42b849q950a2a3c9b0d3550@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74801>

On 2008/2/23, J.C. Pizarro <jcpiza@gmail.com>, i wrote:
> Not all inside of git repository data is source code used for
>  versioning control, but the mailing lists are pushed too into git repo!
>
>  Is there any idea of
>
>  How small is a git packed mailing list vs zipped mailing list?
>
>    ;)
>

It thanks to the delta scheme, minimum spanning tree and zlib of the git packer.

1. For git, it's better to commit splitted monthly-files
     (the atomic messages have some redundancy in the replies and forwards).

2. For zip, it's better to zip non-splitted monthly-files.
