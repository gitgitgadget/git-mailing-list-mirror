From: Christian MICHON <christian.michon@gmail.com>
Subject: What should I do to display the diff of even a simple merge commit?
Date: Wed, 10 Feb 2010 00:45:44 +0100
Message-ID: <46d6db661002091545j74f625ffr74ca70a0474948fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 00:45:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NezmB-0001Hf-Tn
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 00:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144Ab0BIXpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 18:45:47 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:37006 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab0BIXpq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 18:45:46 -0500
Received: by bwz23 with SMTP id 23so780379bwz.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 15:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=5cd0r7MNER7kUwFQTkMtuYPf/qK2/8OFCH3XrtaySHM=;
        b=IfEg2LrpKR4qoGZqhAeIbbh62xktgCaQebpJq+/EwkurZMIR6mzasuoIDI5E7nQW7W
         VWNVB7KqrAv3zxtyclhostt0kzQqHuskDxPWvJTlrMwmUrA4/SFUZRGOmjU4HBc+BqIj
         f7GlwPyvE/nuvQC4ukZ4d84pyvnTe/GCWKWsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=pgvRZdkbnqo2nI/disWGCGfS75qlqdmrGka1e3Np1tXdowIi+tydzYpNvOztlsrGFh
         ZMH79ei3LEb/WPCgCJEh5ggt69KLvyFMvUY2NQ78fia31QW6c6R/g3zDCdvr6VAhoLKv
         qUW1ApWIK130HCcBkK0XD4uWcolFajR+0SAcM=
Received: by 10.204.5.70 with SMTP id 6mr3858871bku.90.1265759144287; Tue, 09 
	Feb 2010 15:45:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139460>

Hi list,

I'm performing many merges between developpers branches these days,
most of them not yielding into conflicts. (understand: simple merges)

All is good, but sometimes, I would like to really like what has been changed.

As I do not systematically do this "git merge --no-commit --stat
<list_to_merge>" and then fire "git gui" to inspect the diffs before
the real commit, I'm wondering: how could I do this using some
plumbing ?

Right now, I've tried the obvious git log -c -p, git show -u --cc, but
since the merge are simple merges, I cannot get any diff output. I
believe this is by construction.

Any hints ?

Thanks in advance.

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
