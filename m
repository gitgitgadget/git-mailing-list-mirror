From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Git-SVN tutorial screencasts
Date: Fri, 5 Nov 2010 17:08:00 +0100
Message-ID: <AANLkTi=-GiuMUrZ8Fj_ojorJ88BCWX6Q1ezi7ZMRbTt3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 05 17:08:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEOpr-00030d-Dc
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 17:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210Ab0KEQIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 12:08:04 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57992 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab0KEQIC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 12:08:02 -0400
Received: by gyh4 with SMTP id 4so2269236gyh.19
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 09:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Ed80qc7gglra/KveIwZW0CME69/sp9QMy1wiejIN9Cs=;
        b=edvZz/t2S/utfdPU2k13wIrCXMJyy/TnVXkqVil/MuhXtNHpeOF+pI9PHWBJr4R5Fe
         YX55QgUv89OkQOJxH9XHyXLxUmTNZ/TJJpyBjRURfSnwj/1weSc45zgNr+FMgjk3cfW3
         3AwJP8cE1bVz7Mqj4pnG+00QsuwR2RJAbqDMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ADSvqbBEaJAyIkPGq+1TNohKEEKPxRCL0ksmuVBSrjsrWta/X44L6a4Yv79kyw3axw
         piMdDd0pVqTeBDym44iULTObxxlSuwq1rCEZ8wFyto20+I0uB/kuJkKeTIAQjvFCSFfY
         7dMS5cugUuUn3RJKTGbGbM2DkGEU94yu3GOnw=
Received: by 10.42.41.196 with SMTP id q4mr1260321ice.482.1288973281011; Fri,
 05 Nov 2010 09:08:01 -0700 (PDT)
Received: by 10.220.194.193 with HTTP; Fri, 5 Nov 2010 09:08:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160817>

Hi,

Some weeks ago, I created a series of screencasts on how to use
git-svn and how to set up a Git/SVN mirror. Maybe they will interest
some of the readers on this list:

http://www.tfnico.com/presentations/git-and-subversion

It would be nice to get some feedback on the git-svn mirror setup. It
is loosely based on the brief description found in the Git wiki [1].

I haven't found so much info about this elsewhere, so I'm not sure if
this is the best possible setup. For example, having to do a
git-update-ref on the git-svn pointer after every pull is a tad
annoying.

Regards,

Thomas Ferris Nicolaisen

[1] https://git.wiki.kernel.org/index.php/GitFaq#How_do_I_mirror_a_SVN_repository_to_git.3F
