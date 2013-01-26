From: wookietreiber <kizkizzbangbang@googlemail.com>
Subject: [feature request] git add completion should exclude staged content
Date: Sat, 26 Jan 2013 18:21:37 +0100
Message-ID: <20130126172137.GB5852@mobster.11n_AP_Router>
Reply-To: wookietreiber <kizkizzbangbang@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 26 18:22:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tz9S8-0004Kb-U8
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 18:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab3AZRVo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jan 2013 12:21:44 -0500
Received: from mail-bk0-f42.google.com ([209.85.214.42]:47332 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab3AZRVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 12:21:42 -0500
Received: by mail-bk0-f42.google.com with SMTP id ji2so734636bkc.15
        for <git@vger.kernel.org>; Sat, 26 Jan 2013 09:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:reply-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        bh=IoO9HjfQJwYdgAs/T8dnATawSNPPwml+XqxKrmxttpk=;
        b=ivooZ3cuJQyP5TjEcoIGeygA3o3ge8/zwW1TKAVY01ZPiSVQESAis+wNvrcRA9TqmL
         nCT1/8gEq3aBcYDBJNOMD/gr8+IHJvBxB5GP5NGpVoX0lyfkB2zPPLnzzY4y+LfmFhpB
         yN31SU1AB/H7KUuTVVfmAIG+1lSmXRuEMKS83zaW+phldX00+KGEA5cFLY5XAD/PCXgL
         CXoG8mbf6nJv+MHdY1Ik7OA7YMAQpDm/lgZta3gWgKExUu44N928vYIrSIlBLbYHi81w
         6BhBhmg4hz88aQSEC+W0MQIx+kp66ROylnvrTOMvkZxJCpbtQzKNXIGi273cKxiWuNCD
         2C0g==
X-Received: by 10.204.9.22 with SMTP id j22mr2717955bkj.114.1359220901223;
        Sat, 26 Jan 2013 09:21:41 -0800 (PST)
Received: from mobster.11n_AP_Router (178-25-47-212-dynip.superkabel.de. [178.25.47.212])
        by mx.google.com with ESMTPS id fs20sm716130bkc.8.2013.01.26.09.21.39
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 26 Jan 2013 09:21:39 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214628>

Dear Git Hackers,

I have a feature request for `git add` auto completion:

`git add` auto completion suggests all files / directories, filtered by=
 nothing. I guess it would be
much nicer (as in increasing productivity) if it would only suggest uns=
taged content, as reported by
`git status`, because that would be the only content one would be able =
to add.

Example:

    $ git status
    # On branch develop
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #       modified:   src/main/scala/XYChart.scala
    #
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       notes/0.2.0.markdown

    $ git add <auto-complete>
    build.sbt              .ensime                .git/                =
  project/               scalastyle-config.xml  todo
    COPYING                .ensime_lucene/        notes/               =
  README.md              src/
    $ git add

Where it should be:

    $ git add <auto-complete>
    $ git add notes/0.2.0.markdown

=2E.. because `notes/0.2.0.markdown` is the only thing I can add.


--=20

Beste Gr=FC=DFe / Best Regards
Christian Krause aka wookietreiber

-----------------------------------------------------------------------

EGAL WIE DICHT DU BIST, GOETHE WAR DICHTER.
