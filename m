From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Newbie grief
Date: Wed, 02 May 2012 14:28:20 -0700 (PDT)
Message-ID: <m3pqamqnnz.fsf@localhost.localdomain>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com>
	<CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
	<20120501111415.GD5769@thunk.org>
	<CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
	<4FA02830.3040407@palm.com>
	<CAMOZ1Bue4r7aP75xaeKkFC08WfOqD8O41pkSQGx7RSbW5xWcdg@mail.gmail.com>
	<4FA030D1.5030301@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Wed May 02 23:28:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPh64-0007Ql-Iz
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 23:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab2EBV2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 17:28:24 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38701 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab2EBV2X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 17:28:23 -0400
Received: by wibhr7 with SMTP id hr7so28671wib.1
        for <git@vger.kernel.org>; Wed, 02 May 2012 14:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=wyK5qMeXracGwihhUtEZtoZ5rmIZWLEAcqb1HufSyGo=;
        b=DSxf0sXOE0oaHfl45bCqyPpCrAZJ+OLYWvhwQQOWi9INk7UQGF+MbkZVBf0Bjd1PuD
         X3UD4Ond/2ogB9aVQHEOedW/I8gTTLq3/NNRzNkUb/Rf0hgNuar0jPZt5KTJIV6IPwU3
         Ba2xzOXswa7fAPOIlFsTo6ALhX86YRLU0LawumGTq9qDmGcKPOk2+9jcMlOX2y1KScBT
         NEDZCYCxmkWf7+5V2DPrVjoFzdhJkuxOGUxhADKiuKa5ELlWTRqp+USQMxxdeFxASqEo
         DGqSfMfALisK4JHihqbk9bDDGxr/piXBpoq0Xr4EZv6YUoxwCO5J+tElpEkushdCqlsU
         xQpw==
Received: by 10.180.78.9 with SMTP id x9mr17657311wiw.18.1335994101920;
        Wed, 02 May 2012 14:28:21 -0700 (PDT)
Received: from localhost.localdomain (eps70.neoplus.adsl.tpnet.pl. [83.20.60.70])
        by mx.google.com with ESMTPS id ff2sm10699871wib.9.2012.05.02.14.28.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 14:28:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q42LRelV027225;
	Wed, 2 May 2012 23:27:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q42LRC3M027215;
	Wed, 2 May 2012 23:27:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4FA030D1.5030301@palm.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196862>

Rich Pixley <rich.pixley@palm.com> writes:
> On 5/1/12 11:20 , Michael Witten wrote:
>> On Tue, May 1, 2012 at 18:15, Rich Pixley<rich.pixley@palm.com>  wrote:
>>
>>> I want pull to work even without merging.  I want to be able to share a
>>> branch between different repositories and different users while the source
>>> code control system tracks this for me
>>
>> I believe you are missing the point that a `pull' in git is a `fetch'
>> followed by a `merge'. You should read about the `fetch' command by
>> reading (`git help fetch'), and make sure you understand how to use
>> refspecs; you will probably find it very instructive to play around
>> by specifying explicit refspecs to `git fetch' rather than relying
>> on the implicit rules (which can be somewhat confusing).

[...]
> That git uses the word "pull" to mean something different than
> previous source code control systems only adds to the confusion.  I
> was using "pull" in the more general sense of pushing and pulling
> data, not in the very narrow meaning of "git fetch + git merge".

In using "pull" vs "fetch" Git follows the convention of BitKeeper
(proprietary distributed version control system which was used for
Linux kernel development 'till "BitKeeper fiasco", and which Git
replaced).

> I'm still pretty much lost on refspecs and refs.  The terms are
> apparently not used in the manuals I've been reading and they don't
> seem to be used consistently even within git error messages.
> 
> Is "refspec" the git word for the branch pointer that points to the
> childless commit that defines a branch?

"Ref" in Git is a named reference (pointer) to a commit in DAG of
revisions, i.e. either [local] branch, tag, remote-tracking branch,
etc.

"Refspec" is a specification of mapping between ref name in remote
repository and "tracking" ref in local repository, e.g.

  refs/heads/*:refs/remotes/origin/*
  refs/tags/*:refs/tags/*

See any of git-pull(1), git-fetch(1) and git-push(1) manpages.

-- 
Jakub Narebski
