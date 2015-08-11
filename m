From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] config.mak.uname: Cygwin: Use renames for creation
Date: Tue, 11 Aug 2015 11:05:27 +0100
Message-ID: <20150811100527.GW14466@dinwoodie.org>
References: <1438979428-5888-1-git-send-email-adam@dinwoodie.org>
 <55C66AF2.3060706@gmail.com>
 <20150808210627.GB155450@vauxhall.crustytoothpaste.net>
 <CA+kUOa=KRBSKDqWUj2RiO45PqVYGmN+yqG426jtUoXayxGkduw@mail.gmail.com>
 <058a7756ada2fa5043ca9b910d6e1543@www.dscho.org>
 <55C7883C.7040504@dinwoodie.org>
 <xmqqwpx3t102.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 12:05:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP6R8-0007as-8K
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 12:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934243AbbHKKFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 06:05:34 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34764 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbHKKFc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 06:05:32 -0400
Received: by wicne3 with SMTP id ne3so169818338wic.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 03:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/4d4VV6M35268X7F9OUOdf8+44bqICKmThNRLjjakCE=;
        b=OoJKYM/1J1Tlq/MNSZ4plEdoX2Fz5GEzVy9yL58OMjThMb4iKPqc+7la6iBD0c1VaB
         mLXwRhkt+/cjC2RiJPXUEoDf0rhHvqVWyLPfxVGj+1JgObqH5r4WsVpeiSptCY2abXhu
         B5hQ68rVqf6j5rwQYFUq20yemjW4wOrk9Ckug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/4d4VV6M35268X7F9OUOdf8+44bqICKmThNRLjjakCE=;
        b=V5I8eb+icjwwmIb+sp/bvLbU/ztrfiWxghiL0DHXl7MLlm0Ofcw83+mMzp1XAqDk4A
         cdrEsvdpJZK9pjp5dA0EcMblwBF5hZ3WdADTD1mH3yQIcVy6dMhAFJiFYXhLYFt9kEo9
         gvZO+7O/K3B7bG3YWLgv/ZbMQN2bqfGA77NAs+aYnkwI73fYZLLGQ8qumfgdIvAFmwhx
         GtoPvlDI9hb4GDs2xwmxUITJTvF1ygsX2ExyF0HAGzJK2+vddNoZvopwA1LLaSKVTLsu
         GjXKOPcl1o82qmoWQJht+UsQFVBVQYA+JFf5FSpSkuOjbEZOoQk1kcnDpg88KQY7tCJ3
         Fkrg==
X-Gm-Message-State: ALoCoQmAx9s+InUVz72EloY5CAOgCWaFko836eDXOSqI6nvHFc20RgNKMVD+349sXOA8JAHzA2Io
X-Received: by 10.180.20.15 with SMTP id j15mr34931555wie.76.1439287530975;
        Tue, 11 Aug 2015 03:05:30 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id ub19sm18129254wib.8.2015.08.11.03.05.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 03:05:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqwpx3t102.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275680>

On Mon, Aug 10, 2015 at 12:08:29PM -0700, Junio C Hamano wrote:
> But in the end, I'd prefer the choice of the compiled-in default up
> to the port maintainers.  You earlier said:
> 
>     This problem was reported on the Cygwin mailing list at
>     https://cygwin.com/ml/cygwin/2015-08/msg00102.html (amongst others) and
>     is being applied as a manual patch to the Cygwin builds until the patch
>     is taken here.
> 
> so my preference is to see Cygwin continue to do so for a couple
> release cycles of ours to make sure all Cygwin end-users are happy
> and consider the flip of the default a good change for them, and
> then the official Cygwin packager of Git sends a patch our way.

Wait a few releases then resubmit assuming we've not had complaints from
Cygwin user.  Okay!

> https://cygwin.com/ml/cygwin/2015-08/msg00102.html seems to indicate
> that somebody called Adam Dinwoodie is wearing Git maintainer hat,
> so perhaps you may be that "official Cygwin packager of Git" ;-)

That would indeed be yours truly :)

> I agree with everything you said in that message to Peter---the
> patch should be included when you hear reports of `git config
> core.createObject rename` helping more people.  After versions of
> Cygwin Git package with such a change proves good, let's reduce the
> workload of Cygwin Git maintainer by upstreaming that change to my
> tree.  But not before.

Cool.  FWIW, the reason we've started applying this patch to the
downstream Cygwin builds is that I've now seen a number of reports
(primarily on Stack Overflow) of this problem where that config change
has fixed things.  I'd been holding off until I had those extra reports,
but now I have them I made the patch and figured I'd submit it upstream
at the same time.  As above, I'll wait a while until we're happy it's
stable, and resubmit at that point.

(On which note, I should probably submit the patch to the git-gui
Makefile we've had in our builds since back in v1.7.9, before I took
over the maintainership, since that one clearly is pretty stable...)

Thanks!
