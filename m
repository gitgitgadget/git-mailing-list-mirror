From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] run-command: add an asynchronous parallel child processor
Date: Wed, 30 Sep 2015 11:48:32 -0700
Message-ID: <xmqq4mib920v.fsf@gitster.mtv.corp.google.com>
References: <1443482046-25569-1-git-send-email-sbeller@google.com>
	<1443482046-25569-7-git-send-email-sbeller@google.com>
	<xmqqa8s4a9cw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 20:48:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhMQh-0004Ht-Rc
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 20:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933404AbbI3Ssg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 14:48:36 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34416 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932875AbbI3Sse (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 14:48:34 -0400
Received: by padhy16 with SMTP id hy16so48306714pad.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RCfgG8A9Dc+JWwsE/OWII3jyUeQPg67Y7GI3w9Wn880=;
        b=VaDWoe56o8wXiI+SdimrTbH3Y5YBhSRMGAP3/Ye60NeE72CA4LJQm+ydWKYUyawpwc
         m6+JD717k8G2/462wi6mTXj2NJwryM2mCW//V28WlqFxdomwBA1EBALzR3lPVrruo8oL
         HyrBEBwO/axuAAoXcFj+fItozTpFH6jN+hTdymwS5qBxoLKmlACwZKIlNg3R2cgWBnyY
         lW1dKDjupLPI4aMh5iDyaO0NqSWZ9m8JYsm9GLG8X6qimBRkTfDPdNEi4SOiTS0eslDY
         B06S2UthTncq7Ba8IPyLPOfgLxgmFFcAwqegamMtidjGJkMwY8aoFOImKyFE1/FwuSNa
         3WFw==
X-Received: by 10.66.218.131 with SMTP id pg3mr3234799pac.24.1443638914303;
        Wed, 30 Sep 2015 11:48:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2c4a:a656:af73:8140])
        by smtp.gmail.com with ESMTPSA id ce3sm2074650pbb.35.2015.09.30.11.48.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 11:48:33 -0700 (PDT)
In-Reply-To: <xmqqa8s4a9cw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 29 Sep 2015 20:12:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278852>

Junio C Hamano <gitster@pobox.com> writes:

> I may have comments on other parts of this patch, but I noticed this
> a bit hard to read while reading the end result.
> ...

I finished reading the remainder.  Other than the above all look
sensible.

Will replace what had been queued.

Thanks.
