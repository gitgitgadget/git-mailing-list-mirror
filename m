From: Bob Hazard <linuxoflondon@googlemail.com>
Subject: Re: Re: Android needs repo, Chrome needs gclient. 
	Neither work. What does that say about git?
Date: Tue, 24 Nov 2009 11:29:33 +0000
Message-ID: <90e180400911240329x93768f6t4b39e643b56e20e1@mail.gmail.com>
References: <2d707e8c-2561-470c-beba-c81e16ac441c@k17g2000yqh.googlegroups.com> 
	<65e170e70911200251q2ec5ec87rc37577dddfd3317d@mail.gmail.com> 
	<alpine.DEB.1.00.0911201229080.4985@pacific.mpi-cbg.de> <65e170e70911222011l776a6aean7bd75f072a806616@mail.gmail.com> 
	<20091123135817.GB2532@thunk.org> <65e170e70911231948l3b032dbeu7c99b65ce3ec97ff@mail.gmail.com>
Reply-To: linuxoflondon@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: tytso@mit.edu, git@vger.kernel.org, chromium-discuss@googlegroups.com
To: adrian.alexander.may@gmail.com
X-From: 3uMMLSw0OANI96BILC39CB1CB4CC492Ay69.0CA@listserv.bounces.google.com Tue Nov 24 12:30:11 2009
Return-path: <3uMMLSw0OANI96BILC39CB1CB4CC492Ay69.0CA@listserv.bounces.google.com>
Envelope-to: gcwcg-chromium-discuss@m.gmane.org
Received: from mail-pz0-f163.google.com ([209.85.222.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCtay-0007ny-JC
	for gcwcg-chromium-discuss@m.gmane.org; Tue, 24 Nov 2009 12:30:09 +0100
Received: by pzk35 with SMTP id 35sf1388606pzk.25
        for <gcwcg-chromium-discuss@m.gmane.org>; Tue, 24 Nov 2009 03:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:x-thread-url:x-message-url
         :list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        bh=jMxCG9ftXIGWkiwu4AHIhdGViXscjrp8ZwVSpke+irw=;
        b=WgKff0V5jrJ6JsdOxrD/O3QXsllAXJSYpGmo7uJGSAYt1FdsCGDCQ7uZEwbpQMpCa3
         5YU1UfAffJV2qdDJ0hiQeGImKf10BvyGvbnrcT8ZkK9X4boHQq6q+snasbREw/RN55cL
         60PwcgwI0KRKSvM53D5MMyryEC1En8epsVXHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:from
         :date:message-id:subject:to:cc:x-original-authentication-results
         :reply-to:precedence:mailing-list:list-id:list-post:list-help
         :list-archive:x-thread-url:x-message-url:list-unsubscribe
         :list-subscribe:content-type:content-transfer-encoding;
        b=Cc63bTC2io7nQDtDkcN5Tg6C5rIAXl0753/387htmmzDKf5bkbKSV7QvkFNEexmfU+
         WvXNSwi5wtEbG6nRvkAzt6AaaajFiIygpAGu613U3EBidksXK2TQk1DacI0ejpwf1vEd
         L6Hx61FAgN8y3vHnzbgdDMPg+uPLfIpP+pzWQ=
Received: by 10.115.100.26 with SMTP id c26mr163193wam.7.1259062200772;
        Tue, 24 Nov 2009 03:30:00 -0800 (PST)
X-BeenThere: chromium-discuss@googlegroups.com
Received: by 10.114.248.2 with SMTP id v2ls9302wah.2.p; Tue, 24 Nov 2009 
	03:29:55 -0800 (PST)
Received: by 10.114.189.22 with SMTP id m22mr1587123waf.7.1259062195789;
        Tue, 24 Nov 2009 03:29:55 -0800 (PST)
Received: by 10.114.189.22 with SMTP id m22mr1587122waf.7.1259062195759;
        Tue, 24 Nov 2009 03:29:55 -0800 (PST)
Received: from mail-ew0-f224.google.com (mail-ew0-f224.google.com [209.85.219.224])
        by gmr-mx.google.com with ESMTP id 3si1345106pxi.0.2009.11.24.03.29.54;
        Tue, 24 Nov 2009 03:29:54 -0800 (PST)
Received-SPF: pass (google.com: domain of linuxoflondon@googlemail.com designates 209.85.219.224 as permitted sender) client-ip=209.85.219.224;
Received: by ewy24 with SMTP id 24so3330136ewy.6
        for <chromium-discuss@googlegroups.com>; Tue, 24 Nov 2009 03:29:53 -0800 (PST)
Received: by 10.213.1.28 with SMTP id 28mr4893175ebd.70.1259062193209; Tue, 24 
	Nov 2009 03:29:53 -0800 (PST)
In-Reply-To: <65e170e70911231948l3b032dbeu7c99b65ce3ec97ff@mail.gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of linuxoflondon@googlemail.com designates 209.85.219.224 as permitted 
	sender) smtp.mail=linuxoflondon@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
Precedence: list
Mailing-list: list chromium-discuss@googlegroups.com; contact 
	chromium-discuss+owners@googlegroups.com
List-ID: <chromium-discuss.googlegroups.com>
List-Post: <http://groups.google.com/group/chromium-discuss/post?hl=>, 
	<mailto:chromium-discuss@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:chromium-discuss+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/chromium-discuss?hl=>
X-Thread-Url: http://groups.google.com/group/chromium-discuss/t/1ff27de47079ad2f
X-Message-Url: http://groups.google.com/group/chromium-discuss/msg/7f46d5f355ff31fc
List-Unsubscribe: <http://groups.google.com/group/chromium-discuss/subscribe?hl=>, 
	<mailto:chromium-discuss+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/chromium-discuss/subscribe?hl=>, 
	<mailto:chromium-discuss+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133574>

Git's raison d'etre was to make merging cheaper.  You are encouraged
to make as many local branches as you want to experiment on features

"if a longer experiment that I have committed several stages of turns
out to be a
blind alley, I'd like to go back a few steps on main, declare
everything after that to be a side branch that I'll probably never use
again, and continue on main with my next attempt. Is that possible?"


Yes.

This google tech talk by Randal Schwartz is a little old but it might help

http://www.youtube.com/watch?v=3D8dhZ9BXQgc4



2009/11/24 Adrian May <adrian.alexander.may@gmail.com>:
>> If you don't have bolt-on scripts, and you move that into the the core
>> SCM, then you force *all* projects to use whatever workflow was
>> decided as being the One True Way of doing things as seen by the SCM
>> designer. =A0So the question is whether the SCM *should* regiment all
>> projects into following the SCM's designers idea of the One True
>> Workflow.
>
> Of course I'd want the workflow configurable by whoever controls the
> main repository. I couldn't possibly suggest that all git projects
> need the same workflow. The number of developers can vary by five
> orders of magnitude - that calls for different workflow models.
>
>> Git's approach is to say that it will be fairly flexible about
>> dictating workflow --- who pushs to whom; whether there is a single
>> "star" repository topology, or something that is more flexible, etc.
>> You seem to hate this flexibility, because it makes life harder until
>> you set up these bolt-on scripts. =A0But that's what many of us like
>> about git; that it doesn't force us (the project lead) into a single
>> way of doing things.
>
> Leaving aside topology, I suppose we can agree that the subject
> divides into two aspects: offering the developer some optional tools,
> and asserting control over what gets commited to the official repo.
> Perhaps we can also agree that the former belongs under the control of
> the developer and the latter should be in the PM's hands. You seem to
> have opinions about which of these two aspects is more or less
> important, and to what extent git suffices, but I don't. I assume that
> the project manager has his own opinions about both aspects and I'm
> observing two big projects that independantly have augmented git's
> features with their own scripts. Their docs talk about both aspects,
> especially repo's, but they are entirely implemented in
> developer-overridable scripts. So any repo functions to do with the
> second aspect are either features that git needs to grow, or bits of
> the git manual that the repo designer didn't read. I'd kinda like to
> know which.
>
> Returning to topology, I think that also divides up similarly. The PM
> can't forbid you and me from casually swapping diffs back and forth,
> but he can dictate who we are supposed to submit our final candidate
> to for review. The very existence of a PM, who controls a subset of
> the repositories in the world, already implies a star topology, and I
> think pretty much everybody is using distributed source control in
> this way, at least when it comes down to *controlling* anything.
> People may also be causally bouncing diffs around, but that's not
> control, it's communication. I've got a one-man project on github
> which I edit from two locations, and even on that scale I find myself
> working star-fashion because either computer might have junk
> experiments in progress, but I only push to github if it's meaningful
> and tidy.
>
> That reminds me of a slightly different question: if a longer
> experiment that I have committed several stages of turns out to be a
> blind alley, I'd like to go back a few steps on main, declare
> everything after that to be a side branch that I'll probably never use
> again, and continue on main with my next attempt. Is that possible? I
> know that I can just start a new branch from the before the bad
> experiment, but if that happens a lot, the name of my current main
> branch would be changing all the time, and I think that's bad. I
> suspect what I want is possible, but I'm not sure how to do it.
>
>> As far as my wanting to impose a particular regimen on my project's
>> developers, I've never been a big fan of the Bondage and Discpline
>> school of software engineering. =A0They can use whatever workflow they
>> like; they just have to deliver patches that are clean. =A0If they are,
>> I'll pull from their repository. =A0If they aren't, I won't.
>
> Repo talks a lot about automating the workflow that leads to precisely
> that decision. They evidently want something more evolved than
> somebody simply having a look at the code. I'm not sure what they
> want, but I'm pretty sure it's none of the developer's business.
>
> Adrian.
>
> --
> Chromium Discussion mailing list: chromium-discuss@googlegroups.com
> View archives, change email options, or unsubscribe:
> =A0 =A0http://groups.google.com/group/chromium-discuss

--=20
Chromium Discussion mailing list: chromium-discuss@googlegroups.com=20
View archives, change email options, or unsubscribe:=20
    http://groups.google.com/group/chromium-discuss
