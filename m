From: Jonathan Fine <jfine@pytex.org>
Subject: Re: A Python script to put CTAN into git (from DVDs)
Date: Sun, 06 Nov 2011 18:19:39 +0000
Message-ID: <4EB6CFBB.2090901@pytex.org>
References: <4EB6A522.3020909@pytex.org>
	<mailman.2464.1320597747.27778.python-list@python.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: python-list@python.org, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: python-list-bounces+python-python-list=m.gmane.org@python.org Sun Nov 06 19:24:09 2011
Return-path: <python-list-bounces+python-python-list=m.gmane.org@python.org>
Envelope-to: python-python-list@m.gmane.org
Received: from mail.python.org ([82.94.164.166])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <python-list-bounces+python-python-list=m.gmane.org@python.org>)
	id 1RN7O4-0000U8-Ru
	for python-python-list@m.gmane.org; Sun, 06 Nov 2011 19:24:08 +0100
Received: from albatross.python.org (localhost [127.0.0.1])
	by mail.python.org (Postfix) with ESMTP id 3Sc4zr4Q3LzNDr
	for <python-python-list@m.gmane.org>; Sun,  6 Nov 2011 19:24:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=python.org; s=200901;
	t=1320603848; bh=eXSo+fcxIit+jE6lRCUN7u5FInqxJ6qnXZilfGLRF2A=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:References:
	 In-Reply-To:Cc:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:Content-Transfer-Encoding:Content-Type:
	 Sender;
	b=xZuCPvjseev4r2JQnh+daSLztjVH5HrF+ZR4GA9RQ+SSNv/POvbyBRxygKsq8m/IQ
	 P/V7sXJLCNrHB9W1PJHvZAOoQbATfuRAuxUE6oVlNQlu1UyS2X+8tHypDoP4lhvhRg
	 klppqrycDDXtb/vmPCjh5fRi8QLOg5+h/LXsii9Q=
X-Original-To: python-list@python.org
Delivered-To: python-list@mail.python.org
Received: from albatross.python.org (localhost [127.0.0.1])
	by mail.python.org (Postfix) with ESMTP id 3Sc4xT689tzN8w
	for <python-list@python.org>; Sun,  6 Nov 2011 19:22:05 +0100 (CET)
X-Spam-Status: OK 0.006
X-Spam-Evidence: '*H*': 0.99; '*S*': 0.00; '(using': 0.05; 'pointer':
	0.05; 'python)': 0.05; 'repository': 0.05; 'subject:Python': 0.06;
	'git': 0.07; 'see:': 0.07; 'url:bitbucket': 0.07; 'url:py': 0.07;
	'versions.': 0.07; '[1]:': 0.09; 'of)': 0.09; 'url:36': 0.09;
	'url:github': 0.09; 'package.': 0.12; 'things.': 0.13; 'users,':
	0.13; 'cc:addr:python-list': 0.15; '(set': 0.16; 'mercurial.':
	0.16; 'unpack': 0.16; 'meant': 0.16; 'linux': 0.17; 'wrote:':
	0.18; 'modified': 0.18; 'archive': 0.21; '(but': 0.21; 'commit':
	0.21; 'file,': 0.21; "doesn't": 0.23; '(on': 0.23;
	'received:192.168.1.4': 0.23; 'tool,': 0.23; 'tree.': 0.23;
	'header:In-Reply-To:1': 0.23; 'tree': 0.25; 'writes:': 0.25;
	'(in': 0.26; 'fine': 0.26; '"the': 0.26; "i'm": 0.26; 'putting':
	0.27; 'martin': 0.28; 'bit': 0.28; 'import': 0.28; 'script': 0.28;
	"he's": 0.28; "skip:' 30": 0.28; 'cc:addr:python.org': 0.29;
	' 
Received: from localhost (HELO mail.python.org) (127.0.0.1)
	by albatross.python.org with SMTP; 06 Nov 2011 19:22:05 +0100
Received: from avasout04.plus.net (avasout04.plus.net [212.159.14.19])
	by mail.python.org (Postfix) with ESMTP
	for <python-list@python.org>; Sun,  6 Nov 2011 19:22:05 +0100 (CET)
Received: from [192.168.1.4] ([87.114.34.239]) by avasout04.plus.net with smtp
	id tuMx1h00959a7of01uMzSd; Sun, 06 Nov 2011 18:21:59 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.0 cv=crMZYiEi c=1 sm=1 a=DjZMeTI4srlFSYBj8ex2iw==:17
	a=drkSDUSQfzAA:10 a=sjtYlV3t_a8A:10 a=2-jFaxeq-9kA:10 a=evIkNGOUjnIA:10
	a=crry0GulAAAA:8 a=xtERp6CFAAAA:8 a=-hrgbRRyAAAA:8 a=NEAV23lmAAAA:8
	a=-IeYfsU7AAAA:8 a=tBjzHVtHYgjclG8XYisA:9 a=hA1tnEy_hriPjAkFDXQA:7
	a=ebS1H2NBVeoA:10 a=nS3kShNHgVsA:10 a=DjZMeTI4srlFSYBj8ex2iw==:117
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.2.23) Gecko/20110921 Thunderbird/3.1.15
Newsgroups: comp.lang.python,comp.text.tex
In-Reply-To: <mailman.2464.1320597747.27778.python-list@python.org>
X-BeenThere: python-list@python.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: General discussion list for the Python programming language
	<python-list.python.org>
