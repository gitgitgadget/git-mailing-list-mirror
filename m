From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] grep: Add the option '--open-files-in-pager'
Date: Sat, 27 Mar 2010 23:09:38 -0500
Message-ID: <20100328040938.GA2017@progeny.tock>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.1003261149040.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 28 06:09:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvjos-0004QJ-Rr
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 06:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891Ab0C1EJo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Mar 2010 00:09:44 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48544 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab0C1EJo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 00:09:44 -0400
Received: by gwaa18 with SMTP id a18so3397955gwa.19
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 21:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MEY240Jzn/7gqETGI49ZNzEQIdoh9JqMeMGsPflVCr8=;
        b=lL/fRt58/14o24M/mLUkCkwHPDSkyL1qhyY2P5x5Sr2lItLCTxus46MYbbDvivhnvC
         rU/ArG2Tpwa9BblK4Osiary7joSjM3J1h5pyei8bCBifVe4AtVGJEyz6ytuJKLsxPLeW
         YnSx0RKPp2F/5bI3clu65rxcLeotlxcSUAEXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=bJvlu575KzaVpdNMU1dSuTD4AFLnY8gtxB+2YQpw3RJcb29YgL/5WxJLnngPiyuGJm
         5V5CFKdzSPYhE4pO6ZaPSvP7V+ym6XbioYTvilyASWIU3dYSXl5ltqrMEkmTraSolP3I
         wNv8HyFxTAUzkIV/0MRxpjlzup4Xs2HvD2f7Y=
Received: by 10.101.165.1 with SMTP id s1mr5494106ano.79.1269749383147;
        Sat, 27 Mar 2010 21:09:43 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2506363iwn.9.2010.03.27.21.09.42
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 21:09:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1003261149040.7596@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143376>

Hi,

Johannes Schindelin wrote:

> This adds an option to open the matching files in the pager, and if t=
he
> pager happens to be "less" (or "vi") and there is only one grep patte=
rn,
> it also jumps to the first match right away.

Sounds interesting.

> diff --git a/builtin-grep.c b/builtin-grep.c
> index 5d83d9b..233c772 100644

I couldn=E2=80=99t get this to apply to current master or maint, and se=
arching for
blob 5d83d9b to find a more suitable merge base revealed that I don=E2=80=
=99t
actually have that object in my repo.  Is this patch available already
applied in a public git repo somewhere?

Hopeful,
Jonathan
