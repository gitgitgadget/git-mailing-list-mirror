From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Deciding between Git/Mercurial
Date: Tue, 29 Sep 2009 10:44:19 +0200
Message-ID: <9accb4400909290144t1363b5c6t8886bfa01e486c94@mail.gmail.com>
References: <h9nlhj$heq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: newsgroups@catchall.shelter13.net
X-From: git-owner@vger.kernel.org Tue Sep 29 10:44:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsYJy-000169-LS
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 10:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbZI2IoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 04:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753347AbZI2IoS
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 04:44:18 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:55822 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbZI2IoS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 04:44:18 -0400
Received: by fxm18 with SMTP id 18so4278512fxm.17
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 01:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=RKqxuNIfA8s6dCH2yILgEE+wom/Taxoh1/LWNgknuGM=;
        b=I3Kbs8+qhRNhhJsIw/AMTfNCBTloNQLbd0x56kBs5J0N2/BemJrBsfDW5gOP0ib079
         38c3Mxns20WmTbIHvAX3lUWCSV/GvSPtOL9LtiNyT4RcGjSFVLwp7vtLu3Dzs3MLbtTy
         eaDeJDpRAbjRtiiTyFXjoBvvMZKvetEhgY1h0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rO55n9JjkPa7+MmibCYcSBChfKwJC/2Yly97ONeQ0Z1e/6lITfACQmIPpmAuyFkRkm
         QJ4klLH4j7pR1eOYWdb4HUnIFk84uV0xgUzyrN7xXJwri5Q51U9wVCh3GHPgBE3cdTYW
         6AgYOh8Kpqicptz+j4o/3YfkG516EQIgo5/0Y=
Received: by 10.204.15.24 with SMTP id i24mr889627bka.2.1254213859512; Tue, 29 
	Sep 2009 01:44:19 -0700 (PDT)
In-Reply-To: <h9nlhj$heq$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129289>

On Sun, Sep 27, 2009 at 2:24 PM, Anteru
<newsgroups@catchall.shelter13.net> wrote:
> I'm currently evaluating DVCS for a project, and we're at a point where
> it comes down to either Mercurial or Git. Right now, I'm advocating for
> Git, while my co-workers like Mercurial, so I'd like to provide some
> good arguments in favor of git. Unfortunately, I'm not a git expert, so
> I hope I can get some help here ...
>
> First of all, what's the matter with git and Windows, is there some
> long-term commitment to make git work on Windows as well as on Linux?
> I'm using msysgit on Windows, and personally I'm happy with it, but my
> co-workers constantly nag that Mercurial has superior portability ...


Can I propose to make this discussion cross-mailing list adding the hg
mailing list to the CC?
I think it would be a good discussion if we don't end up flaming.
Let me know what you think about it


about the Windows+Git compatibility, you may consider TortoiseGit too
for the not-CLI-oriented guys; I've seen it a while ago and it seems
pettry well integrated with windows


> Mercurial's revision number system: With git, I get an SHA1 hash for
> every commit, but it's not possible to see whether Hash1 is newer than
> Hash2, while Mecurial also adds a running number to each commit. What's
> the rationale behind this decision for git, and is it possible to
> emulate Mercurial's behavior somehow?


If you tag a commit then you should be able to see how many commits
there are from that one issuing a git describe
(found on the internet)
git commit -m'Commit One.'
git tag -a -m'Tag One.' 1.2.3
git describe    # => 1.2.3
git commit -m'Commit Two.'
git describe    # => 1.2.3-1-gaac161d
git commit -m'Commit Three.'
git describe    # => 1.2.3-2-g462715d
git tag -a -m'Tag Two.' 2.0.0
git describe    # => 2.0.0


> So far, my key arguments are that git is more robust (more projects
> using it, larger developer base), of course git's excellent performance
> and the much better support for SVN, which is important for us as we can
> slowly migrate from SVN->Git, while hgmercurial is still in the making
> (and Python's SVN->Hg switch is for instance waiting for it).
