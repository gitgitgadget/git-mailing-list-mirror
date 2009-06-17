From: Minty <mintywalker@gmail.com>
Subject: Re: git rebase --interactive squash/squish/fold/rollup
Date: Wed, 17 Jun 2009 14:45:36 +0100
Message-ID: <e1868cfe0906170645h2629e6f5v6dfe10d0cb909f77@mail.gmail.com>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	 <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 15:45:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGvSU-0005Jq-DC
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 15:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757152AbZFQNph convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2009 09:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754779AbZFQNpg
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 09:45:36 -0400
Received: from mail-fx0-f212.google.com ([209.85.220.212]:61596 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbZFQNpg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2009 09:45:36 -0400
X-Greylist: delayed 5923 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2009 09:45:35 EDT
Received: by fxm8 with SMTP id 8so310184fxm.37
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=vP1dnqX3VF/xkDVq00zMQjFmchLT4Ly2TVz5WqRyCCs=;
        b=aqZHf/REeD6KgEvm+u1dAHc4ah62qhqi6DhCOSbM2zGPNwfb5OONJbd1Pshw84NXGA
         cJdG2/cc1KidUTh9PlVOiIWVPiMuaHpK4kYSw198QiytNtwJ0s98EixkzReE5j5jNcyg
         ShD5sMspLcfikQ1VRX+scgNgFwEginFIZAkw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=KaPXrBAFbUTIJY3ItWvew5iTdV/vWYafoZscHUaMLue9ru10sXVY1msCEjohfz+ahd
         tXXU7cqQAT3h3VgnAoeyY88y1mUVPjLfwLNvJ5hxYGHnLei1YY4RpPXHPHBK+ytz2ZCg
         Nl3fX+uSj8tzqrxEu1vvjC/D5sSnVxTp+S4oI=
Received: by 10.204.65.17 with SMTP id g17mr131221bki.193.1245246337004; Wed, 
	17 Jun 2009 06:45:37 -0700 (PDT)
In-Reply-To: <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121745>

On Wed, Jun 17, 2009 at 1:55 PM, John Tapsell <johnflux@gmail.com> wrot=
e:
>
> > branch, hack, commit.
> > hack, commit, hack, commit
>
> What if you used =A0commit --append =A0instead?

That appears to be a switch I don't have, nor is documented

http://www.kernel.org/pub/software/scm/git/docs/git-commit.html

Did you perhaps mean --amend?  Or have I missed something?

--amend is not really a solution for me - it is perhaps a quirk of my
working pattern, but I typically (on the branch) commit tiny tiny bits
of a (possibly incomplete) feature, then want to merge them back into
a single "feature commit" to merge with trunk.  It's a case of
building up a feature commit one step at a time.

Perhaps I'm not normal or going about it wrong, in that I'm happy to
commit (on a branch) an incomplete bit of code ... pop off to do
something else, come back, hack a little more ... go off, come back
=2E.. eventually ending up with a bunch of commits I want to merge down
into a smaller set of (combined) commits which to then merge with
master/trunk.

fwiw, I didn't set out with this pattern in mind, it's rather one I
have noticed myself being in frequently.  It seems quite natural to
me, except for this repeated squashing mini commits down.  I'm not
squashing ALL commits down into one single commit.  Rather many
commits down into a few commits, which then get merged with
master/trunk.
