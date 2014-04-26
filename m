From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #08; Fri, 25)
Date: Fri, 25 Apr 2014 20:36:55 -0500
Message-ID: <535b0db7e5e31_ba2148d310f4@nysa.notmuch>
References: <xmqqoazpt45p.fsf@gitster.dls.corp.google.com>
 <20140425231953.GB3855@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 03:47:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdriE-0002wx-9o
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 03:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbaDZBrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 21:47:25 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:50647 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbaDZBrY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 21:47:24 -0400
Received: by mail-oa0-f53.google.com with SMTP id j17so5103413oag.12
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 18:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=kw3gbtMSH5iFV2iaDeuD83G9+8VRxXbo4dnrBA6mwW4=;
        b=k3FwEaH1KALEOuKn8bwY8tEvx1Ab+mvJ3dI5OfZoVVWrbtZKYO8eRu6KPttzH6UARr
         wcK3f9TYu44glcLWI2gQTOoZM2te2t6BQS44hKhkXGrnQH4RPNywLI5vR7svm1SteZ8a
         bVI6Q/HV4hgcCbEFTPA26jp4/sNTDuLM+oPvXL2weJF2rXFG/dhiEVqr8cjpvEgFyMd4
         LxlSISGH41lDpWTJWnc1aWlOAAHb8ObrglCDBOieU1MUnbI0T6wBvuMtpUzls4TMEdMd
         oNc2+ZQvDpZQZsB9CFj2jSHcKSoKm3/MfyTKJRwrGDnBDYnmo9yroVQ6uFFf2PkBoCZx
         FWOA==
X-Received: by 10.182.29.225 with SMTP id n1mr9993276obh.2.1398476844468;
        Fri, 25 Apr 2014 18:47:24 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d9sm39148935oen.3.2014.04.25.18.47.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 18:47:23 -0700 (PDT)
In-Reply-To: <20140425231953.GB3855@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247141>

Jeff King wrote:
> On Fri, Apr 25, 2014 at 03:50:26PM -0700, Junio C Hamano wrote:

> > * fc/publish-vs-upstream (2014-04-21) 8 commits
> >  - sha1_name: add support for @{publish} marks
> >  - sha1_name: simplify track finding
> >  - sha1_name: cleanup interpret_branch_name()
> >  - branch: display publish branch
> >  - push: add --set-publish option
> >  - branch: add --set-publish-to option
> >  - Add concept of 'publish' branch
> >  - t5516 (fetch-push): fix test restoration
> > 
> >  Add branch@{publish}; it seems that this is somewhat different from
> >  Ram and Peff started working on.  There were many discussion
> >  messages going back and forth but it does not appear that the
> >  design issues have been worked out among participants yet.
> 
> If you are waiting on me, I do not have much else to say on this topic.
> @{publish} as specified by Felipe is not useful to me, and I would
> continue to pursue @{push} separately as "the remote-tracking branch of
> where you would push to". I think there is room for both concepts.
> 
> As for the patches themselves, I have not reviewed them carefully, and
> would prefer not to. As I mentioned before, though, I would prefer the
> short "@{p}" not be taken for @{publish} until it has proven itself.

Presumably you want to save it for @{push}. While I'm not against to having
just @{publish} for now, I'm farily certain most people would be using
@{publish} and not @{push}, as that's what `git branch -v` would show, and it
would be closely similar to @{upstream}. Therefore it would make sense to use
@{p} for @{publish}

-- 
Felipe Contreras
