From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 1/3] setup: Provide GIT_PREFIX to built-ins
Date: Thu, 26 May 2011 14:49:34 -0700
Message-ID: <20110526214918.GA22623@gmail.com>
References: <1306381034-44190-1-git-send-email-davvid@gmail.com>
 <7vfwo1xsn4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 23:49:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPiR5-0003K7-OE
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 23:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210Ab1EZVtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 17:49:39 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50519 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab1EZVti (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 17:49:38 -0400
Received: by pwi15 with SMTP id 15so523132pwi.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 14:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=aOD3yP8KstxLm0U1it5ZpW9CHbg6SY4IRVgnFcWCmx0=;
        b=r+njd09/p7qqoJA3RjoDPVLrZP301fIetD0INaUFHNuF0G8POeRl7kOqojBHOssHHc
         59EPvdoRZl5X18T5P2PU37JfAdcBftlRHJYXZZ99ikRAoh8bPLmPMyqENmPxvd2FiJqK
         6gSSW7nAoSrgszxDmW1VS+oM0pdfoF4KMZ+m8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LAlCkBWnvx8DgBWbdIYmAcxbEC806LGHtNQned7vCesw8oe7yEX+cBmudxPCNE7TIp
         87H90BuaoVPYxg9/mTohYsOCugwIXAIa59Mh4cZLM5WzL8rD1UzUhBw4divfxI/o/qZs
         1SLVXm4Ul1GWauz+W6II4FfxfrzRPklewoplU=
Received: by 10.143.21.9 with SMTP id y9mr192410wfi.444.1306446578407;
        Thu, 26 May 2011 14:49:38 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com [198.187.190.1])
        by mx.google.com with ESMTPS id d15sm454658wfl.6.2011.05.26.14.49.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 14:49:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfwo1xsn4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174579>

On Thu, May 26, 2011 at 10:45:35AM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > GIT_PREFIX was added in 7cf16a14f5c070f7b14cf28023769450133172ae so that
> > aliases can know the directory from which a !alias was called.
> >
> > Knowing the prefix relative to the root is helpful in other programs
> > so export it to built-ins as well.
> >
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> >
> > The original version of this patch did not set GIT_PREFIX
> > to an empty string when prefix returns NULL.
> > Now we do.
> 
> Thanks.  Should I add "Helped-by: MJG"?

Yes, that'd be great.
-- 
					David
