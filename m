From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 19:01:48 +0100
Message-ID: <200810271901.48925.jnareb@gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <200810271348.39373.jnareb@gmail.com> <200810271512.26352.arne_bab@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mercurial@selenic.com, SLONIK.AZ@gmail.com
To: "Arne Babenhauserheide" <arne_bab@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 27 19:03:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuWQp-0000tr-Ny
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 19:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbYJ0SB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 14:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbYJ0SB5
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 14:01:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:51069 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbYJ0SBz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 14:01:55 -0400
Received: by nf-out-0910.google.com with SMTP id d3so738775nfc.21
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rhhw9h5P9qR+/YHtvOoyPBUFLZ78FOY9B2wh5y7OwEo=;
        b=GdFA3ZbwsVHA6h18i+3AGsfiaRtxQ8S0bs2K3Fp/z9GhGUIXEiXfM1kLR5Qobgd2k1
         ejZkOrYPVajhHnQ4I4UicqhGG067pVHSv9GQJPHRzfkO8JYXix1n2sclEG7DKxWOUL9y
         1NVeCJ5X9xDGBVMoXQe26r1StTyoxV47ZyNyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wrwZOqIM4fNJG1U/BjqhXMD2Hf4VG7iWzmYJ4Ckjj35uTY1DRRHdxNcj/HK17PMEm+
         LxSl9E2qicple+mboYoXPX7trHwX5z5cETUtY14aCCaY/6s0a9Uj5PKuD+I7mm+IVjTO
         5GBraveBAJsH8d+LO29qKpb0RT74VcBsGnbOo=
Received: by 10.210.59.14 with SMTP id h14mr7038430eba.50.1225130513097;
        Mon, 27 Oct 2008 11:01:53 -0700 (PDT)
Received: from ?192.168.1.11? (abvq236.neoplus.adsl.tpnet.pl [83.8.214.236])
        by mx.google.com with ESMTPS id d2sm156745nfc.20.2008.10.27.11.01.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Oct 2008 11:01:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200810271512.26352.arne_bab@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99247>

On Mon, 27 Oct 2008, Arne Babenhauserheide wrote:
> Am Monday 27 October 2008 13:48:38 schrieben Sie:

>>> All in all it's a UI issue - while the git UI bit me quite often, the
>>> Mercurial UI just works.
>>
>> But _that_ might be because you are used to Mercurial UI, isn't it?
> 
> I rather think it is because I was used the Subversion UI before I tried git 
> and Mercurial.

I think Mercurial UI is more compatibile with Subversion UI than Git;
additionally Mercurial uses separate, different names to avoid
ambiguities: examples are 'hg rollback' and 'hg backout' for commands
which various SCM name reset and revert, sometimes referring to one
and sometimes to the other.

AFAIK Git mostly follows BitKeeper UI; it is quite natural as it was
meant as replacement for BitKeeper for Linux kernel development.

[...]
> Also, Mercurial is Python based with quite readable code and it's very easy to 
> create extensions for new uses, when I need them. 
> 
> If you know Python, creating a new Mercurial extension isn't harder than 
> creating a shell chain command for git, but it feels much cleaner and is 
> nicely integrated once it's done. You can even change the operation of basic 
> commands very easily without having to touch any existing code. 

There are advantages and disadvantages to each method.

Git was developed in true Unix tools style, as described in TAOUP i.e. 
"The Art of UNIX Programming" by ESR (http://catb.org/esr/writings/taoup/html/)
In "Programming Pearls" by Jon Bentley there is in one of chapters
description of prototyping 'spell' using ready UNIX tools, pipelines,
and a few of custom tools, to examine the needs of 'spell'.

One of the consequences of this type of design is that there isn't
(yet?) something like git library; this is caused by the fact that
tools (plumbing) that make up git are designed to run once, and let
operating system take care of freeing resources.

On the other hand clean and clear design of git repository made it
possible to create native Git (re)implementation in Java: the JGit
project. (Well, Git is GPLv2 and JGit/Egit is BSD 3-clause/EPL, so
reimplementation might have been needed for licensing purposes anyway.
Well, it is not _full_ implementation yet...

Besides is writing plugin in Python for Mercurial that much easier
than writing new command or stuff in C for Git? Well, perhaps it is,
as only recently there began to appear API documentation, and there
were created utility mini-libraries like strbuf, or string_list,
or parseopt.

Also often third-party projects or stuff in contrib gets incorporated
into git proper; sometimes stuff is moved from git core to contrib,
if there is no maintainer however (git-svnimport, git-p4import).
Git repository has many roots: one from git core, one with gitk 
(graphical history viewer), one from what was git mail tools, one
with gitweb (web interface), and one with git-gui (graphical commit
tool).


The extending via plugins idea used by Mercurial, so succesfull IMHO
for Firefox, and I think quite successfull for ikiwiki for example, is
not without drawbacks, especially that there is no plugins clearinghouse,
and plugins are required for what is considered pretty required 
functionality, like bisect before hg 1.0.

See also blog post on vcscompare: "Plugins In Version Control"
http://vcscompare.blogspot.com/2008/06/plugins-in-version-cotnrol.html

-- 
Jakub Narebski
Poland
