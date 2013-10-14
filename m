From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Mon, 14 Oct 2013 16:35:50 -0500
Message-ID: <525c63b6711fa_197a905e845b@nysa.notmuch>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
 <20131014205908.GA17089@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 23:45:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVpxU-0001l0-I6
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 23:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757070Ab3JNVpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 17:45:44 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:46363 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614Ab3JNVpn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 17:45:43 -0400
Received: by mail-oa0-f43.google.com with SMTP id i3so5055303oag.16
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=iRVsWFMt+d/3pFGKzUgltkhBbIAVGc3Ck7ozsR0DNho=;
        b=HfEyHIRFsbEmallYXf4HJow0cpNFmsLRDjlenplpw5WDjDGKvXcpNXztnOctoCKJBs
         yiaa9wtHt0hECPm3t5bUPvwM2OTdsW11WGBl+4KXq53WqhgVF2OKD29Y+BeR9+Ue5iwU
         WppzNg6cG4jDsLMOmciy9+AWVxteJNYyk3WkiQMZ/pjJIp6vxmRGa6vPH7RIIlAzXLyr
         e4v91dpoBMOrL26AMFiObaznS2jQUuK91onlXqBcKLZWfNDfbfckdeHIiAr7b5e6T2A+
         64ONAg2xIHrr0C+8BSzVAMSalmhKwtYhLDAv7WV6UedDxhy3gJcBKEkFwMgSpXgpVbgE
         ZJJg==
X-Received: by 10.182.61.44 with SMTP id m12mr2735743obr.52.1381787142970;
        Mon, 14 Oct 2013 14:45:42 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm121550798oep.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 14:45:41 -0700 (PDT)
In-Reply-To: <20131014205908.GA17089@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236122>

Krzysztof Mazur wrote:
> On Sat, Oct 12, 2013 at 02:04:45AM -0500, Felipe Contreras wrote:
> > So that we can specify general modes of operation, specifically, add the
> > 'next' mode, which makes Git pre v2.0 behave as Git v2.0.
> > 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> 
> I don't think that single option it's a good idea. From the user's
> point of view I think that the way push.default was introduced and
> will be changed is much better. So maybe it's better to just add
> "core.addremove" option instead?

Maybe, but what happens when we start doing changes for v3.0? As a user, I
don't and to figure out which are the new configurations that will turn v3.0
behavior on, I just want to be testing that mode, even if I'm not following Git
development closely. If I find something annoying with core.mode = next, I
report the problem to the mailing list, which is good, we want to know problems
with the backward-incompatible changes that will be introduced before it's too
late, don't we?

I'd be fine with having *both* a fine-tuned option to trigger each specific
behavior, and another one that turns all those fine-tuned options on that are
meant for v2.0.

Unfortunately, I don't see much interest from Git developers in either.

-- 
Felipe Contreras
