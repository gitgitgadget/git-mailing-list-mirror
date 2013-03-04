From: Jari Pennanen <jari.pennanen@gmail.com>
Subject: Configurable .gitignore filename?
Date: Mon, 4 Mar 2013 13:58:39 +0200
Message-ID: <CACoicv+Hq=d5fJ7PXYdyvOdWmc3-GbFrsAf2Ze7dnQTzjExXnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 04 12:59:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCU2t-0007Fu-C6
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 12:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630Ab3CDL6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 06:58:41 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50]:47949 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab3CDL6l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 06:58:41 -0500
Received: by mail-oa0-f50.google.com with SMTP id l20so8771751oag.23
        for <git@vger.kernel.org>; Mon, 04 Mar 2013 03:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=tfSnvthNArjMdxkSM2YRHBQ7Z+g0FB/ar8jFTmAMYBo=;
        b=Ax/r4oDLDk1uGTUEKqiS5b3j5IYMWmB3hdwDBogueGv0p6srYcq7D/CVnSDPbTlZ+i
         fJrc/n7j4a+coOGbT8afeo3HyF5wvSkpMOE4WtmWjwQsP3WMEd+9Ob8qyMXn+bS3ttbb
         dWErSkL08tmLjcvfXUqzNACbPdD4u4f9u2Ow+z8deQ8D/AmouwBsfMjETJQ4Wg0BfJqF
         PKY0zmGSfuV8MMOFKIz2Ez3dbMPMqU4URv+C40ocSEBj0pzSgIykyR/r28+hpFgpX0KD
         heWs684WVIul3VVyRVOjhyKyMXlrlh9Xigi4PczU9SB0N17gqfYdAg2zBg3sNp7r68jL
         0SXQ==
X-Received: by 10.60.18.136 with SMTP id w8mr15700203oed.84.1362398319424;
 Mon, 04 Mar 2013 03:58:39 -0800 (PST)
Received: by 10.76.22.197 with HTTP; Mon, 4 Mar 2013 03:58:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217397>

If project or directory belongs to more than one GIT_DIR then some of
the GIT_DIR's may need a different .gitignore files, it would be
useful if one could define it independently, e.g. in GIT_DIR/config:

[core]
ignorefilename = .gitalternateignore

Has anyone considered making the .gitignore filename configurable? It
could be in a config file or env variable, but either way it would be
handy to be configurable. I'm not familiar with git's structure, but
if ignoring is only used in git-add then I suppose I could make own
git-add script if this is not implemented in core git.

I intend to use GIT as a rsync replica (or Dropbox replica) cause it
suits it better than rsync, since GIT doesn't have to check all files
each time I sync (and GIT can contain versions / backups, works better
on Windows and has a simpler needs for the server), more about why I
need this: https://groups.google.com/forum/#!topic/git-users/E-Au9P0A6NA/discussion%5B1-25-false%5D

- Jari
