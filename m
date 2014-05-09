From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #08; Fri, 25)
Date: Fri, 09 May 2014 12:07:36 -0500
Message-ID: <536d0b58b3803_693d7fd30c5e@nysa.notmuch>
References: <xmqqoazpt45p.fsf@gitster.dls.corp.google.com>
 <20140425231953.GB3855@sigill.intra.peff.net>
 <536D080C.7030402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 09 19:07:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WioGv-0000sJ-O7
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 19:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbaEIRHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 13:07:42 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:46270 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932259AbaEIRHl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 13:07:41 -0400
Received: by mail-yh0-f53.google.com with SMTP id i57so1747803yha.12
        for <git@vger.kernel.org>; Fri, 09 May 2014 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=n8cVSAgtELR7obTLT/z+dTndbbrv2BXjFlNppqydahw=;
        b=B83drMQTBZjKYGvSaIEkKMxsG2Twh/uXvhIX3+hSC3DmaxAQ+9aI2lCnWAssrQeRVg
         ZcQfEuL28CcuXpEu+qpD0Et2r+1sU4DsLPDbMkLCQy+oBYzS9eaau9ng5JGRRf3m9aSL
         TIPaU3Scg8QE/tesmOQhWEiRoKC7BzHFNIpkedVHpzV/jlIx7rzpn1nDlNxOW3k92iZJ
         YIsZ7BikGipqC4Q+WNBs7l/Q7zkei5Sk+BU9hQ8niK88czTSucG8lzeG6HxFuj+4LL8y
         GVlJmk5MjzmbUszarWDxf/7BLpFp6w6yNZWBWwAQj9pgncN2fF58KlBXESnK4OFAWhiW
         X1uA==
X-Received: by 10.236.128.180 with SMTP id f40mr16584351yhi.71.1399655261052;
        Fri, 09 May 2014 10:07:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f2sm6948415yhc.41.2014.05.09.10.07.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 10:07:39 -0700 (PDT)
In-Reply-To: <536D080C.7030402@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248588>

Michael Haggerty wrote:
> On 04/26/2014 01:19 AM, Jeff King wrote:
> > On Fri, Apr 25, 2014 at 03:50:26PM -0700, Junio C Hamano wrote:
> > [...]
> >> * fc/publish-vs-upstream (2014-04-21) 8 commits
> >>  - sha1_name: add support for @{publish} marks
> >>  - sha1_name: simplify track finding
> >>  - sha1_name: cleanup interpret_branch_name()
> >>  - branch: display publish branch
> >>  - push: add --set-publish option
> >>  - branch: add --set-publish-to option
> >>  - Add concept of 'publish' branch
> >>  - t5516 (fetch-push): fix test restoration
> >>
> >>  Add branch@{publish}; it seems that this is somewhat different from
> >>  Ram and Peff started working on.  There were many discussion
> >>  messages going back and forth but it does not appear that the
> >>  design issues have been worked out among participants yet.
> > 
> > [...]
> > As for the patches themselves, I have not reviewed them carefully, and
> > would prefer not to. As I mentioned before, though, I would prefer the
> > short "@{p}" not be taken for @{publish} until it has proven itself.
> 
> Is it too late and/or impossible to think of a different name for either
> "push" or "publish" so that their single-letter abbreviations don't
> coincide?

I'd say given the fact that this has been in the works for a long long
tie and nobody has proposed a better name. Yes.

One reason I think @{p} makes sense for publish is:

  % git push -u, @{u}, @{upstream}
  % git push -p, @{p}, @{publish}

-- 
Felipe Contreras
