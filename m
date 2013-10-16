From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Wed, 16 Oct 2013 14:28:21 -0500
Message-ID: <525ee8d5ba989_3983c19e7c8b@nysa.notmuch>
References: <20131014205908.GA17089@shrek.podlesie.net>
 <525c63b6711fa_197a905e845b@nysa.notmuch>
 <20131015123505.GA3097@shrek.podlesie.net>
 <525d35e766ad4_55661275e7426@nysa.notmuch>
 <20131015133327.GA22723@shrek.podlesie.net>
 <525d4354a5436_5844e73e843d@nysa.notmuch>
 <20131015145139.GA3977@shrek.podlesie.net>
 <525d8ebd19c67_5feab61e8037@nysa.notmuch>
 <20131015220125.GA14021@shrek.podlesie.net>
 <525e100e45ee8_81a151de74ed@nysa.notmuch>
 <20131016063436.GB24964@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 21:37:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWWts-00076q-53
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 21:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760842Ab3JPTgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 15:36:52 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:62814 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab3JPTgu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 15:36:50 -0400
Received: by mail-ob0-f178.google.com with SMTP id uz6so1010571obc.23
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 12:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=R3v2mLEC2OLPpkCJdfrM8Bw9iFC9319hATwwLT6jZh0=;
        b=Snb8JySd6azZbiXt0HJNQFiYJOYS0y18bPWNe81gr2eJxxtKtj8Cprn+hxM7NoV8mm
         BJ0CU45FLPdl0uL3/cRHEO47V6ZdwBb4kwDzv8eFOCRvwjy3to0fsXL8cD+c8jIAwDxx
         zbt2ArmNE2HB3aDUMOnEyrn42TUswcoSJ/SAhbzmRrlH7U4ftuqowoXidr2BjfJWazyr
         U9e+7C68azXXS71lcF1XtN5U31oI4P2MwKs3ZqDe4dChXLBqPSI5hqwZa+J/tZPrkMtc
         n1Wl0g/ADw4tjf0s7+W5IqzB3KENDNd80BioAZNIqk7Y2Kqpa+wB1lPg4I+4iq9KLvrT
         EHHQ==
X-Received: by 10.182.22.5 with SMTP id z5mr6219778obe.42.1381952209391;
        Wed, 16 Oct 2013 12:36:49 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm65332668obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Oct 2013 12:36:48 -0700 (PDT)
In-Reply-To: <20131016063436.GB24964@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236254>

Krzysztof Mazur wrote:
> On Tue, Oct 15, 2013 at 11:03:26PM -0500, Felipe Contreras wrote:
> > > not some "next" behavior that may change in future.
> > 
> > But I'm suggesting to add a core.addremove option as well, like you suggested,
> > am I not?
> 
> Yes, I think we both agreed on adding core.addremove. I'm just not
> convinced if we should also add core.mode.

If we add core.addremove, all the issues you mentioned are solved. If we do
that, now the question is, how exactly does core.mode = next affect anybody
genatively? If you don't like it, you don't set it, that's why it's a
configuration. I don't see the problem.

> > So you would be happy if we had core.addremove = true *and* core.mode = next,
> > right? You would use one, different people with different needs would use the
> > other.
> 
> Yes, if there are people that will use core.mode it will be worth
> adding. I'm just not one of them.

I am already using it.

-- 
Felipe Contreras
