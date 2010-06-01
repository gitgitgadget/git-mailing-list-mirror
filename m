From: Sylvia Liu <sylviaonlyone@gmail.com>
Subject: HELP: cannot clone a repository via http_proxy on FC13
Date: Tue, 1 Jun 2010 11:30:00 +0800
Message-ID: <AANLkTimefBKp5So03RKaZRqQXePO1KY6EgMRxN0zsf8M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 05:30:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJIB9-0004DL-4L
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 05:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab0FADaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 23:30:04 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57545 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab0FADaB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 23:30:01 -0400
Received: by pvg11 with SMTP id 11so1567319pvg.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 20:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=ah0wD8M/OdmGSXXV19XsLKHPIDQcEdshi3I1+kaW3tk=;
        b=WyvTZNgEtNZK4jyykimGN83gdSTW/w/L01RqPhxt6GTiGeWWPRkjRFj/w4pa3lUNcP
         wxwdfTV7UUZfmPn3KNfYVGbuWhH5UyiTvLI3uXsdSNi8kUBP52JtqjJeDXb59zBVMcXD
         2bQDS5Rh+X7pbWaioInT6OEbJx/AUO8iUY+Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=VL9UmVQlMycJXU6IJtspb/xhDM2KyUIsUE+LjQ8F3wMWivPfG8MHMSJBFZAzQmaDkQ
         YbqqCPrRQ3cWl8JBtrDHIfTLmWfVB5hoEob2xXohjzpwUREVz6tg8uvJgexqaZ+xYEeP
         9VJv94k2Wl9YfE33F2xUovJW6UOfGzbeL77fc=
Received: by 10.142.121.1 with SMTP id t1mr3531431wfc.100.1275363000078; Mon, 
	31 May 2010 20:30:00 -0700 (PDT)
Received: by 10.143.40.20 with HTTP; Mon, 31 May 2010 20:30:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148072>

Hello,

I cannot use git clone to get data from a repository.

I encountered the problem and searched on line without any solutions.
So could you please help me on this?

First, I have setup the http_proxy as an environment variable. And I
can use wget to download the repository page.

--- On my FC13
System: Fedora 13
Kernel version: 2.6.33.4-95.fc13.i686.PAE
Git version: 1.7.0.1

I tried this command:
   sudo git clone
http://git.gitorious.org/meego-developer-tools/image-creator.git

got the error messages as follow:
   Initialized empty Git repository in
/home/sylvia/workarea/DEV_TOOLS/test/image-creator/.git/
   error: Failed connect to git.gitorious.org:80; Operation now in
progress while accessing
http://git.gitorious.org/meego-developer-tools/image-creator.git/info/refs

   fatal: HTTP request failed

--- On my FC12
I also tried on Fedora 12, same error exist.

--- On my Kubuntu: it is working well.
System: Kubuntu
Kernel version: 2.6.31-21-generic
Git version: 1.6.3.3

Seems it is something wrong with Fedora.
Can you help me on this?
Thanks a lot.

BR,
Sylvia
