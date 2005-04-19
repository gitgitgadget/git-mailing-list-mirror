From: Steven Cole <elenstev@mesatop.com>
Subject: Re: [PATCH] Add help details to git help command. (This time with
 Perl)
Date: Tue, 19 Apr 2005 14:34:51 -0600
Message-ID: <42656B6B.3080209@mesatop.com>
References: <200504172242.26326.elenstev@mesatop.com> <20050418102412.GJ1461@pasky.ji.cz> <42654153.8080307@mesatop.com> <20050419175051.GK12757@pasky.ji.cz> <42655630.80207@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 22:33:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNzND-0007GD-FO
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 22:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVDSUfK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 16:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVDSUfK
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 16:35:10 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:7077 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261657AbVDSUfA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 16:35:00 -0400
Received: from w-mail.lanl.gov (w-mail.lanl.gov [128.165.4.47])
	by mailwasher-b.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3JKYukX027171
	for <git@vger.kernel.org>; Tue, 19 Apr 2005 14:34:57 -0600
Received: from [128.165.67.197] (spc7.esa.lanl.gov [128.165.67.197])
	by w-mail.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3JKYpE5017942;
	Tue, 19 Apr 2005 14:34:51 -0600
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
To: David Greaves <david@dgreaves.com>
In-Reply-To: <42655630.80207@dgreaves.com>
X-PMX-Version: 4.7.0.111621
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Greaves wrote:
> Petr Baudis wrote:
> 
>> Dear diary, on Tue, Apr 19, 2005 at 07:35:15PM CEST, I got a letter
>> where Steven Cole <elenstev@mesatop.com> told me that...
>>
> 
> I've been working on git.pl and getting help working nicely
> 
> things to try:
> git.pl help
> git.pl add
> git.pl add --help
> git.pl add --man
> git.pl help add
> 
> The main objectives:
> * get a reasonable perl code base in git.pl
> * provide some way to document WTF is going on :)
> * keep the docs near the developer
> * allow variations in verbosity
> * modularise
> * don't use modules outside the base perl set
> * allow a gentle migration (so start by calling the .sh's)
> 
> I don't like the pod2usage calling convention but I use them for now.
> 
> I don't love the 'require gitadd.pl' but it's a gradual start...
> 
> Cogito.pm seems to be a good place for the library stuff.
> 
> git.pl
> passes everything to scripts except gitadd.pl
> works when called from somewhere other than the git dir
> I don't feel 100% about the fixup ports
> 
> gitadd.pl
> 
> 
> I thought I'd ask for comments before I spent too much time on this...
> 
> David
> 

I only did my version which spits out the comments at the top of the
shell script as a quick hack.

This looks good to me. Keeping the docs near the developer is essential,
I think.  Speaking of "I think", the name "cogito" was suggested for the
SCM layer, but IIRC Linus suggested staying with just plain git. Petr
suggested tig, perhaps because it looks at git from another point of view.

If we ever do decide to name the SCM layer (the git-pasky stuff) something
with "git inside", other choices are:

agitato		Beethoven's "Moonlight Sonata" 3rd movment is "Presto agitato"
legit		Since git is GPLv2, but perhaps a little too French.
regurgitate	No comment neccessary.

Steven
