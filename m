From: Benson Margulies <bimargulies@gmail.com>
Subject: On MacOS, 1.7.2, git svn clone seems to fail silently
Date: Fri, 30 Jul 2010 21:05:14 -0400
Message-ID: <AANLkTimxqC3oax=Q0EppAb-Q7AzHshRkV=H=6dJDNhqY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 03:05:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of0Vv-0005te-TA
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 03:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab0GaBFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 21:05:17 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44814 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab0GaBFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 21:05:16 -0400
Received: by wwj40 with SMTP id 40so2141825wwj.1
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 18:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=omMOc/1EU+U20LJgjS8KSbnOwtpGur2NP/8/1m1VkCE=;
        b=YPGLGsiDHUjs0XYJuyJRobQt1YxPEjYSjTW/FoOslEcwapYnmHr1NWS36wH9p0jIBm
         pjY3KRPF4fldeRwK+D6S8ygJlz9TNmXOsc+Arb8KHZGj0xAfjbTMqoiCcoNBzqvQpboO
         oICW3SnJ/+4+6nviGWknKO4NVcq7VMOrp4oH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=tM9yYQzq8xGh91jyAwaee+PwTmVL3eT/FFevERcShY8lugahxhaBZx2767rT/3XjOX
         8kPXOStXdRgRjkLAsUJ4oVeUZi6yWHMN7hTPCi/BRbA1CakG1THZ6REQRysf+9PLVnBk
         jhfExPw1YgSFkTT80/4wFp7zN5Nrr/awaTLxA=
Received: by 10.216.234.11 with SMTP id r11mr267324weq.85.1280538314685; Fri, 
	30 Jul 2010 18:05:14 -0700 (PDT)
Received: by 10.216.155.17 with HTTP; Fri, 30 Jul 2010 18:05:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152277>

git svn clone -s https://gate.svn.sourceforge.net/svnroot/gate

This worked with a previous version of git, I am sorry to report that
I don't know which one.

When I run it with GIT_TRACE=2, the trace ends with:

tace: built-in: git 'config' 'svn-remote.svn.branches-maxRev' '12912'
trace: built-in: git 'config' 'svn-remote.svn.tags-maxRev' '12912'
trace: built-in: git 'config' 'svn-remote.svn.branches-maxRev' '12912'
trace: built-in: git 'config' 'svn-remote.svn.tags-maxRev' '12912' trace:
built-in: git 'gc' '--auto'

I get none of the usual 'checked through' output, either.

that's all. No errors, no messages. No branches, no contents. Just the
wind whistling through the bytes.
