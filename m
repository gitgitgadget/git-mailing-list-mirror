From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [jgit] index v2 pull request
Date: Mon, 10 Mar 2008 22:53:27 +0100
Message-ID: <200803102253.28469.robin.rosenberg@dewire.com>
References: <20080308025027.GZ8410@spearce.org> <200803100051.55367.robin.rosenberg@dewire.com> <7bfdc29a0803100032q6b30f16el97c021f3b051b944@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Dave Watson" <dwatson@mimvista.com>,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 15:46:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ5kM-0001rV-7i
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 15:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbYCKOpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 10:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752448AbYCKOpr
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 10:45:47 -0400
Received: from [83.140.172.130] ([83.140.172.130]:15175 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752220AbYCKOpq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 10:45:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EECA9802650;
	Tue, 11 Mar 2008 15:45:44 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id II0Aovw3GQUK; Tue, 11 Mar 2008 15:45:44 +0100 (CET)
Received: from [10.9.0.13] (unknown [10.9.0.13])
	by dewire.com (Postfix) with ESMTP id 15B128006B6;
	Tue, 11 Mar 2008 15:45:43 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7bfdc29a0803100032q6b30f16el97c021f3b051b944@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76855>

Den Monday 10 March 2008 08.32.21 skrev Imran M Yousuf:
> I would like to volunteer to work in JGit;
> can someone let me know where I can pick some tasks to implement?
>

You can pick about anything you want that noone is working one. Pick something
that you feel is withing your grasp, or something simple outside. We need
more test cases (doesn't require much programming skills, but thinking). Unit
testing of Eclipse stuff falls into the same category. I have litte experience 
here, but I think there are lots of examples in Eclipse itself if one starts 
to poke around.

Diff against workspace/index doesn't work presently. The reworked 
indexdiffwalker or the iterator could be used for that. Please tell me if you 
start hacking on this as it's on my listl, just not yet. Should be reasonably 
hard, involves both jgit and eclipse programming.

There are some issues with selecting versions in the history view on Windows.

Copy diff as git patch to the clipboard and vice verse. Send email.

Harder and might involve more changes all over (that either I or Shawn will 
object to) is things like rename detection targeted fo r

Interface to quickdiff machinery for committing specific hunks.

Blame (even without rename detection) would be useful. Look at the CVS
annotate for inspiration. 

Support for git submodules. Will touch the core parts all over the place, but 
probably not in very intrusive way. Will require lots of test cases.

Not really git, but highlighting of trailing whitespace is on my wish list. I 
can't find a plugin that does that.

Adjust the commit dialog for amend so it shows all to-be commited changed 
files when amending.

The number of choices is infinite.

Ant, Cruisecontrol, Maven, etc-tasks.

Pick a pet.

-- robin