List-Unsubscribe: <http://mail.python.org/mailman/options/python-list>,
	<mailto:python-list-request@python.org?subject=unsubscribe>
List-Archive: <http://mail.python.org/pipermail/python-list>
List-Post: <mailto:python-list@python.org>
List-Help: <mailto:python-list-request@python.org?subject=help>
List-Subscribe: <http://mail.python.org/mailman/listinfo/python-list>,
	<mailto:python-list-request@python.org?subject=subscribe>
Sender: python-list-bounces+python-python-list=m.gmane.org@python.org
Errors-To: python-list-bounces+python-python-list=m.gmane.org@python.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184922>

On 06/11/11 16:42, Jakub Narebski wrote:
> Jonathan Fine<jfine@pytex.org>  writes:
>
>> Hi
>>
>> This it to let you know that I'm writing (in Python) a script that
>> places the content of CTAN into a git repository.
>>       https://bitbucket.org/jfine/python-ctantools
>
> I hope that you meant "repositories" (plural) here, one per tool,
> rather than putting all of CTAN into single Git repository.

There are complex dependencies among LaTeX macro packages, and TeX is 
often distributed and installed from a DVD.  So it makes sense here to 
put *all* the content of a DVD into a repository.

Once you've done that, it is then possible and sensible to select 
suitable interesting subsets, such as releases of a particular package. 
Users could even define their own subsets, such as "all resources needed 
to process this file, exactly as it processes on my machine".

In addition, many TeX users have a TeX DVD.  If they import it into a 
git repository (using for example my script) then the update from 2011 
to 2012 would require much less bandwidth.

Finally, I'd rather be working within git that modified copy of the ISO 
when doing the subsetting.  I'm pretty sure that I can manage to pull 
the small repositories from the big git-CTAN repository.

But as I proceed, perhaps I'll change my mind (smile).

>> I'm working from the TeX Collection DVDs that are published each year
>> by the TeX user groups, which contain a snapshot of CTAN (about
>> 100,000 files occupying 4Gb), which means I have to unzip folders and
>> do a few other things.
>
> There is 'contrib/fast-import/import-zips.py' in git.git repository.
> If you are not using it, or its equivalent, it might be worth checking
> out.

Well, I didn't know about that.  I took a look, and it doesn't do what I 
want.  I need to walk the tree (on a mounted ISO) and unpack some (but 
not all) zip files as I come across them.  For details see:
 
https://bitbucket.org/jfine/python-ctantools/src/tip/ctantools/filetools.py

In addition, I don't want to make a commit.  I just want to make a ref 
at the end of building the tree.  This is because I want the import of a 
TeX DVD to give effectively identical results for all users, and so any 
commit information would be effectively constant.

>> CTAN is the Comprehensive TeX Archive Network.  CTAN keeps only the
>> latest version of each file, but old CTAN snapshots will provide many
>> earlier versions.
>
> There was similar effort done in putting CPAN (Comprehensive _Perl_
> Archive Network) in Git, hosting repositories on GitHub[1], by the name
> of gitPAN, see e.g.:
>
>    "The gitPAN Import is Complete"
>    http://perlisalive.com/articles/36
>
> [1]: https://github.com/gitpan

This is really good to know!!!  Not only has this been done already, for 
similar reasons, but github is hosting it.  Life is easier when there is 
a good example to follow.

>> I'm working on putting old CTAN files into modern version
>> control. Martin Scharrer is working in the other direction.  He's
>> putting new files added to CTAN into Mercurial.
>>       http://ctanhg.scharrer-online.de/
>
> Nb. thanks to tools such as git-hg and fast-import / fast-export
> we have quite good interoperability and convertability between
> Git and Mercurial.
>
> P.S. I'd point to reposurgeon tool, which can be used to do fixups
> after import, but it would probably won't work on such large (set of)
> repositories.

Thank you for the pointer to reposurgeon.  My approach is a bit 
different.  First, get all the files into git, and then 'edit the tree' 
to create new trees.  And then commit worthwhile new trees.

As I recall the first 'commit' to the git repository for the Linux 
kernel was just a tree, with a reference to that tree as a tag.  But no 
commit.

> P.P.S. Can you forward it to comp.text.tex?

Done.

-- 
Jonathan
