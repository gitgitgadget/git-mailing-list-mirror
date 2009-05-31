From: Jeremy O'Brien <obrien654j@gmail.com>
Subject: A usage question
Date: Sat, 30 May 2009 23:34:31 -0400
Message-ID: <20090531033431.GB25869@darkbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 31 05:34:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAboh-0004mn-US
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 05:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbZEaDe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 23:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753058AbZEaDe1
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 23:34:27 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:19977 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbZEaDe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 23:34:26 -0400
Received: by yx-out-2324.google.com with SMTP id 3so3824720yxj.1
        for <git@vger.kernel.org>; Sat, 30 May 2009 20:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=BMRnOyM6rV4xBn0XgHr0EDvrd1JMrw6ba8yQXtBUEd4=;
        b=J21uY2XalDadYug+ncDJK9B3j8gzZrZOiW7UwjWmPIySwc3TaMIdtr+5r63NYMNYKq
         2HXY6cAGJYvUXyfj/VZCQAB5CgPg++R3liFzlC80Nv1lhtd5J9SL/tbtXOB9sKbeBWgn
         yXs6HTQsGI24yYlEMx7W6LluwiwrtX6Km8SWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=F5qZArkE+LRwt6AO+b/7Z88Pt2n5D84maa0ydSju0dTqVYuBM0oQdIeH4hMeaM/Z57
         yN1/sc7+3seLCU+IsXqFJBdMqxQ95B7YFcQ1WuZ187NLY/QXzfhbCr7vN2ydvNt1jwEf
         CVzBjnggKi90WuEFC919AMcM1ENHm9rls0pFg=
Received: by 10.150.191.13 with SMTP id o13mr8447795ybf.303.1243740867970;
        Sat, 30 May 2009 20:34:27 -0700 (PDT)
Received: from darkbox (FUSE-WS1-208-102-202-125.fuse.net [208.102.202.125])
        by mx.google.com with ESMTPS id 6sm9080650ywn.7.2009.05.30.20.34.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 May 2009 20:34:27 -0700 (PDT)
Mail-Followup-To: Jeremy O'Brien <obrien654j@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120374>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I have a git usage question. I'm working on three separate branches in a
foreign SCM called Surround. One branch is the mainline, and two others
are a v1 branch based off the mainline and the other is a v2 branch
based off the mainline with many new features that we hope to release
soon. Some components of the v1 branch are similar, but not identical to
the v2 branch, and other parts are completely different. I am primarily
working on the v2 branch, but some things that I change can/should be
backported to the v1 and mainline branches.

The foreign SCM requires one working directory for each branch, so I
currently have three separate git repos with the contents of what is on
Surround for each, and then I have one "local" git repo that I'm using
to do my development. I have three branches on this local repo: one to
track each git repo set up for Surround. I've been using topic branches
in my local dev repo to do my work, and then merging my changes into the
branch I branched my topic branch from, and cherry-picking ones into the
other two branches that could be used there. I then push these branches
to the repos and check then into Surround when I am ready to. This
doesn't seem efficient to me at all, and I was wondering if there is a
better setup someone could suggest that would make development easier.
Sorry for the huge message.

Thanks for any suggestions.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoh+scACgkQJUoJkLEUD9sGGgCeMGtP0luA0GcJX9RBM8+Wp4Gs
BaQAnRprDHIZgK3DvhmgpqL5PFH4a+bf
=Wp7u
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
