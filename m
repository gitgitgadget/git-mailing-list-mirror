From: Eugene Sajine <euguess@gmail.com>
Subject: Git push over git protocol for corporate environment
Date: Wed, 30 Sep 2009 19:13:23 -0400
Message-ID: <76c5b8580909301613m283c4bfdne8de449ca0fd0987@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 01 01:13:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt8MY-0006rS-A9
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 01:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbZI3XNU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Sep 2009 19:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbZI3XNU
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 19:13:20 -0400
Received: from mail-yw0-f192.google.com ([209.85.211.192]:42505 "EHLO
	mail-yw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbZI3XNU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Sep 2009 19:13:20 -0400
Received: by ywh30 with SMTP id 30so7479961ywh.23
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 16:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=VPrRMlHV+jXK/A1EhtcCQdaFdwsZwuxBYZ19KokSGIs=;
        b=qRyIwdKQNbdq3hzlRVMrH6i3dWSUK4Mh4Le0Gdyc7S2EvXvGays6I+y/DCk8EuDZdI
         sQ9400sDEbjhDcrWoaW06gfV+Xt9rIb31iAu+CnMoc0JIrhbX50pzbr1pBfNkzhuZjCe
         JefS4xNu5inXB3aKnME3TMUE8XDxkhHZP65W4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=nEbw63+e4XIROyrmF04K+vhbQ2S+FPNJCT2F2xnTYldY+qCaNorijT6vHy6iooCA+M
         iRBt7A9g2dcmQV9jam4kbIHyzHl/QiWvaBYabIu0ePrI3MsQF7bSNpKoSsXAm5yoMnWO
         rf3H8PyB1MwfSqxdFJKfhoVRtW+pK0kf7MR9E=
Received: by 10.90.121.17 with SMTP id t17mr291470agc.57.1254352403419; Wed, 
	30 Sep 2009 16:13:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129365>

=46irst of all thanks to everybody for an amazing tool! I=E2=80=99m a b=
ig fan of
it, so I=E2=80=99m trying to get rid of CVS in my company and migrate t=
o Git.

We are working in, I would say, standard corporate environment, so all
development is in internal network. We have multiple offices in
different countries. Currently as I said we are using CVS (don=E2=80=99=
t
ask!;))

My problem is that I need the simplest, easiest and fastest solution
from setup and maintenance point of view in a situation when we have a
huge CVS repo with hundreds of modules (projects) in it. My current
understanding is that we are going to pull out project by project from
CVS and create corresponding git repos.
So, this brings us to hundreds of git repos and over 200 hundred
committers. In this circumstances we don=E2=80=99t want to manage each =
repo
separately as well as we don=E2=80=99t want to manage each person write=
 access
rights to each repo.
As I understand the best solution here is git protocol (one port only
on dedicated server and no security as we are in trusted network) with
read and write access configured for all repos on a dedicated server.
What do you think I should do? How to enable push over git protocol?

I would appreciate any recommendation about such set up and any links
to corresponding docs.

Thank you,
Eugene
