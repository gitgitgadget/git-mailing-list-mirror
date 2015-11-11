From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 2/2] contrib/git-candidate: Add README
Date: Wed, 11 Nov 2015 15:15:54 -0500
Organization: Twitter
Message-ID: <1447272954.20147.36.camel@twopensource.com>
References: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
	 <1447160198-23296-3-git-send-email-richard.ipsum@codethink.co.uk>
	 <1447186751.20147.24.camel@twopensource.com> <20151111094816.GA2949@salo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Richard Ipsum <richard.ipsum@codethink.co.uk>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:16:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwboH-0005AD-Mo
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 21:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbbKKUP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 15:15:58 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33487 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbbKKUP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 15:15:57 -0500
Received: by qgea14 with SMTP id a14so31931804qge.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 12:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=C5X8zf2maF7eNwxt92rOqpdW5i8x/tMyyOoh73yU88U=;
        b=0qvkw/ICdG46iKjK9iOlU5xmG1+cmiJxxkr9tT7lUqDAn/2Rb8acjT6IYti+uOhph8
         kl/aXUEyic1x6PbuI2fp2LkNwGcYBG2GbTh7Yq+7fFj4fnUCrFM8sowuRHzp2VcHkZGP
         r2iCj2WFUkJKKSO/E2ceI0ryQXOP7Yb1L1zoveWD1KuXxaB1kNe0Uyz53peb2GIerhZ0
         76JX6bCRCF237zMxqQKGaH5K2dBqyfnd/WgQCODf04tNcKVGLsSlbXnoOdt5ixlF64JL
         PNJ+qHaJ8+l+ryoA4XCjK8va6i1LjIUpaHuRUiwvY/UCmX5JGe0/kXMpjEbNlgbMge9I
         fkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=C5X8zf2maF7eNwxt92rOqpdW5i8x/tMyyOoh73yU88U=;
        b=DmTZIGM3eRmXRw7GrMkuBULARFnexhmKi9KNRZbnH383b6F4N8I1DFKAqryhEj9OEE
         vRjuOOpRsTWfftckjVT3kSrNca0pUO+IixlRPHWu19Ts7EWhQI+SFQH72PR24Tqt8HJ5
         HaN+OfduJHI7W6DJJyD6eYTmEd6a/lzwyWSDw4KIvbA0PuE+CT3+VYhhXYYDwm8cKL2W
         5zJ7uoVL7u2b/prVHy7vbtsYeSJQ1GZ+vBBFtShMl7BV/nvXf6PGb6fmoszGo5vl/pkU
         eu3jUAPoAzrM+VA1HORajhNK1k6rJegF/K3kzpznLA40eK1aHpaaA8AtkgnABQXuNUAv
         LT2w==
X-Gm-Message-State: ALoCoQlGKAbkgJw/zBRxGb4eAaN9LrvKhGkWErgZL+Cz0Ol6bvmMYB3JeYMwvlAO2cr0kxsJmh/r
X-Received: by 10.140.97.34 with SMTP id l31mr12467118qge.30.1447272956572;
        Wed, 11 Nov 2015 12:15:56 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id j106sm3236439qge.3.2015.11.11.12.15.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Nov 2015 12:15:55 -0800 (PST)
In-Reply-To: <20151111094816.GA2949@salo>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281195>

On Wed, 2015-11-11 at 09:48 +0000, Richard Ipsum wrote:
> > 
> > > +	(master)$ git candidate submit origin archiverepo
> > > +	Review added successfully
> > 
> > Is the contributor automatically (optionally) emailed on this? If not,
> > consider this a feature request for this.
> 
> There's no server integration of any kind at the moment,
> this is clearly something we will want to add.

I don't think this needs server integration.  It could just work like
git send-email and send the email from the local machine.

> > "git candidate diff" might be nice too to show the diff between v1 and
> > v2.  You might even have "git candidate commit-diff" (or some better
> > name) so you can see which commit has changed in a changeset containing
> > multiple commits. 
> 
> Yes, we definitely want that. I think "git candidate diff" to diff
> between revisions would be sufficient, and it could take a list of files
> to diff as an arg?

That's a good start, but often I want to review per-patch, so it would
be nice (if complicated) to track the evolution of a patchset.

> > > +	(master)$ git candidate review origin/archiverepo --vote +2
> > > +		-m "Looks good, merging.  Thanks for your efforts"
> > > +	Review added successfully
> > 
> > Is that +2 "+1 because I like it, +1 because I previously -1'd it?" If
> > so, it might be nice to have --replace-vote so you don't have to track,
> > "wait, I did -1, then +1, then -1 again..."
> 
> Votes are per-review, perhaps they should simply be per-revision?
> Then --vote sets the vote for the revision and there's no need for
> a --replace-vote option?
> This would use user.name and user.email as identification.

I like votes being per-revision.

> > > +	(master)$ git candidate submit origin archiverepo
> > > +	Candidate was submitted successfully.
> > 
> > I don't understand what the verb "submit" means here. Is it "mark this
> > as accepted"?  If so, "accept" might be a better word.  
> 
> I'm tempted to change this to 'push', 'submit' comes from gerrit.

SGTM.

> > > +	(master)$ git merge candidates/origin/archiverepo
> > 
> > I would like "git candidate merge" to do a submit+merge the way that
> > pull does a fetch+merge.  It seems like the common case.  Also, if it
> > turns out at this point that there's a merge conflict, I might want to
> > back out the acceptance.
> 
> There is currently no git-candidate-merge, I removed this recently
> because I decided that you can merge candidates with git-merge
> and that this is more flexible. Often a candidate will be rebased
> before it is merged, it would be nice to avoid having to create
> a merge command that needs to handle all the different cases for
> merging a candidate.

I like the convenience, but it could always be added later.

One more random note: it might be nice to have a Documentation/technical
article describing review storage.
