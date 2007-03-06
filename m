From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git checkout preserve timestamp?
Date: Tue, 06 Mar 2007 02:21:50 +0100
Organization: At home
Message-ID: <esifio$j4f$1@sea.gmane.org>
References: <17895.18265.710811.536526@lisa.zopyra.com> <20070305072323.GA31169@diana.vm.bytemark.co.uk> <Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17900.27067.247950.419438@lisa.zopyra.com> <Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17900.30394.172067.743310@lisa.zopyra.com> <Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17900.36569.805689.922989@lisa.zopyra.com> <Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org> <17900.39124.763603.695942@lisa.zopyra.com> <Pine.LNX.4.64.0703051431130.3998@woody.linux-foundation.org> <17900.42415.750335.329874@lisa.zopyra.com> <Pine.LNX.4.63.0703060026340.13683@wbgn013.biozentrum.uni-wuerzburg.de> <17900.43487.947400.649777@lisa.zopyra.com> <Pine.LNX.4.63.0703060042040.22628@wbgn013.biozentrum.uni-wuerzburg.de> <87zm6rqlpn.fsf@graviton.dyn.troilus.org> <7vo
 dn7w6rz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 02:19:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOOL9-0004RF-IT
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 02:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886AbXCFBTf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 20:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933751AbXCFBTf
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 20:19:35 -0500
Received: from main.gmane.org ([80.91.229.2]:60444 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932886AbXCFBTe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 20:19:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HOOKr-0000Vq-RW
	for git@vger.kernel.org; Tue, 06 Mar 2007 02:19:25 +0100
Received: from host-81-190-25-43.torun.mm.pl ([81.190.25.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 02:19:25 +0100
Received: from jnareb by host-81-190-25-43.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 02:19:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-43.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41520>

Junio C Hamano wrote:

> Michael Poole <mdpoole@troilus.org> writes:
> 
>> This all sounds a lot like git-clone's "alternate" code.
>> ...
>> My own work habits are very similar to Bill Lear's, but my projects'
>> build times are small enough that it's less pain to rebuild half the
>> project than to propagate changes recorded under $GIT_DIR between
>> local branches.  I have not found a git workflow that makes me
>> entirely happy, but I suspect I just don't know the magic words.
> 
> These days I use a few working trees that are connected to my
> primary repository (which also has a working tree).  The primary
> repository is in /src/git, and other ones look like this:
> 
> : gitster git.wk0; ls -l .git/
> total 120
> drwxrwsr-x  3 junio src  4096 Mar  5 16:22 ./
> drwxrwsr-x 15 junio src 16384 Mar  5 16:23 ../
> -rw-rw-r--  1 junio src    41 Mar  5 16:22 HEAD
> lrwxrwxrwx  1 junio src    27 Mar  3 22:53 config -> /src/git/.git/config
> lrwxrwxrwx  1 junio src    26 Mar  3 22:53 hooks -> /src/git/.git/hooks/
> -rw-rw-r--  1 junio src 82455 Mar  5 16:22 index
> lrwxrwxrwx  1 junio src    25 Mar  3 22:53 info -> /src/git/.git/info/
> drwxrwsr-x  3 junio src  4096 Mar  3 22:59 logs/
> lrwxrwxrwx  1 junio src    28 Mar  3 22:53 objects -> /src/git/.git/objects/
> lrwxrwxrwx  1 junio src    32 Mar  3 22:53 packed-refs -> /src/git/.git/packed-refs
> lrwxrwxrwx  1 junio src    25 Mar  3 22:53 refs -> /src/git/.git/refs/
> lrwxrwxrwx  1 junio src    28 Mar  3 22:53 remotes -> /src/git/.git/remotes/
> lrwxrwxrwx  1 junio src    29 Mar  3 22:53 rr-cache -> /src/git/.git/rr-cache/

By the way, doing something like this, but not by using lots of symlinks,
but a kind of symref was idea behind Josef Weidendorfer .gitlink idea
(search for '[RFC] Light-weight checkouts via ".gitlink"')

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
