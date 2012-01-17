From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] bash-completion: don't add quoted space for ZSH (fix regression)
Date: Tue, 17 Jan 2012 21:18:22 +0200
Message-ID: <CAMP44s2nYMmfC36+pGaYfOZUQy3fLMYDuaSriPYjHBeApmsRVg@mail.gmail.com>
References: <20120114152030.GX30469@goldbirke>
	<1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jan 17 20:18:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnEY8-00043i-Ej
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 20:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab2AQTSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 14:18:24 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36445 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754598Ab2AQTSX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2012 14:18:23 -0500
Received: by lahc1 with SMTP id c1so1742108lah.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 11:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/UBckbk+wg34+Neljtvpgim3sWtSzDaP7oPIcI224dI=;
        b=bsDOHz8bF08pf/e9pwUSPW+PEo/3mhupYS8anW/3xbtebealbYQ/iaeZDUS3AfPIZ8
         QdZlXlgh+51nPDTAtZLmilv/DtKQYCRd774QS0Adzq68Dc1+EbxIxlr56zQLPs6wkf1m
         adr44lEWQnCp8zQ+o1lPR4i6B58HoD5P2u+0Q=
Received: by 10.152.103.169 with SMTP id fx9mr4238563lab.10.1326827902520;
 Tue, 17 Jan 2012 11:18:22 -0800 (PST)
Received: by 10.112.86.7 with HTTP; Tue, 17 Jan 2012 11:18:22 -0800 (PST)
In-Reply-To: <1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188714>

On Sat, Jan 14, 2012 at 8:55 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Commit a31e626 (completion: optimize refs completion) introduced a
> regression for ZSH users: ref names were completed with a quoted trailing
> space (i.e. "git checkout ma" completes to "git checkout master\ "). The
> space is convenient for bash users since we use "-o nospace", but a
> quoted space is worse than nothing. The absence of trailing space for ZSH
> is a long-standing issue, that this patch is not fixing. We just fix the
> regression by not appending a space when the shell is ZSH.

I have this issue with the script from v1.7.8.3, and I think it
started with a zsh update.

-- 
Felipe Contreras
