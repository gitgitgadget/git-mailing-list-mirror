From: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
Subject: Corrupted git repository?
Date: Tue, 15 Feb 2011 15:57:20 +0100
Message-ID: <AANLkTimMon7ztbyT26YhotiZ=jd=QpNTvOkPCKwHg+e_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 15:57:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpMLG-0006A0-L7
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 15:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab1BOO5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 09:57:22 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55374 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab1BOO5V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 09:57:21 -0500
Received: by vxb37 with SMTP id 37so155953vxb.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 06:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=b2Kg6zDdtISxWR+W2BvPVvmp93Z8n/Iy18cKqiHjLnE=;
        b=a29CALON948UPOLLphts4M1GakyCnhAIwEypbF9TLMboMwKMBYAsy6fwpFlfZ3clsW
         IDkXWUEGQfzJxJUdbSN0d3MzIUWbrcafjRSzMKcnq3AoAT7DBX9IOCXr/EJymIe9rM0x
         ychshwhAxf33F2afKQq3SnuUW5RYjtgbyAEdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=rYuHaz2aQzp8fsuvz/TExBWxRogjtpBuhtjhgjiN4nlK/LrY9MmQteCpFZB8hBvSL9
         IVFDphqe8trpoDR2W8LqtcDBjpnHJbzRgm9EHBUusNBIryxv9mXBvCYVcN+AUr+D6i3n
         gRiwHrzQOdXbeuX+rl9xVy5bcs22EveK36CXA=
Received: by 10.220.159.67 with SMTP id i3mr1015101vcx.246.1297781840246; Tue,
 15 Feb 2011 06:57:20 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Tue, 15 Feb 2011 06:57:20 -0800 (PST)
X-Google-Sender-Auth: IlaMVuK4AyLiAT8OBFtNZVTJxk4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166854>

Hi,

it looks like my git repository got corrupted today.

git status shows no changes,
git cherry-pick says "error: Your local changes to the following files
would be overwritten by merge:",
git fsck starts checking objects but hangs on one "Checking tree"

Other commands (gc, checkout, reset) seem to work correctly.

I've tried hard resetting to HEAD, didn't help.

What can I do? Cloning is very expensive operation here.

-- 
Piotrek
