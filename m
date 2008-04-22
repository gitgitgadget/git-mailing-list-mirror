From: "Benjamin Collins" <ben.collins@acm.org>
Subject: Re: git-gui hangs on read
Date: Tue, 22 Apr 2008 08:34:31 -0500
Message-ID: <b3889dff0804220634u58a5ed21yf8a4f369471c6534@mail.gmail.com>
References: <b3889dff0804210723s620363fdscba43c79dbb62d55@mail.gmail.com>
	 <20080422001311.GS29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 15:36:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoIfJ-0000v2-0m
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 15:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbYDVNeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 09:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763151AbYDVNef
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 09:34:35 -0400
Received: from el-out-1112.google.com ([209.85.162.180]:50192 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756057AbYDVNee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 09:34:34 -0400
Received: by el-out-1112.google.com with SMTP id n30so696638elf.21
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 06:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=YL0hbSR2Q5u/7QibY27hEABDK9EjVNcBajKxX+/R22A=;
        b=TNutANggeEMPPoWT7Fon861w2e26YFsUry2nH2zhQk6b2ptEGh+ceAEgYTjmSEUp7C11AojCHCaGebAvRZxvP6w7NZTkVmroM0xZ2/6hcdwkqmRtfXwn8zTcz4zwumx6ccamAHGj5BTLYtkQLIgii6vUjIYOLj6GwaBXUqRLKgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=l1kST+0zX6jT4/h0orWCx2wTpErwtC/fl19r9SyRAgL7l6dsPwASRHiqyl0VZeJ+4/HUGMeNMH4KAlEEu3c334oiEHYb/LzO5sPDhJ2ShDzutvTHtSEsRwRdb/+q2Bwf+yEXJ2tc2QfD0+Fx1jT+WvElhkgX2f5/uOvEKi0r/Vs=
Received: by 10.140.88.11 with SMTP id l11mr104786rvb.74.1208871272090;
        Tue, 22 Apr 2008 06:34:32 -0700 (PDT)
Received: by 10.141.75.14 with HTTP; Tue, 22 Apr 2008 06:34:31 -0700 (PDT)
In-Reply-To: <20080422001311.GS29771@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 8741987cb360164c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80117>

On Mon, Apr 21, 2008 at 7:13 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>  From the strace it looks like your aspell is not giving us a
>  reply to the "$$cr master" command.  What does this give you?
>
>         aspell --mode=none --encoding=UTF-8 pipe <<EOF
>         !
>         $$cr master
>         EOF
>
>  --
>  Shawn.

Response:

$ aspell --mode=none --encoding=UTF-8 pipe <<EOF
> !
> $$cr master
> EOF
@(#) International Ispell Version 3.1.20 (but really Aspell 0.50.5)
& cr 70 5: Cr, cry, RC, CPR, CRT, Car, car, ctr, cur, CT, Ct, ct, C, R, c, r, Ce
, cir, Gr, Jr, Kr, gr, qr, NCR, OCR, VCR, CA, CO, Ca, Co, Cu, RR, ca, cc, ck, co
, cu, cw, yr, BR, Br, CB, CD, CF, CV, CZ, Cb, Cd, Cf, Cl, Cm, Cs, Dr, Fr, HR, Lr
, Mr, PR, Pr, Sr, Zr, cf, cg, cl, cm, cs, fr, hr, pr, tr

$


-- 
Benjamin A. Collins <ben.collins@acm.org>
