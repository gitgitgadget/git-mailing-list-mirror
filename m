From: Yuri D'Elia <wavexx@thregr.org>
Subject: Re: A better git log --graph?
Date: Thu, 08 Jan 2015 12:39:35 +0100
Message-ID: <54AE6C77.8060303@thregr.org>
References: <m8jfg5$dsp$1@ger.gmane.org> <95FA7666-4031-48FE-B9F7-DC8BB969426C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 12:50:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9BUo-0000Fh-Lg
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 12:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756260AbbAHLnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 06:43:18 -0500
Received: from plane.gmane.org ([80.91.229.3]:40433 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753834AbbAHLnR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 06:43:17 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Y9BSJ-0005fN-Gp
	for git@vger.kernel.org; Thu, 08 Jan 2015 12:40:47 +0100
Received: from 193.106.183.18 ([193.106.183.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 12:40:47 +0100
Received: from wavexx by 193.106.183.18 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 12:40:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 193.106.183.18
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <95FA7666-4031-48FE-B9F7-DC8BB969426C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262192>

On 01/08/2015 08:52 AM, Kyle J. McKay wrote:
> Since --graph is text-based, this response may not be on-topic hence  
> no cc: to the list.

I see --graph as an important tool to get an overview on how the
development is being done. I don't mind having a graphical tool for the
job, and I was even suggesting if there was a graphviz-based tool that
could do a better job.

I have a couple of projects where we made heavy use of topic branches,
cherrypicks and whatnot. Not the best way to work, but I realized I just
needed a graphical overview of the layout to streamline a bit the
development.

I normally use tig, but the drawn graph, even when turning on bar
drawing, is really poor.

> I assume that you've tried gitk?  It has a graphic viewer for the log,  
> but I also find it difficult to tell what's going on in its graph  
> although it's somewhat better than the --graph graph.  It does not  
> parse --graph output.

I usually never use frontends. The notable exception is "tig" when I
want to get a feeling of the status of several branches and/or "blame"
some files. It haves a lot of typing. That being said, I tried gitk, but
assumed it was also parsing --graph layout.

Now looking again, I notice some differencies, but it doesn't give me a
better picture.

> A better repository to view it on is the scons mirror (http://repo.or.cz/scons 
> ) as it doesn't have nearly the number of branches/merges as Git  
> (direct link is <http://repo.or.cz/git-browser/by-commit.html?r=scons.git 
>  >).

It's better, but still not something I would feel like using.

Github's network "graph" is a bit better in my mind, but it also has his
own share of problems, namely trying his own logic to reduce the height
of the graph recyling the row for multiple branches.

> However, I find its graphs much easier to grok as it draws --first- 
> parent links in a much thicker line style and they stay the same color  
> so it's very easy to see forks, merges and where a fork was re-merged  
> into a main branch.

Yes, this does make a lot of difference when just looking at it. It
immediately becomes much more apparent.

I'm wondering if just turning on the bold attribute in --graph --color
would help improve the output.

> P.S. I'm not 100%, but I think that fossil shows the kinds of graphs  
> you're looking for (see a sample at <http://sqlite.org/src/timeline?y=ci&n=200 
>  >) -- each branch head stays in the same column and non-first-parent  
> links are thinner lines.

Now that's *really* readable for me! Isn't it?
I never used fossil so this is the first time I see it.

The symbols are really well chosen as well.

Can we have something like this in git?
It might entirely be that it breaks for 200 branches, but hell, for
smaller projects it's a boon.

> P.P.S. In any case if this isn't too much off-topic for your original  
> message, feel free to include any parts of the above message in a  
> reply to the list.

It was very helpful, so it's done.
