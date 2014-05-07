From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 07 May 2014 14:01:29 -0500
Message-ID: <536a83097302f_76ff7a52ec6c@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 21:12:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi7GP-0004XZ-Gl
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 21:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbaEGTMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 15:12:17 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:35238 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbaEGTMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 15:12:16 -0400
Received: by mail-oa0-f43.google.com with SMTP id l6so1814315oag.2
        for <git@vger.kernel.org>; Wed, 07 May 2014 12:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=H4OyRyg45iIl9uTQ/E7dcuarK7QvDJN+ZNG3Nc1ob18=;
        b=esgE9OTV/bulWcSrGqKdAjTO/XvVdUQPdA/pPBqtMb4IXe/KqHqEQ8bAqW+lP59YIC
         Mwmu/i1J3fe61AOzOwUenh2uZbPL9rNIDXcCYPpnPkxEhIW+lOS4ObsHPROVzStkRKF8
         aSOwEQ9yu0mL7dcutxNj38UU2bxZrSj3Th1N8rkIm5TfZ6/KaI9ZAs/Nr4D+J4RIKxdO
         3qTprxMrS8Ogijc2ZKfg0q55pwbF8EtIP9Bf1sDCVh/2+dMyCWgqRUpU9s2Sc+TunY3s
         5zjIBzLImI8yCv7K8yYm8qPkewihhtk/cOREKmII3MOcJNRndaCNM7Vm1rDXRWr1C3re
         0vtA==
X-Received: by 10.60.146.201 with SMTP id te9mr48312419oeb.38.1399489936390;
        Wed, 07 May 2014 12:12:16 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zm8sm36212345obc.16.2014.05.07.12.12.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 12:12:14 -0700 (PDT)
In-Reply-To: <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248348>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Here's a bunch of tests more, and a fixes for Mercurial v3.0.
> 
> I think the discussion with John Keeping hints that we shouldn't be
> rushing fc/remote-helpers-hg-bzr-graduation

Really? Based on what reasoning? I have proven his reasoning to be
basically wrong.

> I'll queue this separately on a topic based on the tip of
> yesterday's master for now.
> 
> One thing I couldn't read from the proposed log messages was if this
> is meant to work with and tested with both v3.0 and pre-v3.0 Hg, or
> this is to request others who run pre-v3.0 Hg to test these changes.
> 
> For example, I see
> 
> 	from mercurial import changegroup
>         if check_version(3, 0):
>         	cg = changegroup.getbundle(...)
> 	else:
>         	cg = repo.getbundle(...)
> 
> and offhand it was unclear if the unconditional import was a
> mistake.

Of course it wasn't a mistake.

-- 
Felipe Contreras
