From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH/RFC 1/7] reset: rename update_refs to reset_refs
Date: Thu, 29 Aug 2013 14:07:56 -0400
Message-ID: <521F8DFC.9090506@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <e2d48324726825844c209e4ca544b5c20ffeb11b.1377784597.git.brad.king@kitware.com> <xmqqy57k5sca.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:09:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6f7-0005nX-55
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110Ab3H2SJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:09:37 -0400
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50874 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755152Ab3H2SJg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 14:09:36 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]) (using TLSv1) by na3sys009aob110.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUh+OYHn2x5eGdhv5kVJdTUF/3G3ltAcd@postini.com; Thu, 29 Aug 2013 11:09:36 PDT
Received: by mail-ob0-f175.google.com with SMTP id xn12so869457obc.34
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=MU5+RVjiSokFiIH7BF4XpJxJQlUsrvJGKMar7eriQko=;
        b=CWENljSZZtopnNBHRTAyyP/t4q4QhsAVOS0DyiYSxaEWeixMIsCRhymcTa0TvDBwEt
         Pwu/hEn+V19GZDn/+3uDxR8G/gWp0rg+cCT0TO2oXThIDnqa3zivyZZpQ/WO+J9U5RuC
         TSm5KehYPfk0rHfbSzQuuuMIbAurt5AYG2GfUNmc1nrYt2dA4+Hiaxe5cS0tVuWmnhaa
         LE2JUGCy6C2n1+mQBhAckF0kB0O3IxPPOZ+r2YLVDT+/7GPxGoLd9jhoVHl0eMT6MoL1
         93xywAYBKiLBAnEVd0ZiBtJLXfK7pFI8EfmAdixkXTzXF+4AC968ABvPAPTCgqlu83La
         sFCw==
X-Gm-Message-State: ALoCoQmlFl87/swY3nPxgPUUDxjWSQpkQWcL5s5rdyVUvyTMvnyTjj+lScDGMnAFtRtP+22RDfZQnJ+AHygTLMuom98QHg/cu6M2pyDjxU6JF3gHmw45JLroTUf6EM+9nQgof4qD+J9f6q5NeceMhpHUf3sQvbw8gw==
X-Received: by 10.182.131.196 with SMTP id oo4mr3475245obb.50.1377799775665;
        Thu, 29 Aug 2013 11:09:35 -0700 (PDT)
X-Received: by 10.182.131.196 with SMTP id oo4mr3475239obb.50.1377799775595;
        Thu, 29 Aug 2013 11:09:35 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id qi5sm32641558obb.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:09:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqy57k5sca.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233297>

On 08/29/2013 01:17 PM, Junio C Hamano wrote:
> Brad King <brad.king@kitware.com> writes:
> 
>> Get it out of the way for a future refs.h function.
> 
> Readers do not know if "update_refs()" is a good name for that
> future refs.h function at this point, so "evict squatter" is not a
> very good justification by itself.  I do agree that this static
> function is resetting a ref, not doing an arbitrary update, and the
> new name is a better match than the old one for what it does, though.

Okay, I've revised the commit message for the next revision.

-Brad
