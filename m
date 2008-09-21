From: Guo Tang <tangguo77@gmail.com>
Subject: out of memory problem
Date: Sun, 21 Sep 2008 15:59:30 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0809211556030.19373@homelinux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 22 01:01:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhXvA-0006Qo-GT
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 01:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbYIUW7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 18:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbYIUW7k
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 18:59:40 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:61567 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbYIUW7h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 18:59:37 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1326319wfd.4
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 15:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:x-x-sender:to:subject
         :message-id:user-agent:mime-version:content-type:from;
        bh=NRW7Oei3zG+12sAk/uXmb+XvwnI79Nwv+W/40KR145k=;
        b=Pby2SqjYagTIsHLeCW5XgYMZFGMEyHDUC7azsPegdVdTnO7n7L82w+AoXMzroDul+X
         2yosoPDzSjAXeufeQIIz4QgOtGn280t3WRu5+n6XI1ULUunq55oDqXSdK0+YLeZ2wINM
         VvXnMqFspMj+5zY819sAgfg4O72hUxTQAQ++4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:x-x-sender:to:subject:message-id:user-agent:mime-version
         :content-type:from;
        b=OUXNbezytJoP13aSyNyj0bMNnx2niIwDEudQFm80yTAtxrbM9G2XwSlnvM67Gv/gtY
         UxIuOnJi/Va/7K+6o4MiUiVbnrzVgln7wglxgyPV4AyDcW9seTZzh+v6bEo2abXwPRM9
         XkLGjmFytgmRTatzfvolTFIvZqFiYkgeTCfdg=
Received: by 10.142.223.4 with SMTP id v4mr1098277wfg.172.1222037977275;
        Sun, 21 Sep 2008 15:59:37 -0700 (PDT)
Received: from ?192.168.0.103? ( [71.112.83.225])
        by mx.google.com with ESMTPS id 31sm6185974wff.16.2008.09.21.15.59.35
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 15:59:36 -0700 (PDT)
X-X-Sender: gtang@homelinux
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96445>

Gentlemen,

I try to run "git gc" on linux kernel tree. The virtual memory keeps 
going up until over 3GB, then crash. 
Tried twice with the v1.6.0.2, same result.
Then I used the git coming with FC9 (v1.5.5.1), the peak virutal memory 
usage is about 1.5GB. "git gc" finished without any trouble. 

Could there be a memory leak in v1.6.0.2?

Thanks,
Guo
