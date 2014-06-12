From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 1/2] add strbuf_set operations
Date: Thu, 12 Jun 2014 16:14:17 -0700
Message-ID: <20140612231417.GA17803@hudson.localdomain>
References: <cover.1402557437.git.jmmahler@gmail.com>
 <f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
 <539960B8.1080709@virtuell-zuhause.de>
 <20140612082218.GA5419@hudson.localdomain>
 <xmqqmwdi55co.fsf@gitster.dls.corp.google.com>
 <20140612193642.GB17077@hudson.localdomain>
 <CAPig+cT_StMkTgEd-RVpm=4e_A23zj+V5k83PhMtaN=tr4GBzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 01:14:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvECO-0003VX-S6
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 01:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbaFLXOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 19:14:21 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:37284 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbaFLXOU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 19:14:20 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so1495383pbb.25
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 16:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kCIBsi4tqRdmA4wloDLllpWCL6199wzBeMBypRZoOpo=;
        b=k5NZXh1wqEziiNKnJWDWpvn2MwW7O2bPUHmvmMMvyRpamizAPjK4aA1lLdzW3cw98L
         fdvm5NbKbSDWL2eDfFecbXJgR6U5OJ1Xlx1RaTw6R+WjXyOnBucHlZyN5Ns6oxE5CwKN
         yvczpxz4gHRTeA0my7W+ctawtMp5HjAsBrLhkEh9jWNCC5wvIHTJ/cjxL/0vFDgDCOOi
         6mm2zee0HfpHiTT6yYnAC4DjL7a62XtOappPtKkeIV745dkCnXG1Pw2Z0YGOoripVo5z
         2kTTVjBRmMHzdlP+2GP5nFRnZrKKOAFkQzJQxyn6r5dQrtF7YvfqOkmenC4LkHQ27SeC
         3RDQ==
X-Received: by 10.66.254.166 with SMTP id aj6mr24952915pad.11.1402614859876;
        Thu, 12 Jun 2014 16:14:19 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id zc10sm11519609pac.46.2014.06.12.16.14.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2014 16:14:18 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAPig+cT_StMkTgEd-RVpm=4e_A23zj+V5k83PhMtaN=tr4GBzA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251504>

On Thu, Jun 12, 2014 at 05:18:29PM -0400, Eric Sunshine wrote:
> On Thu, Jun 12, 2014 at 3:36 PM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> > On Thu, Jun 12, 2014 at 11:51:19AM -0700, Junio C Hamano wrote:
> >> Jeremiah Mahler <jmmahler@gmail.com> writes:
> >>
> >> > Thomas,
> >> >
> >> > On Thu, Jun 12, 2014 at 10:11:36AM +0200, Thomas Braun wrote:
> >> >> Am 12.06.2014 09:29, schrieb Jeremiah Mahler:
> >> >> > A common use case with strubfs is to set the buffer to a new value.
> >>
> >> strubfs???
> >>
> > I was trying to make it plural.  Perhaps strbuf's?
> 
> Junio was pointing out your misspelling, not your intention to pluralize.

OK, got it.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
