From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Sharing a massive distributed merge
Date: Thu, 17 Mar 2011 15:54:44 +0100
Message-ID: <AANLkTikfp_d00zrtU8kuvyUk81gGMkOXEVDNXr-hRhBU@mail.gmail.com>
References: <4D8119BE.2090208@workspacewhiz.com> <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com>
 <20110317063816.GD11931@sigill.intra.peff.net> <AANLkTimTKbKWmf80u-kgnvQ2gT8hx2KTm6HGbWejt3eg@mail.gmail.com>
 <AANLkTi=25=99Gh9hGUxEuvB9Xvv=f8uJxThaMxaAQKbq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 15:55:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0EbX-0002vW-QF
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 15:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab1CQOzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 10:55:07 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49062 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab1CQOzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 10:55:04 -0400
Received: by yxs7 with SMTP id 7so1142512yxs.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/fEpeW/PUZ/Uvjje3vxb0Sp0/Z2O2TcOmTLS5inuy1o=;
        b=PGsHZQZuWUUB/bbagrZ69UVHIj538R+1lWLaDYK4hgvD77H5icNz1lA3LmOGa6N7hX
         eYUA6NoTlxTDpm62xHXRKAs8DxGIcjHEceVsaOa8sbImQHFQ6A04ukIYu0Zr4UoFSkom
         LmwwH+NW8UEbXx+BJoSdCfr/LA8jbcordBxcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cDFs3arFbkJHKPVEW/x01c6ymRFfEgfH+sgRLGozxKe1u/13ZD9CVLS2ipbn0hEFuO
         8pVpBk+hcdOtf7W6bQle2coSeH5Y3RpXgFcNhxe9Y+unNHThdRhBi8ZqaPMoaJPMzrfJ
         f0dFJycdD3Rmrz5h7oZ8EQFn/CUsNs73SM3bE=
Received: by 10.90.250.2 with SMTP id x2mr1459967agh.202.1300373704172; Thu,
 17 Mar 2011 07:55:04 -0700 (PDT)
Received: by 10.90.223.11 with HTTP; Thu, 17 Mar 2011 07:54:44 -0700 (PDT)
In-Reply-To: <AANLkTi=25=99Gh9hGUxEuvB9Xvv=f8uJxThaMxaAQKbq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169246>

On Thu, Mar 17, 2011 at 15:10, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Thu, Mar 17, 2011 at 4:53 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
>> What if they just revert the rest? Reset the files to their states before
>> merge.
>
> That's the same as checkout --ours which is sometimes a valid
> resolution for a file. So I think "I resolved this file" needs to be
> recorded either way.

But it is recorded: the file is different now!
