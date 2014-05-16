From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Fri, 16 May 2014 07:20:44 -0500
Message-ID: <5376029cc3c92_65ebfe530844@nysa.notmuch>
References: <CACPiFCKpx9e-swWW4KEfY9YkG7s0uPTs_aftV-NbXGkvMqtf-A@mail.gmail.com>
 <53729ccf26bb0_34aa9e53047f@nysa.notmuch>
 <CAGK7Mr63X3+XXuRUEcBwwnwrOrbip8VUebtL-tM3R8PYBPEXuQ@mail.gmail.com>
 <5373c56c5c531_56d6e3b30449@nysa.notmuch>
 <xmqq38gcjcuw.fsf@gitster.dls.corp.google.com>
 <5373fc12bc5e4_7411589304eb@nysa.notmuch>
 <xmqq38gad51x.fsf@gitster.dls.corp.google.com>
 <5375c7934ccc6_7e7b772f8d5@nysa.notmuch>
 <20140516085929.GA546@wst420>
 <5375e6b0f45c_1a1b8d33080@nysa.notmuch>
 <20140516112517.GB546@wst420>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: William Giokas <1007380@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 14:31:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlHIm-0008MJ-NK
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 14:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbaEPMbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 08:31:48 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:60424 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932345AbaEPMbr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 08:31:47 -0400
Received: by mail-ob0-f175.google.com with SMTP id wo20so2853955obc.6
        for <git@vger.kernel.org>; Fri, 16 May 2014 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=IMFxUba/FzHoQx8yKKspex+l5C2PeSSNZX90ROlzgc0=;
        b=FxzH4IMpZSgGqNxBZLfIHOHHBxTLVBzItSM2PBwmghF1+5bZmvdp6VhMFS9dQrFiE0
         ATSufVLxc1n5sbgN2zfJ9OGouDRR9Zw6lKF5tLREAwEBiV/5iWf6FbFO5jfOVZd4ZG6o
         QHJ4s09zNeXf76KMarVzv3M/m05GqWkZop9LBEqFBF3S1lZJO7MOCHCL9GcVoYcV3QeK
         wGiFqwf65n1krne9IVaHd8jJDm0CoXMmNlw/mgY7MTDkiOenys5/RFKog7rnPRcfORqz
         moLmdUok2SEX6aVb2MBLvu3u3xFIY288eD3fo6qe3Y5wffmpQp7t1jEXBnyiRPMi1gdd
         8+hQ==
X-Received: by 10.182.78.100 with SMTP id a4mr16892841obx.56.1400243507328;
        Fri, 16 May 2014 05:31:47 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id b9sm4405501oel.4.2014.05.16.05.31.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 05:31:46 -0700 (PDT)
In-Reply-To: <20140516112517.GB546@wst420>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249298>

William Giokas wrote:
> On Fri, May 16, 2014 at 05:21:36AM -0500, Felipe Contreras wrote:
> > How exactly would it be better?
> > 
> > If you concede that the Git release wouldn't be affected, then assuming
> > a hypothetical future where git-remote-hg is bundled, and we have a
> > Mercurial API breakage, we would have:
> > 
> >  Git < v2.5 fail, Git >= 2.5 get the fix
> > 
> > If we unbundle, we have:
> > 
> >  git-remote-hg < v0.5 fail, git-remote-hg >= v0.5 get the fix
> > 
> > What is the big difference?
> 
> It's a matter of scope and where the releases happen, that is all.

Of course the core vs. out-of-tree question is a matter of where the
releases happen. The question here was: in which way is out-of-tree a
better place?

If it's a matter of scope, that is; should a foreign vcs interface tool
be bundled in the Git core? Then that question applies not only to
git-remote-hg/bzr, but also git-p4, git-cvs, git-svn, and others.

The answer to the first question seems to be; it's not at all clear (in
fact there doesn't seem to be any valid argument in favour of
out-of-tree). The answer to the second question is; we are not asking
that question right now (for the moment foreign vcs tools should remain
part of the Git core).

I started the graduation series by saying "there doesn't seem to be any
good reason not to", and Junio agreed. Now Junio doesn't agree, but it's
till the case there's no good reason not to.

-- 
Felipe Contreras
