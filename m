From: Georg-Johann Lay <avr@gjlay.de>
Subject: Re: subversion-perl missing
Date: Wed, 28 Sep 2011 17:54:38 +0200
Message-ID: <4E83433E.9000702@gjlay.de>
References: <4E8066AB.7000208@gjlay.de> <m3k48vp6l7.fsf@localhost.localdomain> <4E82F18E.9080304@gjlay.de> <201109281459.31689.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 17:54:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8wTD-0002hZ-Ic
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 17:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057Ab1I1Pyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 11:54:46 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:20236 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053Ab1I1Pyq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 11:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1317225284; l=1621;
	s=domk; d=gjlay.de;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Subject:CC:To:MIME-Version:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=ICmUIKZwduKaBS8UG5WXTHy1Djg=;
	b=lhJ6PU2M7gmhpjUODsxmH1ucW3JVvUa7r2W62QjjuV4byASinS/4UdgpEFl5Km1ynw3
	Cbgs1pwFXUgYyRGf7BfbJfuqm7Vt1SuHt5uLQt6J9Hmo2XssPJFn77/jn7M/4vOwPrss7
	slGXwaDCxEGvlIdfZTkzKjjyLRngW4rF/wQ=
X-RZG-AUTH: :LXoWVUeid/7A29J/hMvvT2k715jHQaJercGObUOFkj18odoYNahU4Q==
X-RZG-CLASS-ID: mo00
Received: from [192.168.0.22]
	(business-188-111-022-002.static.arcor-ip.net [188.111.22.2])
	by smtp.strato.de (klopstock mo58) (RZmta 26.7)
	with ESMTPA id p013ban8SFnrRe ; Wed, 28 Sep 2011 17:54:38 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.24 (X11/20100302)
In-Reply-To: <201109281459.31689.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182338>

Jakub Narebski schrieb:
> On Wed, 28 Sep 2011, Georg-Johann Lay wrote:
>> As far as I understand, alien-svn comes with SVN sources which it uses for its
>> own perl packages to provide svn stuff to perl, but don't install/build new svn
>> version.
> 
> Step by step instruction.
> 
> 1. Follow instructions on local::lib manpage
>    http://search.cpan.org/perldoc?local::lib
> 
>    c.f. http://perl.jonallen.info/writing/articles/install-perl-modules-without-root
> 
> 2. (Optional). Follow instructions on cpanm manpage, e.g. http://cpanmin.us
>    or http://search.cpan.org/perldoc?cpanm
> 
> 3. Install Alien::SVN from CPAN using 'cpan' client or 'cpanm', e.g.
> 
>    $ cpanm Alien::SVN
> 
> Now you are able to install Perl modules in your home directory.

Thank you very much, I never would have found the way through all that jungle
alone!

After steps 1-3 succeeded (as far as I can tell) I can run git svn (but not
git-svn) now.

With an SVN repo I can do

$ svn list http://repo/path

archive/
branches/
tags/
trunk/

and

$ svn checkout http://repo/path

but git svn complains:

$ git svn clone -s --username=georg http://repo/path

Initialized empty Git repository in /local/georg/path/.git/
Bad URL passed to RA layer: Unrecognized URL scheme for 'http://repo/path' at
/usr/local/libexec/git-core/git-svn line 1941

Does git svn not support http?

>From what I read in git svn --help this should suffice to checkout from SVN and
http is mentioned explicitly in an example.

So is my git-svn still broken/not functional or am I missing something from the
docs?

Johann
