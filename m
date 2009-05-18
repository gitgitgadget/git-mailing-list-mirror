From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git svn rebase problem
Date: Mon, 18 May 2009 13:00:25 -0400
Message-ID: <32541b130905181000v34d5fd6arcb662bff232cb81c@mail.gmail.com>
References: <4A0DDCC5.4010001@dlasys.net> <op.ut4aagco1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David H. Lynch J.r" <ml@dlasys.net>, git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 18 19:01:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M66DD-0005Ue-DW
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 19:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbZERRAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 13:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbZERRAp
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 13:00:45 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:63269 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbZERRAp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 13:00:45 -0400
Received: by gxk10 with SMTP id 10so6476931gxk.13
        for <git@vger.kernel.org>; Mon, 18 May 2009 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SRF/K7DWW/vxOsHJWv5r9g4UAltYZSbY7XuVFEmLwfI=;
        b=Towd34JptorFlKwqjgP0IRYQgg0h2ZNn+OmXTUJXzyVD2CQPRHHBwszJju2yZPOctt
         qQk0j3nRXxGs47POxSPgKW/Ur7Yo90pxqXQr4sJv9bpITJKaQRsjhppBUVcu67gHnC4J
         m07a9J4zRFBZIzew57p+IZ0IEhXGz7CoWSoyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CZDdn4FsHGFI0v0fnt8Tlb1eq15dIk3MGFQJtx18TFnNNVgrKNXyFek19m7FfWuDCo
         WYILvObvmEajROE5VtdO/FnX9szmnCor8mm/4KmGU/MY4jtb+3FLUYNxDzc12+bCVmso
         ZMk1pZyszJK0qsqTB7J9V4i+XorXlxroultl4=
Received: by 10.151.150.21 with SMTP id c21mr12889028ybo.322.1242666045281; 
	Mon, 18 May 2009 10:00:45 -0700 (PDT)
In-Reply-To: <op.ut4aagco1e62zd@merlin.emma.line.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119458>

On Mon, May 18, 2009 at 4:38 AM, Matthias Andree <matthias.andree@gmx.de> wrote:
> Have you been working on a branch other than the one that git-svn created
> for you? If so, you may have to "git checkout" the original branch before
> being able to "git svn rebase".
>
> Branches and git-svn don't mix.

That's not exactly true: merging and git-svn don't mix.  But rebasing
works fine.

If you have a separate branch and do 'git svn rebase', then as far as
I know, the original git-svn branch(es) will get updated to the latest
version from svn, and then your current branch will be rebased on top
of it.  This is often what you want, unless you've been using 'git
merge' from that branch.  Rebasing (unless you know exactly what
you're doing) always messes up git merge.

Have fun,

Avery
