From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: .gitignore polution
Date: Sun, 15 Nov 2009 00:57:31 +0100
Message-ID: <fabb9a1e0911141557k5f6b0b8aud48b95784a9da4e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 15 00:58:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9SVJ-0006US-MO
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 00:58:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbZKNX5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 18:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbZKNX5q
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 18:57:46 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60920 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbZKNX5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 18:57:46 -0500
Received: by bwz27 with SMTP id 27so4607621bwz.21
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 15:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=Qk3Ak0ws+G2aFeZVI7xJl4CAipYAa60axL3H+xCrtLA=;
        b=JcVAt6TFTIcV6PbB62N/QILm7YkZ/myLNpJ4cj4OUCdXTFe8iGkwOu2b8ld0r4ieIn
         SB06rptt50YGtjqSQZFyWhoI2MEJzfYcKeVkMon8rYGraFPSlTKAiPVi1EmRXDFgfQTk
         qBI0nd6J8U3paAvfiqsqnqHJFrp9GvwskrCSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=RImeASRD1PM7Xeh31ppLsfDtWyNqxuI3kkw27EY68HCDuiTC2u/Tzh0HHm0GC6rq6a
         0FNwr7nMI1C4G/bVO/biIaiY3MS72fsU5STR7zfknH2pSpzzpkQIIoou6/coumH/kM/o
         ZRZ9zqonZTcYc9/71Rg6ndIyCrydAl1sj6/Oc=
Received: by 10.216.91.84 with SMTP id g62mr1168658wef.216.1258243071108; Sat, 
	14 Nov 2009 15:57:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132900>

Heya,

I usually compile git from next (sometimes pu to test out a new
feature), and when I then switch back to a development branch (usually
based off master) I get something like this:

$ git status
# On branch remote-helpers
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	git-http-backend
#	git-notes
#	git-remote-hg
#	test-index-version

Now I can easily do 'git clean -f', but it's somewhat annoying. How do
other developers deal with this?

-- 
Cheers,

Sverre Rabbelier
