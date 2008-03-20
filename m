From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 0/6] Two bugfixes
Date: Thu, 20 Mar 2008 15:19:12 +0000
Message-ID: <b0943d9e0803200819k7300fd1fn8a21896c7ad2a1@mail.gmail.com>
References: <20080320002604.13102.53757.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Erik Sandberg" <mandolaerik@gmail.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 16:19:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcMYg-0006tr-Ey
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 16:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287AbYCTPTP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2008 11:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756282AbYCTPTP
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 11:19:15 -0400
Received: from el-out-1112.google.com ([209.85.162.181]:47914 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253AbYCTPTO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2008 11:19:14 -0400
Received: by el-out-1112.google.com with SMTP id v27so727294ele.17
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZZQveWm8eI8ZWMH/TC3Xl2X+CWuoMus1tO2HwQJBi1U=;
        b=IJwE84rKwvFKHeuw0F7hq8wbhMhvYwQ5B8oW0xngLUzLVL7oi8ud9kH42z6il7W1o4KCJfJ4FciYg0ExLOz9pVCSqS35bEqcb/S9fAhLeayGglXYUlYYci7ELo59WsydGoCapH/JvPALns3iMdl68PoH8wujR5bz4iWGLcTlePc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S6CbyvFBo7szQsX1St0wbdk+TbrvVX9e3/wEKLWo/+v9d5/NRbNguJDExrPU9IVhZoLgtU+AFzLIwqsTC5siJVF3O7sKUyY4RNP3oGY78VAciUMOcd6IKYKjLqN6gdEuHIm7VwRhjiXcbDwRHOkqmbOncOjBdYZMzqOZ8pMIsKY=
Received: by 10.141.86.14 with SMTP id o14mr790125rvl.278.1206026352571;
        Thu, 20 Mar 2008 08:19:12 -0700 (PDT)
Received: by 10.141.206.19 with HTTP; Thu, 20 Mar 2008 08:19:12 -0700 (PDT)
In-Reply-To: <20080320002604.13102.53757.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77663>

On 20/03/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> This series fixes one rather benign bug (4/6) and one that caused
>  patches to become empty, which is rather worse (6/6). (The patch
>  contents could still be recovered via the patch log or reflog, but
>  it's still a major inconvenience.)
>
>  Both bugs were discovered by Erik Sandberg.

Thanks to both Erik and Karl for finding and fixing this. As I wrote
on the patch system, I'd like to put back the explicit --keep option
in goto.

BTW, I have about 5 patches that apply to the stable and master
branch, mainly UI updates I needed recently (like picking multiple
patches at once). Since the master branch still needs some work (which
I'll try to help with), maybe it's worth releasing a 0.14.2, together
with some of the bugs reported so far.

--=20
Catalin
