From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 7/8] Documentation/cherry-pick: describe passing more than one commit
Date: Wed, 2 Jun 2010 07:57:15 +0200
Message-ID: <201006020757.15117.chriscool@tuxfamily.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org> <20100531194240.28729.50475.chriscool@tuxfamily.org> <AANLkTikHODw5irE-84bkztWhUKgP8v1PG9zTW1Ea6WRs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 07:57:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJgxF-0006FZ-L4
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 07:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab0FBF5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 01:57:24 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:46284 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab0FBF5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 01:57:24 -0400
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 50E4C81809A;
	Wed,  2 Jun 2010 07:57:16 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <AANLkTikHODw5irE-84bkztWhUKgP8v1PG9zTW1Ea6WRs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148204>

On Tuesday 01 June 2010 11:29:32 Ramkumar Ramachandra wrote:
> Hi,
> 
> Christian Couder <chriscool@tuxfamily.org> wrote:
> >  -n::
> >  --no-commit::
> > -       Usually the command automatically creates a commit.
> > -       This flag applies the change necessary to cherry-pick
> > -       the named commit to your working tree and the index,
> > -       but does not make the commit.  In addition, when this
> > -       option is used, your index does not have to match the
> > -       HEAD commit.  The cherry-pick is done against the
> > -       beginning state of your index.
> > +       Usually the command automatically creates some commits.  This
> > +       flag applies the change necessary to cherry-pick the named
> > +       commits to your working tree and the index, but does not make
> > +       the commits.  In addition, when this option is used, your
> > +       index does not have to match the HEAD commit.  The cherry-pick
> > +       is done against the beginning state of your index.
> >  +
> 
> Avoid re-wrapping the text so it's easy to see the changes that you
> have introduced in subsequent blames- you've just changed the word
> "commit" to "commits".

Ok, avoided the re-wrapping.

> > +Examples
> > +--------
> 
> Style nitpick: shouldn't the word "Examples" be in all-caps?

I had a quick look at Documentation/*.txt and found 22 files with "Examples" 
and 32 files with "EXAMPLES", so I changed to "EXAMPLES". But if you really 
care I suggest you to submit a patch to changes the 22 files that contains 
"EXAMPLES".

Thanks,
Christian.
