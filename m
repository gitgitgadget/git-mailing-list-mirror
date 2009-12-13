From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: strange error while pushing
Date: Sun, 13 Dec 2009 23:41:49 +0100
Message-ID: <40aa078e0912131441i370d9c23r65c42fe1f46bd194@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 13 23:41:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJx8W-00030R-GK
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 23:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbZLMWlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2009 17:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbZLMWlv
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Dec 2009 17:41:51 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:43688 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbZLMWlu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2009 17:41:50 -0500
Received: by ewy19 with SMTP id 19so2840910ewy.21
        for <git@vger.kernel.org>; Sun, 13 Dec 2009 14:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:message-id
         :subject:from:to:content-type;
        bh=hKVGMoHkhBmKJ622dnECWJaJR4vRyf4bz1mz/dP245o=;
        b=VkLgwiMQnM1oWiA3G8UeAbcnbwHs53YootJV0V+U1HEiBFEETwFEXjEGeEFWVlgW7G
         I5w/44d3wq+3bNEAHF8nFdxE3HeiP0SmOh8FXaDOEjgKZOFIlZOe8MGFpKvMHQD2V6UC
         EuPbvhhL+35xaBxIOHpZjxt8+RpxNAfJ6OjuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=I+ZgyGkDuMSjinpCyDx7K4Bv6gkPcmlB6TTAIwkh2wRoQllzDs0sRw4OlnT5wUvXIY
         x0jVZ0aCquHD6bNNw7BPo73VevYHKKDGYX4bvNwzlpBh3RCAwW98pbr1Ie5XLFUSb2rO
         ddm7EZANNuG2GxphTKecOr8mU/uGNr0f3UOwg=
Received: by 10.216.88.140 with SMTP id a12mr1628459wef.157.1260744109038; 
	Sun, 13 Dec 2009 14:41:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135153>

I was going to push some stuff I'm working on to my repo at
repo.or.cz, and just got the following error:

$ GIT_TRACE=1 git push kusma work/daemon-win32:work/daemon-win32-process
trace: built-in: git 'push' 'kusma'
'work/daemon-win32:work/daemon-win32-process'
trace: run_command: 'ssh' 'repo.or.cz' 'git-receive-pack
'\''/srv/git/git/kusma.git'\'''
trace: run_command: 'pack-objects' '--all-progress-implied' '--revs'
'--stdout' '--thin'
trace: built-in: git 'pack-objects' '--all-progress-implied' '--revs'
'--stdout' '--thin'
usage: git pack-objects [{ -q | --progress | --all-progress }]
        [--max-pack-size=N] [--local] [--incremental]
        [--window=N] [--window-memory=N] [--depth=N]
        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset]
        [--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog]
        [--stdout | base-name] [--include-tag]
        [--keep-unreachable | --unpack-unreachable]
        [<ref-list | <object-list]
error: pack-objects died with strange error
error: failed to push some refs to 'ssh://repo.or.cz/srv/git/git/kusma.git'
$ git --version
git version 1.6.6.rc2.5.g49666

Is this something anyone have experienced before?

I'm not entirely sure if this happens on the local side or the remote
side... I've tried with a few different versions locally but the issue
seems to persist, so I'm starting to suspect it's an issue at the
remote end. Any insight, anyone?

-- 
Erik "kusma" Faye-Lund
