From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Mon, 14 Jan 2008 01:31:19 +0100
Message-ID: <200801140131.23027.jnareb@gmail.com>
References: <200712101357.49325.jnareb@gmail.com> <200801130144.14574.jnareb@gmail.com> <20080114001408.GV2963@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	David Kastrup <dak@gnu.org>, Florian Weimer <fw@deneb.enyo.de>,
	Chris Shoemaker <c.shoemaker@cox.net>
To: Dmitry Potapov <dpotapov@gmail.com>,
	Shlomi Fish <shlomif@iglu.org.il>
X-From: git-owner@vger.kernel.org Mon Jan 14 01:31:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEDF6-0003xg-MT
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 01:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735AbYANAb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 19:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754695AbYANAb2
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 19:31:28 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:40104 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176AbYANAb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 19:31:27 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2053806fga.17
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 16:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Kt+NPSnn+/sHMWjyr2zPOVolZsoI4GGzTB92VP/CGxo=;
        b=QwE2fwAzB5nsFIXHdlwVpzkp8qm5kZs+sf+8DLwutls3Gm6H8wIQ9f0PXQUzmHUfQyIKKf2U1/6vzpagnJLvTRc0PQJm3dyTdSmp4MYASIRpGduyMrHL81WvFdkeuqDgalO/ukwSFoTJI0AQ//LkLnAQLyeV0LuZ9q5dSoPbYJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NXeP9q92AY+yD3zHBq8byUH4pdYZHHzdwRPfcypHua96kmEoWhv6SOOJhFU5utRls3m6W1HxSNOvLbpcslLcHQ7R8kPeJQzPoLMnj+BkD1hvU/yBM40sYXaPmBcl32IWQOD7Q1To3GTjSagOHD9K/33uIMt+6aPTMAi3nKH8iyg=
Received: by 10.82.171.16 with SMTP id t16mr9905427bue.11.1200270685733;
        Sun, 13 Jan 2008 16:31:25 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.201.31])
        by mx.google.com with ESMTPS id d27sm9719539nfh.34.2008.01.13.16.31.23
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 16:31:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080114001408.GV2963@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70428>

On Mon, 14 January 2008, Dmitry Potapov wrote:
> On Sun, Jan 13, 2008 at 01:44:10AM +0100, Jakub Narebski wrote:
> > 
> > What does "Renames Support" mean? 

By the way, the question was to the author of Better SCM Initiative
Comparison, Shlomi Fish.

> Accordingly to the clarification provided there, it means retaining the
> history of the file when its name changed. So I would write like this:
> 
> Yes. Git can automatically detects renames and show history together,
> however being content oriented rather than file oriented, the notion of
> "retaining the history of the file" can not exactly applied to it.

"History of a file" can be defined as "<scm> log 'file'", and this is
well defined also for git. And 'rename support' for file means just
that this history of a file (of a current file contents) follows file
renames.

IIRC this des not work for directories... but on the other hand git,
tracking contents only as a goal, does not track directories.

> > Because the answer,
> > especially in the case of git which is a bit different in that it does
> > rename detection and not rename tracking (using inodes / file-ids),
> > depends on that...
> 
> Git is different in that it tracks the content as the whole rather than
> tracking a set of files. When you look at some source code, what you
> really want to know who and why wrote *this*, and usually it does not
> matter to you whether it was written in this file or another one. CVS
> is really bad at that, because if you renamed a file, it would be very
> difficult to go back to history and find that. Many file-ids based SCMs
> have solved this problem, however, they do not do any better than CVS
> in another very common case -- when your code is moved around as result
> of refactoring, but Git addresses both problems, not just one!

AFAIK Mercurial (hg) is not file-id based, but does explicitely track
renames. There was even an idea presented on git mailing list to mark
renames in commit object in some "note" header.

> So, it is not as much about explicit renaming vs automatic, but about
> different design goals. After finishing reading this questionnaire,
> it seems to me that a more proper title for it would be "Better CVS
> Initiative", so it is not surprisingly that Git does not fit into it
> well. It is like trying to put characteristics of your LCD into a
> questionnaire for CRT monitors -- some does not make sense, other
> misleading, and most important ones are not mentioned anyway...

Please remember that AFAIK this table is _older_ than Git itself.
But it is a fact that some characteristics are much patterned after
CVS features and misfeatures.

It would be much better if for each feature there was some test
described which would allow to check if the feature is supported.

By the way, even before "git log --follow" you could have "this file
was renamed to that file" in the commit/revision patchset. This is
IMHO enough of rename support. Much more important is correct support
for renames in merges, which is in TODO for Better-SCM comparison...

-- 
Jakub Narebski
Poland
