From: "Chris.Cheney" <chris.cheney.nospam@tesco.net>
Subject: Re: git checkout branch puzzle
Date: Sun, 2 May 2010 08:58:58 +0000 (UTC)
Message-ID: <Xns9D6C65C2DB06EChrisCheneytesconet@80.91.229.10>
References: <Xns9D6BC0C4C8784ChrisCheneytesconet@80.91.229.10> <20100502045901.GD14776@coredump.intra.peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 10:59:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8V19-0004sp-UN
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 10:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069Ab0EBI7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 04:59:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:41747 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755890Ab0EBI7J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 04:59:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O8V10-0004md-8r
	for git@vger.kernel.org; Sun, 02 May 2010 10:59:06 +0200
Received: from 82.18.196.34 ([82.18.196.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 May 2010 10:59:06 +0200
Received: from chris.cheney.nospam by 82.18.196.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 May 2010 10:59:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 82.18.196.34
User-Agent: Xnews/5.04.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146147>

Jeff King <peff@peff.net> wrote in
news:20100502045901.GD14776@coredump.intra.peff.net: 

> On Sat, May 01, 2010 at 05:55:47PM +0000, Chris.Cheney wrote:
> 
>> I have been using msysgit (curently 1.7.0.2.msysgit.0) for about 18
>> months and thought that I had managed to understand most things.
>> However, the following sequence has me baffled:
>> 
>> a) on branch 'master', git status shows that the working directory is
>> clean 
>> 
>> b) git checkout HEAD^ gives the usual moan about moving to a head
>> which isn't a local branch
>> 
>> c) git checkout master followed by git status gives "changed but not 
>> updated" and a list of "modified" files
> 
> Part (c) shouldn't show anything in "git status". I wonder if it is a
> line-ending conversion issue, since you are using msysgit, and since
> that is the usual culprit for files mysteriously looking changed.
> Might you have recently changed the settings of core.autocrlf?
> 
> -Peff
> 

Thanks for the reply and confirming what I believed about (c). 

It is possible that what you suggest might be involved - it's a 2-developer 
situation, each using msysgit with their own local repository and a remote 
master (bare) repository. I'll compare the other's config file against 
mine.

Chris
