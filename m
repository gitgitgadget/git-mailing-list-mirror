From: "Ramagudi Naziir" <naziirr@gmail.com>
Subject: rsync vs. git-push/pull ? (+kudus)
Date: Sun, 7 Sep 2008 09:11:47 +0300
Message-ID: <dfb262380809062311i3fffb900m5d73f5396b403dbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 08:13:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcDWI-0004Dv-8U
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 08:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbYIGGLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 02:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbYIGGLt
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 02:11:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:34965 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbYIGGLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 02:11:49 -0400
Received: by rv-out-0506.google.com with SMTP id k40so983081rvb.1
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 23:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=uwtO2oYWko+RzpKhnOJbnkgEaJqvH+xI/847+7jBryE=;
        b=koHzmARP8V3skWKnTVwWcLAYh83aa0AoGeaXMamIpkXDoAjzO5PM8vaH/i/L0x9w65
         Eq86/5IzhtuMvl2oW9rAanjaTI2W/eQWT3cTAgLnp8SDs/AYCUU6cuuctvN+wBuRtr9O
         gLkMbw8Mn94NqjVx4kQZ+nqdMk3ho1GEe3QZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=HXsPNo9RrIL7GRjeAcBzZx30zQ6jnsaSqSZFqdWlca2SGjSs9LzphmdH5MNuZaeAu8
         pH6aFkk22bb833J2Bc+ykqpmJzy7JVy+DXpmGEk2ypv/89641aBZr84dzqugGhVZ0CzZ
         qpFqLyzNnL85WpsUSNqUHxrclSDqgAjfPUCIo=
Received: by 10.141.137.8 with SMTP id p8mr7915385rvn.163.1220767908561;
        Sat, 06 Sep 2008 23:11:48 -0700 (PDT)
Received: by 10.141.29.1 with HTTP; Sat, 6 Sep 2008 23:11:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95117>

Hi all,

I have several local git repositories on my machine. I'm the only
user, and use them only locally. Now, sometimes when I need to work
remotely, I just rsync my repositories to my laptop, and keep working
there. When I finish (few hours, days or sometimes weeks later), I
just rsync everything back to my local git repositories on my main
workstation, and continue working there.

Now I was wondering whether it's OK or whether there are bad
implication I might not think of working this way. For example, maybe
some of these little git files are named differently on each machine,
and rsyncing them back and forth makes me piling a lot of clutter (in
that case maybe git-gc will clean up everything). Or maybe something
else horrid is going on and I really should just use git-push or pull.

I really prefer rsync to git-push/pull since it is much more easier -
It's one command that syncs my whole working folder, including the git
repositories..

Thanks a ton !!
Naziir

(btw - I read tons of free/open source development mailing lists and I
think that git has the best community by far. always so helpful and
nice. so thanks for all the help thus far as well)
