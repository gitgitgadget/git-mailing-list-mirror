From: Dilip M <dilipm79@gmail.com>
Subject: Common setting for interoperability repo across windows and unix?
Date: Tue, 3 Nov 2009 20:39:50 +0530
Message-ID: <c94f8e120911030709h29c5b8edr53df269632990e81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 16:10:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5L1d-0005cX-VD
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 16:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbZKCPKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 10:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbZKCPKM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 10:10:12 -0500
Received: from mail-px0-f179.google.com ([209.85.216.179]:39884 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbZKCPKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 10:10:11 -0500
Received: by pxi9 with SMTP id 9so3933054pxi.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 07:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=ZZXHhMJcYQ/qpVNA9IRQ7ihJa23P11s1ruP47YdhHHc=;
        b=rCx//wpQg4Kl/Hy3ND+ms4ox8zW2MZnPTBVmTuK4l/P6d0l8u0LLpXS1AyfagTx1Vv
         Bs3j7RWpNSYudYBY/th+2E87eYgQoYAlA9l/IqLPEWsz6NG77WyYRU89UMB7NjmGjy6M
         W0csE51cRnGZ6kUKvoz8rGNAzJNnKS6oA4JxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=fz4vVohA6d87jEPyqmdeF15d3zFh7b33w2Id6gofmOKnhnse04em50x4S6iTZItguo
         jZNcF9wwHnn0vKvmsjPmk0HnhajSRlyanbDV2TU6r9dRODiSd36th1GphsCnENf3EjX9
         cUhZsRQeqOzrhk4gysYOk/sYWppk7dab4ItuA=
Received: by 10.141.27.20 with SMTP id e20mr5531rvj.53.1257261010081; Tue, 03 
	Nov 2009 07:10:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131972>

Hello,

I have repo in unix. The same repo is cloned onto windows.I have set
"core.autocrlf=input" in both the repos.

When I do some change to a file in windows and push to unix repo, I
get file deleted If I do "git status"?

What is the setting to be done if I want an repo to be
access/push/pulled across windows and unix?



-- 
Dilip
