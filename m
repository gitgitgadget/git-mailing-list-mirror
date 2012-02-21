From: Georgi Valkov <georgi.t.valkov@gmail.com>
Subject: [ANNOUNCE] git-link -- builds repository browser links
Date: Tue, 21 Feb 2012 02:06:11 +0200
Message-ID: <4F42DFF3.4090106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 01:06:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzdFH-0004UU-8u
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 01:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab2BUAGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 19:06:10 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47881 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab2BUAGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 19:06:09 -0500
Received: by eekc14 with SMTP id c14so2459953eek.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 16:06:07 -0800 (PST)
Received-SPF: pass (google.com: domain of georgi.t.valkov@gmail.com designates 10.14.132.203 as permitted sender) client-ip=10.14.132.203;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of georgi.t.valkov@gmail.com designates 10.14.132.203 as permitted sender) smtp.mail=georgi.t.valkov@gmail.com; dkim=pass header.i=georgi.t.valkov@gmail.com
Received: from mr.google.com ([10.14.132.203])
        by 10.14.132.203 with SMTP id o51mr11414793eei.76.1329782767982 (num_hops = 1);
        Mon, 20 Feb 2012 16:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=C1101ScSMtfLGILO6OSKzVePnATA9kB9QpWLjhCjWLo=;
        b=aNQecqZ25LfI6SPtrfcfPYPjILrjigtZrnH1A9rUTEQRCdj6hc7JcFb6EUip2+4HUc
         CxlmffE9EMlm2eWW5M3qQL535LQXjWAlaLyG57do+i2s4nZ0CDt5R+frXVYngbHpPb4p
         eXBTgoolli2mZhWHk7A3PqfmK51TksHYbsYKY=
Received: by 10.14.132.203 with SMTP id o51mr9075616eei.76.1329782767917;
        Mon, 20 Feb 2012 16:06:07 -0800 (PST)
Received: from [192.168.1.101] (92-247-205-65.spectrumnet.bg. [92.247.205.65])
        by mx.google.com with ESMTPS id s48sm80828642eem.0.2012.02.20.16.06.07
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Feb 2012 16:06:07 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191127>

Hi all,

If you find yourselves sending out a ton of gitweb, cgit or github links 
every day, git-link is a sub-command that can speed things up for you by 
eliminating pointy-clicky time that you would spend in a browser.

Example:
 > $ git config --add link.url http://git.kernel.org/?p=git/git.git
 > $ git config --add link.browser gitweb

 > $ git link v1.7.9~^{tree}
 > 
http://git.kernel.org/?p=git/git.git;a=tree;h=903db0d86a809b1f84415654369a3cf6dff5f4d5

 > $ git link --clipboard fsck.c
 > 
http://git.kernel.org/?p=git/git.git;a=blob;h=6c855f84f01c19678399d85181da1094bd61b371;f=fsck.c

Links:
  - https://github.com/gvalkov/git-link
  - http://pypi.python.org/pypi/gitlink

Best,
G.
