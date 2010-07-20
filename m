From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH] t/t3700: convert two uses of negation operator '!' to
 use test_must_fail
Date: Tue, 20 Jul 2010 12:38:22 -0400
Message-ID: <20100720163822.GA8492@localhost.localdomain>
References: <tMTpk3TmiYV54AYDiNJMBdnlXhSooJQQ1gRoAEsSwmcSwJ9ROgOpr75wpEQNx6_kZkqBtD71_QU@cipher.nrlssc.navy.mil>
 <AANLkTil9jA8Dva_KqW67c1ZgWk9_a5S1rBViui8Jn0Os@mail.gmail.com>
 <fVE942wHC3SFihkQG8AthPTKiTZtYJ9zmR2TT7F5OlkGD4IA9xPcMA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 18:38:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObFpz-0008Ie-II
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 18:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758620Ab0GTQi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 12:38:29 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55447 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758192Ab0GTQi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 12:38:29 -0400
Received: by qwh6 with SMTP id 6so2190414qwh.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1M1mdxw5V3eW0IuZhDFUgBArr21h4hq5g4fAQgvsIFE=;
        b=BdfrGm367+ZCwOGIJlMRMZ/RdoqvM61wirl5YpgeOm12L/a9+Jn8LTLE2SLuVoC0x+
         dL3ETLnmfrrFXavxPioej36X3CHBlSFO+STN24g3AHBb55U69jrbTbeen2eO9a+KGikv
         XcUL8lf00BYZA4ugYX1VMa6OZBLnoTqPiGrYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CxE2b7JEGcMO8JRCqOiNhfy6KuEmO36caexmo9sDP2dggczqvpAvsDlqpNxaNiJCv0
         8GVfxONSIoiW/3maF7wyLHC6NQxHTBYzfyFwceWOwaB/RpJ3PdDYLu0mSLBSm1s2m4gT
         qrURoUQZGRiTL1tdgB8Dd22yBRtTZqCe+pmFI=
Received: by 10.224.60.211 with SMTP id q19mr6419373qah.88.1279643907293;
        Tue, 20 Jul 2010 09:38:27 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id g33sm28198827qcq.28.2010.07.20.09.38.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 09:38:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <fVE942wHC3SFihkQG8AthPTKiTZtYJ9zmR2TT7F5OlkGD4IA9xPcMA@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151328>

On Tue, Jul 20, 2010 at 11:32:33AM -0500, Brandon Casey wrote:
> I think you have misunderstood the explanation of test_must_fail.  The
> paragraph you quoted actually recommends using test_must_fail instead
> of "! <git-command>".
> 
> It says:
> 
>    Use this instead of "! <git-command>" to fail when git commands
>    segfault.
> 
> Or with a slight rewording:
> 
>    Use test_must_fail instead of "! <git-command>" since test_must_fail
>    will fail when <git-command> segfaults.

I think the wording of description of test_must_fail is slightly
ambiguous. I read it to mean that:

    Use test_must_fail only when you are testing to see if git will
    segfault.

Rather than:
    
    Use test_must_fail to be safe from git segfaults.


Perhaps the description should be updated to be a bit more clear?
