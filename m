From: Kirill Marchuk <62mkv@mail.ru>
Subject: Re: very weird behaviour with
Date: Fri, 27 Mar 2015 10:58:18 +0000 (UTC)
Message-ID: <loom.20150327T115302-412@post.gmane.org>
References: <5512B03B.9020707@mail.ru> <loom.20150326T115519-901@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 11:58:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbRyJ-00018d-ON
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 11:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbbC0K6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 06:58:35 -0400
Received: from plane.gmane.org ([80.91.229.3]:47974 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbbC0K6e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 06:58:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YbRyC-00014l-6z
	for git@vger.kernel.org; Fri, 27 Mar 2015 11:58:32 +0100
Received: from 1936.rt-barnaul-02.dianet.ru ([94.230.125.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 11:58:32 +0100
Received: from 62mkv by 1936.rt-barnaul-02.dianet.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 11:58:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 94.230.125.199 (Mozilla/5.0 (Windows NT 6.3; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266369>

Kirill Marchuk <62mkv <at> mail.ru> writes:

> 
> Kirill Marchuk <62mkv <at> mail.ru> writes:
> 
> > 
> > Hi everyone
> > 
> >   I'm totally stuck with a following problem:
> (censor cut)
> ...........
> > 
> > But I believe that it might be due to my total misunderstanding of something
> > 
> > Anyway, I totally appreciate your help !
> > 
> > Thanks a lot
> > 
> > Kirill, frustrated unexperienced git user...
> > 
> > 
> 
> Hi Again
> 
> With "git subtree" today I have had even worse experience: 
> 
> 1) git checkout test
> 2) git branch test-tmp
> 3) mv adminUI adminUI2 (because otherwise errors..)
> 4) git commit -a -m "Renamed adminUI" 
> 5) git subtree add --prefix=adminUI adminui-origin/test --squash
> 6) mv adminUI adminUI2 (because I don't want here the "deploy" versions)
> 7) git commit -a -m "Added adminui as subtree"
> 8) git merge develop (!!!!!! it went smoothly, but... see below)
> 9) git checkout adminui-test
> 10) git subtree merge --prefix=adminUI test-tmp
> 11) git push adminui-origin test-adminui:test
> (instead of 9-11 I've tried to use "git subtree push", it's basically the
> same, I believe, only takes FAR more time to complete)
> 
> I was very glad and happy. Unless I've realized that, in fact, step 7 did
> not proceed as it was intended to (by me, at least)
> 
> It has 2 parents, and 2 diffs, and one of them shows exactly what it has to
> show (i.e. diff between tips of "develop" and "test-tmp"), but the files on
> the commit snapshot were left unchanged (I cannot imagine how could that
> happen, but that did)
> 
> If I modify files and commit them RIGHT INTO test-tmp branch, all the rest
> goes fine (so far), but that unability to merge from "develop" is something
> that's killing the whole point of it :(( 
> 
> I believe I am not the only one on this mailing list, so pleeease... 
> 
> Kirill
> 
> 


Even more mysterious thing happens today...
when I do 
git checkout test-adminui
git subtree merge --prefix=adminUI test-tmp

I receive 
'adminUI' does not exist; use 'git subtree add'

all the difference I can possibly think of, is that it probably requires me
to create "subtree" after every push ?? 
or is it due to my checkout-s and pulls into other branches during the day ? 

No ideas

Any help is greatly appreciated.. Although I am starting to think that I
probably chose wrong channel to seek for help on this case... 

Thanks for any reaction.

Kirill
