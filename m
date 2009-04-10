From: Jacob Kaplan-Moss <jacob@jacobian.org>
Subject: git-stash fails on OSX 10.5
Date: Fri, 10 Apr 2009 11:44:36 -0500
Message-ID: <be4ebbe10904100944p6ec2c0dao8607fcff75d2754e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 18:46:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsJs3-0007F4-Nk
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 18:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765839AbZDJQoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 12:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765264AbZDJQoy
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 12:44:54 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:62711 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759684AbZDJQoy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 12:44:54 -0400
Received: by qyk16 with SMTP id 16so2369625qyk.33
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=lUjM7ZoMQdFsR+HZy1tL1d+xcJU+TwAiaJAkjOfAMqg=;
        b=MZDVbeb2gyha2esTM0z4eBkszjaMtOdLx2ZTszUI0QkEFnRpEBpYmmPX2waT9hgRRz
         5mqPauxbgFWTjfECc7vJ7WPs062C06VzCYXmzc0qVJNmQqm0hI0NEdW82UfMfstmgNsK
         wFpPrgW5krhhzVtI1PZWICFIKjPheAuxVR51Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        b=FC2D5PLjEnX9WEhJrSUkKjC5vzL4UPasvpthcanoufVs4zRQ/iZdRZJdXgPCiQseaL
         ScXI6ErOlxvV9VRPzOWrHBF35Fjw90mH/Gifps3QQs+Z+/aYPFxY3PzomCJvAKvvpvaH
         nqlhubDn8e8pj1jm1AkHNMFgwA+DxK+TqAwOM=
Received: by 10.220.98.209 with SMTP id r17mr4941447vcn.20.1239381892264; Fri, 
	10 Apr 2009 09:44:52 -0700 (PDT)
X-Google-Sender-Auth: ac9cded7aae394af
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116265>

Hi folks --

I'm stumped; git-stash simply won't work on my machine. On any
repository I've tried, with various permutations, I keep getting::

    $ git stash
    cp: `.../.git/index': No such file or directory
    Cannot save the current worktree state

I spent about an hour in #git this morning trying to track it down
(log: http://colabti.org/irclogger/irclogger_log/git?date=2009-04-10#l1946).
I've tried stashing with and without content added to the index; I've
also tried entirely removing .git/index and then recreating it via git
reset. No dice.

I'm entirely willing to entertain the possibility that this is my
fault, but I am fairly familiar with git (been using it for about a
year) and so if it is fault it's gotta be something pretty subtle.

I'm concerned by the fact that it doesn't work on *any* repository on
my machine, though. I think that points to a systematic problem.

I'm on OS X 10.5.6; Git is 1.6.2.2, built and installed from source,
though the same problem happened with the old 1.6.0 I had yesterday,
and also the 1.6.2.1 I installed via the OSX package.

Thanks!

Jacob
