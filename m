From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 17 Feb 2008 05:52:45 -0800 (PST)
Message-ID: <m38x1jbsjb.fsf@localhost.localdomain>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
	<7vodavd9qw.fsf@gitster.siamese.dyndns.org>
	<7vbq6tset4.fsf@gitster.siamese.dyndns.org>
	<7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
	<7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
	<7vejbc44hu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bruno Ribas <ribas@c3sl.ufpr.br>,
	"J.H." <warthog9@kernel.org>, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 14:53:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQjxM-0005S3-QF
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 14:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbYBQNwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 08:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754871AbYBQNwt
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 08:52:49 -0500
Received: from hs-out-0708.google.com ([64.233.178.249]:30093 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634AbYBQNws (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 08:52:48 -0500
Received: by hs-out-0708.google.com with SMTP id 54so1020862hsz.5
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 05:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=DJ4Ql10dmME5OSkBfhy+tdnsMpLtw5MVHi948rlhbMo=;
        b=Omt2b82KH+Q3+q2UnFkn052ATK7nPw+W6HGzbAkyFD8gQMNEGXTee1QSlWIBUB3Z7KXRwzAYYDEvz2hVfBUOFDFUkOvvpWi22BJafQBaqMIV0sBbN3WXvd9Qs/gCIDQAOol1pS3TxXWzVZt6WvcYBGxkmLXnn1pvvJHqSsuFuGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=DdnlGsC/0JvZkvIGmM232IQ7yHKUjWQUyc8bDpQUJwhpTN9XkOe6+4yLdl/UTD9/PYbO2WBobMVg6i7PYIhIRrx+gknsoYmII38JGsJ+xoZd1ojmavpvV6GdtQjYFgrELaF3FUkL6qsaefwgg0VkD25LP9OTaBJCW2y3/U+VyKo=
Received: by 10.150.152.17 with SMTP id z17mr1619746ybd.106.1203256367465;
        Sun, 17 Feb 2008 05:52:47 -0800 (PST)
Received: from localhost.localdomain ( [83.8.248.52])
        by mx.google.com with ESMTPS id c5sm2597060nfi.2.2008.02.17.05.52.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Feb 2008 05:52:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1HDpcph028556;
	Sun, 17 Feb 2008 14:51:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1HDp4l3028542;
	Sun, 17 Feb 2008 14:51:05 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74132>

Junio C Hamano <gitster@pobox.com> writes:

> ----------------------------------------------------------------
> [New Topics]
> 
> * lt/dirstat (Tue Feb 12 17:06:58 2008 -0800) 2 commits
>  - diff: make --dirstat binary-file safe
>  + Add "--dirstat" for some directory statistics
> 
> The first one already in 'next' is the latest toy Linus showed
> off in his 2.6.25-rc2 announcement.  The other one on top is a
> rework to make it work more sensibly with a tree with binary
> contents.

Is this new one bytecount based rather than lines-changed based also
for text files?
 
> * js/run-command (Sat Feb 16 18:36:39 2008 +0100) 2 commits
>  - start_command(), if .in/.out > 0, closes file descriptors, not the
>    callers
>  - start_command(), .in/.out/.err = -1: Callers must close the file
>    descriptor

...and request for API documentation...
 
> * db/checkout (Sat Feb 16 17:17:09 2008 -0800) 12 commits
 
> Checkout rewritten in C.

Nice.
 
> ----------------------------------------------------------------
> [On Hold]
> 
> * br/gitweb (Fri Feb 8 14:38:04 2008 -0200) 1 commit
>  + gitweb: Use the config file to set repository owner's name.
> 
> On hold per Jakub's reluctance.

It was tested by the author (Bruno Ribas) that it doesn't affect
performance, although IMHO for a bit superficial test (1000 identical
repositories, gitweb run as a script, dd or git-for-each-ref as an
additional load).  I'd like to heard from larger gitweb deployments
how it works with a webserver (ApacheBench or similar), with a real
set of repositories, and perhaps in real load conditions... of course
on test gitweb, not on live one.

I also wonder if it would make sense to make it a feature,
i.e. instead of

+       if (!defined $owner){
+               $owner = git_get_project_config('owner');
+       }
        if (!defined $owner) {

have

+       if (!defined $owner){
+               $owner = gitweb_check_feature('owner');
+       }
        if (!defined $owner) {

with the 'owner' feature set as below:

+	'owner' => {
+		'sub' => \&feature_repo_owner,
+		'override' => 1,
+		'default' => [undef]},

and some implementation of feature_repo_owner.  This way it would be
possible to turn off checking for gitweb.owner in repo config from
withing gitweb config.  But this migh be an overingeneering...


I'd like to wait for a bit for comments, and if there wouldn't be any
negative ones, merge it in... and wait who screams ;-)
 
> * nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
>  - Move all dashed-form commands to libexecdir
>
> Scheduled for 1.6.0.  I am not sure if we should merge this to
> 'next' before 1.5.5.  Most active people will be on 'next' and
> if we have this there, the resulting 1.5.5 release might end up
> having issues that come from differences this one introduces.

What about making separate libexecdir and moving _helper_ scripts
(*--*) there first?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
