From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: About overzealous compatibility
Date: Sun, 19 May 2013 02:56:21 -0500
Message-ID: <519885a591924_7301727e144294f@nysa.mail>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
 <1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
 <7v61yi9arl.fsf@alter.siamese.dyndns.org>
 <CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
 <7v8v3e7udi.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
 <7vk3my6bu1.fsf@alter.siamese.dyndns.org>
 <CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com>
 <7vk3my33vb.fsf@alter.siamese.dyndns.org>
 <CAMP44s0J7vcxno=v9_ewUE6FcuRVuYQhCNVS8D+AvP6cG2XNfQ@mail.gmail.com>
 <7vtxm1xxvd.fsf@alter.siamese.dyndns.org>
 <CAMP44s3xdWzVviPvrN7D1fTG6Lwgg-dEzju--VuiwZA-8bV+MQ@mail.gmail.com>
 <7vtxlz1pr1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 19 10:05:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udycc-0004l8-DH
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 10:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab3ESIFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 04:05:05 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:62833 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441Ab3ESIFA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 04:05:00 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so6702908oag.31
        for <git@vger.kernel.org>; Sun, 19 May 2013 01:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=TkFroMVatBTj9lxBe0LaKmmxwzTKg2OWXj0Hu1Jr4y4=;
        b=s3W2MCL0F2K+neTXel0uTyR8zhnz78OfeaCSGbsc8iV1dqIPEevg8e54w7r62NFptL
         S/QV64ExzJqRrpP5nvSsncHVZsbR8DTuaP7VItkUJSgJnGCEx45VpTv79uzXxBhul9Jv
         O4l6qFg+g+UpDX6f72Q4NdS4IjzMGbecDgDBQMVuqTWQWsNc04JIR/gv6iQzFA0SCp5l
         WwHH2vct2BXjxUW2yKMzNqJPJ+9fj3SoiEaCV9cKPqty/mxaDHlMUnRB+2Po2sNvbQpY
         U2HKq5X/GIzSVWLw59bnLYF8DSZ5P5WNQRjtJKj1fL47SCCe995uU4M5voAQ0im8FCWr
         LvnQ==
X-Received: by 10.60.57.68 with SMTP id g4mr6551938oeq.14.1368950700127;
        Sun, 19 May 2013 01:05:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm12541170oby.12.2013.05.19.01.04.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 19 May 2013 01:04:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224829>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > On Fri, May 17, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:

> >> So when "the user" is running "git fetch" on "mywork" branch that
> >> happens to be forked from a local "master",...
> >> we still need to have FETCH_HEAD updated to point at what we would
> >> be merging if she did a "git pull".
> >
> > No, we don't need that. That is only needed by 'git pull', and in
> > fact, it should be possible to reimplement 'git pull' so that it skips
> > FETCH_HEAD when the remote is local.
> >
> > These are mere implementation details.
> 
> You seem to be incapable to understand what backward compatibility
> is.

Really? Do you even remember the time when you changed out of nowhere
all the 'git-foo' commands with 'git foo' and all hell broke loose?

I remember some lonely voice of reason shouting for clear deprecation
warnings:

http://article.gmane.org/gmane.comp.version-control.git/94262

You seem to not understand what is the purpose of backwards
compatibility, so let me explain. The most important aspect of a project
is not the technical details, or the performance, but it's *usefulness*
to the users; once a user has decided to use the software, he expects it
to keep working for his use-cases in the foreseeable future. If something
changes, and the user was relying on that, the user would get annoyed,
but most likely would not stop using the software. If this happens time
and again, he might.

In order to keep as many users as possible, and ensure the project keeps
growing with as strong user and developer base, the old behaviors should
remain in place as much as possible. This keeps old users happy, and
allows the project to achieve it's goal; to be useful to many people as
possible.

The safest way to never break old behaviors is to never make any change,
but this is not ideal, no software is perfect, and the software needs to
be constantly evolving, otherwise users will stop using the software as
well.

Moving forward while not breaking old behaviors is often times
difficult, but necessary, to keep the old users, and the steady growth.

Many projects make the mistake of simply disregarding old users, and
breaking things constantly; and while doing so, they keep loosing users,
and never grow as much as they could. *Nobody* is suggesting Git should
do that.

It's inevitable that there would come a point in time where there would
be a conflict of interests, and in order to move forward it's necessary
to break old behaviors. When such situation arises, it's important to
exhaust any other options that might allow both the old and new
behaviors (like a configuration option), or different implementations. But
it might be, that there are no alternatives, and either the project
doesn't move forward, or compatibility is retained.

When analyzing such cases, it's important to understand the impact it
has, and how many users it affects; if it's a small change to the user
work-flow, but it affects too many users, it might be best to don't go
forward with the change, or only do so after a major version release,
with good communication to minimize the damage. And if it's a big
change, but it affects a small user base, it still might make sense to
go ahead with the change.

Many times it won't be possible to know how many users would be affects,
and in those cases it might make sense to release, with a hand in the
breaks, so, if a lot of users complain, the change is reverted, and
nobody, or very few, complain, leave it there. The Linux project does
this; revert when somebody shouts.

In conclusion; you shouldn't blindly dogmatically avoid changes for the
sake of it; you have to understand *why* you _try_ to retain backwards
compatibility, and when it best serves the project not to do so.

If you try to be too overzealous in your backwards compatibility, you
run the risk of not moving fast enough in order to not annoy a handful
of users, or even imaginary ones who don't even exist. This is not good
for the project.

A few days ago somebody used a very appropriate name for it:
compabeaten[1]. We want to keep our users happy, but we also want to
keep our developers happy, and not being able to move forward with as
many features as one would want to is very annoying.

In the worst case scenario, we can revert a change that many users are
complaining about, we are not GNOME.

[1] http://article.gmane.org/gmane.comp.version-control.git/224510

-- 
Felipe Contreras
