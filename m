From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 09:24:50 +0700
Message-ID: <fcaeb9bf0710151924r258dd561hd13c22319d17f80f@mail.gmail.com>
References: <Pine.LNX.4.64.0710142112540.25221@racer.site>
	 <Pine.LNX.4.64.0710150217120.25221@racer.site>
	 <20071015175606.GE2966@steel.home> <4713B367.52CEC7E2@dessent.net>
	 <Pine.LNX.4.64.0710151938300.25221@racer.site>
	 <4713BA89.633B86F2@dessent.net> <20071015194214.GC15541@steel.home>
	 <4713C81F.A75FEFC2@dessent.net>
	 <Pine.LNX.4.64.0710152117290.25221@racer.site>
	 <7287AD62-3274-4B20-881C-D02E08C4B2EF@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Alex Riesen" <raa.lkml@gmail.com>, "Eli Zaretskii" <eliz@gnu.org>,
	"Andreas Ericsson" <ae@op5.se>, tsuna@lrde.epita.fr,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 04:25:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihc7j-0004xA-Kd
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 04:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761429AbXJPCYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 22:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757557AbXJPCYz
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 22:24:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:63736 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761102AbXJPCYw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 22:24:52 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1449170nfb
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 19:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZxbgdxANwWvO5AvMqIIbQTBzJ+QM/obf/ojWc6dl108=;
        b=DrVH4pWE5VcFEbFaYmn4WMsRg+sMvYbfbn79AxQn/NbCRIDNk4TMe20YlzMIIoshyxXrVewD2xZno3GGLzihVK3UzHZB4MdNHxZM+aG47CjAz6hWEw/b35LtyBY/NLCUAM60nKS37pJUVnQNTlMI3uV6WSI8GPjOhPYE/VJfG4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qzAn38PBZe0gaFRYxaxwxJnzf9FUj9p5G5Idrgsc43K0QnIIXAcM7X32Bb3PZ/QyP8CcUhWIGrZ4ZpFRv2gy9qyQMpZjYEFMnJUgby4zTPArLmuO3gKDJ9A746Ga7wDgvJdXM1HAkyHoeWwxgfHXSknb2yDmtSBL9NZvedFF/wc=
Received: by 10.86.97.7 with SMTP id u7mr5481186fgb.1192501490566;
        Mon, 15 Oct 2007 19:24:50 -0700 (PDT)
Received: by 10.86.83.3 with HTTP; Mon, 15 Oct 2007 19:24:50 -0700 (PDT)
In-Reply-To: <7287AD62-3274-4B20-881C-D02E08C4B2EF@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61063>

On 10/16/07, Steffen Prohaska <prohaska@zib.de> wrote:
>
> On Oct 15, 2007, at 10:19 PM, Johannes Schindelin wrote:
> > There is a port of BusyBox' dash, which is nearing completion.  Once
> > Nguyen says it is ready enough, we will try to integrate it into
> > msysGit.
>
> Gnuarch [1] recommends zsh from the unxutils project [2].

All zsh links in [2] are dead. I did try hard to find the legendary
zsh for Windows before giving up and porting busybox's ash instead. If
you have zsh source of the port, please send me. Thank you.

>         Steffen
>
> [1] http://www.gnuarch.org/gnuarchwiki/Native_WIN32_Support
> [2] http://unxutils.sourceforge.net/
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Duy
