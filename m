From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: trouble getting git cvsimport working
Date: Sat, 10 Jan 2009 08:16:02 -0500
Message-ID: <81bfc67a0901100516w10ea77e8n8734713b071d69b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 14:17:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLdiZ-00044K-RR
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 14:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbZAJNQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 08:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbZAJNQK
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 08:16:10 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:46017 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbZAJNQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 08:16:09 -0500
Received: by bwz14 with SMTP id 14so30170808bwz.13
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 05:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=4JDYLdahgcSOm/JHSi/KHcXc87PT5r3jv4ku8UhB4Vc=;
        b=DQVJMKBjlAzYihFdDXigWWXmAAFDnxGCjeHYJR/b3JqqZY8JbhykGGpE1tg4R41ORh
         /qEIPZy4OFGhDXWgdtzJxZ7tZr2GkoSC2dMixcp06ttXIR2rLVe+bPTgXbQtW4jHLCuN
         9t0O4syPBm3ptniLJnBPda/w9gsA5VAj336B8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=jF+2b9E+nkPXVUEsT/ahXOz2N0iOKD1lZNaGSFXIsixSQMUNvjf6R2RRuRX22ua4j9
         TiGsh1Xq0lRJqWZ1eT0pSxwa6NiD30IBtsnpY07gEDufd91CdJRJVNTGT4aDeqMwuJOB
         W92Z/wRYUD5y1is8Mm9H43ivbr+HCgy4z5bC8=
Received: by 10.223.124.75 with SMTP id t11mr10990159far.73.1231593365043;
        Sat, 10 Jan 2009 05:16:05 -0800 (PST)
Received: by 10.223.108.12 with HTTP; Sat, 10 Jan 2009 05:16:02 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105102>

not sure what I'm doing wrong.

actual cvs command

cvs -d :pserver:anonymous@anoncvs.gentoo.org:/var/cvsroot co gentoo-x86

what I'm trying

git cvsimport -a -v -d
:pserver:anonymous@anoncvs.gentoo.org/var/cvsroot/ gentoo-x86 -C
portage

Initialized empty Git repository in /home/portdev/cvs/portage/.git/
Running cvsps...
parse error on third token
WARNING: malformed CVS version: no data
WARNING: malformed CVS version str: (UNKNOWN CLIENT)
WARNING: Your CVS client version:
[(UNKNOWN CLIENT)]
and/or server version:
[(UNKNOWN SERVER)]
are too old to properly support the rlog command.
This command was introduced in 1.11.1.  Cvsps
will use log instead, but PatchSet numbering
may become unstable due to pruned empty
directories.

sh: cvs: command not found
DONE; creating master branch
fatal: refs/heads/origin: not a valid SHA1
fatal: master: not a valid SHA1
fatal: You are on a branch yet to be born
checkout failed: 32768

help would be appreciated.
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
