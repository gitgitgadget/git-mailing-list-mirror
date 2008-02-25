From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Teach git-describe --long to output always the long format
Date: Mon, 25 Feb 2008 09:34:31 +0100
Message-ID: <8aa486160802250034ncdf20b6s13856ca8612bc2ea@mail.gmail.com>
References: <1203864412-27977-1-git-send-email-sbejar@gmail.com>
	 <20080225023634.GK8410@spearce.org>
	 <7vwsotpwbr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 09:35:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTYno-0000jA-3Y
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbYBYIeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 03:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbYBYIeg
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 03:34:36 -0500
Received: from el-out-1112.google.com ([209.85.162.176]:13599 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbYBYIef (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 03:34:35 -0500
Received: by el-out-1112.google.com with SMTP id v27so1216923ele.23
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 00:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=mueUtNO8S+64KYFzeA3RdAuzCP46NUYNvJE3Frb/hZQ=;
        b=p1OOP4BOouavxEhRACabXq+D8bkC2G1DAbEQ9fCjnhBg9JoC0aFeSulETaMKApVnud/wGnhve+Pf+PU/yaekeVi6tN5HH++99h0K0I1R6edbIv+RkfLkkWjm05a03CtBblG+Pu/OQ4neMHh9c0vn8fRvM9aAgVsDMYZwh34BSng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gxbSjIQbstTZdsJqGBEZpqQixLiPXeQz+Z7L1W+pDb5y84Ol7k7XoJPBMP+X64UwhHrgcirk+gUpjqU2X2nR9T4s8YhQXsO/RHF9vk8sK8r41he2xwIZQ930N9wAflD2eGVedE6s5+KnMn8f16YnPDo8PZHkwFAMfgfDpwIc9x4=
Received: by 10.150.230.2 with SMTP id c2mr965711ybh.161.1203928471833;
        Mon, 25 Feb 2008 00:34:31 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Mon, 25 Feb 2008 00:34:31 -0800 (PST)
In-Reply-To: <7vwsotpwbr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75012>

On Mon, Feb 25, 2008 at 4:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>  >> +            else
>  >> +                    printf("%s-0-g%s\n", n->path,
>  >> +                            find_unique_abbrev(cmit->object.sha1, abbrev));
>  >
>  > Is this really that useful?  Where is having the tag and the commit
>  > SHA-1 both useful?
>
>  I had the same question.  The only place that I find this could
>  be useful is when you tag, build and install, and then find
>  glitches before pushing the results out and rewind, rebuild and
>  re-tag.  I unfortunately have this issue almost all the time.
>
>  But even then, I would probably not rely on this patch.
>

This can be usefull when more than one person can make "official" tags
(or nobody), and then you have a uniqe idendifier with a descriptive
name.

Santi
