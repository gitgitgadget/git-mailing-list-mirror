From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
Subject: Re: Workflow Help
Date: Tue, 21 May 2013 09:07:50 -0400
Message-ID: <20130521130748.GA634@google.com>
References: <CAMATmi3bU7hrD-YLY1iVXbekxOx_XZfZ5yYNBfzV_VFSc_W5jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Quilkey, Tony" <trq@thorpesystems.com>
X-From: git-owner@vger.kernel.org Tue May 21 15:15:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UemPh-0003I9-Hy
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 15:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465Ab3EUNPd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 09:15:33 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:59416 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439Ab3EUNPd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 09:15:33 -0400
Received: by mail-qa0-f74.google.com with SMTP id bs12so63144qab.3
        for <git@vger.kernel.org>; Tue, 21 May 2013 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uVQWkFsaN96pL32Y9R/yWSj9G3juas0EZjVRIjQbWa8=;
        b=ihfZPUXZL9UH2avbRc/KsVbVyvQXxU9MplW6mJQ9xJEJFeCcW+LH8ZacHyVXe7zPwY
         TA/Lo6FPLvd2vthRXfven1NJAGK4xDBKZS+EvQ4PRtKvD9UPYsc7Zb6q2m9JjTXe8ln9
         aPjXZCJyCKrw7gW3t4V3BDtc+W1QYhpzLicYgvwPRX1C5APee2PElguxV4v4VSAU9BXg
         TKGdne9ncgwp/1uwaoBOZ7X8WZ6AVC40tClaR0iP6bZEAUOl5z9cUuG1KD77hIz2z6zu
         BPP2tQHzs9wnDsKbK4c+lxHkXP2JIOf7QGc2vYP4ThEQbPI6GX/4AHJfGsJ8QHX3N4Q0
         3EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent:x-gm-message-state;
        bh=uVQWkFsaN96pL32Y9R/yWSj9G3juas0EZjVRIjQbWa8=;
        b=EMf4GulhFguU+nVWC3eM5sZBiI5IAp/g0YklcOpK1/6+xL4fQSMVI91KxOcPJzBsJP
         afoj/GhZCNANp4c440zJQbZRicT2rm4uYg/KP3JYehsN1NqZKO51Qp5x2Ebit0SJGfdX
         sED878IG2xT2y5qR8n8kN2J6bNVRTlyPn/+caE7qTqH40kcPmzf1KR5GatMo1CdV5hRg
         JEKUmEZ4qU/c79BjtvOLHMisH21p+VaLeu/yGaxNDPQEryCZ+HhIUnt+y+V3tN7lYELj
         m1eQquPkobVZ0cQXnSeP5K8mUGm1s84DVFf0FM7PX+a4c1sRGkDBlc4ioS03eSDf9Xu9
         MIjQ==
X-Received: by 10.236.14.233 with SMTP id d69mr1045799yhd.51.1369141670906;
        Tue, 21 May 2013 06:07:50 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n23si225677yhi.7.2013.05.21.06.07.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Tue, 21 May 2013 06:07:50 -0700 (PDT)
Received: from valle.nyc.corp.google.com (valle.nyc.corp.google.com [172.26.78.170])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C86355A4082;
	Tue, 21 May 2013 06:07:50 -0700 (PDT)
Received: by valle.nyc.corp.google.com (Postfix, from userid 159662)
	id 3EA2240911; Tue, 21 May 2013 09:07:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAMATmi3bU7hrD-YLY1iVXbekxOx_XZfZ5yYNBfzV_VFSc_W5jw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQmdII6dSF52gWLwoIklkPRccple+Cd2H7Er/Cn0JW7O4n5HETCcfH+f12bslxYJknj91SD4jQU//PDVqwoDi6l7ffF+2fY1F/raSmBE79udxh4Ja+Hy92b5OqOrxgIPBG43rA7YQhbFUUNH1ZaVHoSTI00u9eAKXrKFvlg7hA00k64LxFWqyJA4T4eQlDTdTMpDpWW0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225030>

On Monday, May 20, 2013 at 20:59 EDT,
     "Quilkey, Tony" <trq@thorpesystems.com> wrote:

> I am looking at formulating and then documenting our vcs workflow
> using Git at work. I have an idea of how I want things to work, but a=
m
> a little hazy on some of the details.
>=20
> Our basic workflow will be based around:
> http://nvie.com/posts/a-successful-git-branching-model, with a few
> exceptions.
>=20
> We would like to create our release-* branches from the last release
> tag. From there, we would like the ability to cherry pick (or take th=
e
> complete diff) commits from the develop branch.

It would probably be easier to comment on your proposal if you motivate=
d
why you want to diverge.

> So, we are after is:
>=20
> 1) Create topic (feature) branches from develop, and merge back into
> develop when complete.
>=20
> 2) Once it is decided we are packaging a release, make a release-*
> branch from the previous release tag.
>=20
> 3) Cherry pick/merge/whatever any commits we want from develop into
> the new release-* until it is complete.

The point of having a release branch is typically to slow down the
development pace and reduce risk by only adding changes that you
really need. By starting the branch for release N+1 from the branch
for release N it seems you have three ways forward:

   - Cherrypick a small number of commits from develop. That'll give yo=
u
     release N+0.1 rather than N+1.
   - Cherrypick many (if not most) commits from develop. That might giv=
e
     you a real release, but with a lot of work. Who should select whic=
h
     commits to cherrypick? How do you keep track of dependencies? Why
     would you want to move from a known state (develop, where people
     spend most of their time) to an unknown state?
   - Merge from develop to the release branch. What's the benefit
     compared to cutting the release branch directly from develop?

As another poster has pointed out, with merging instead of cherrypickin=
g
the standard Git tools will be able to do a better job at helping you
track which corrections are made where.

[...]

--=20
Magnus B=E4ck
baeck@google.com
