From: "Ben Bennett" <benbennett@gmail.com>
Subject: Fwd: git status bug problem.
Date: Mon, 23 Jun 2008 08:22:24 -0500
Message-ID: <970bc7c80806230622x326c5cd3mbce57949255a067b@mail.gmail.com>
References: <970bc7c80806230619i6c060c4eld329729ec7eef1da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 15:24:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAm1H-0006WH-Ew
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 15:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbYFWNW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 09:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753678AbYFWNW0
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 09:22:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:55371 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbYFWNWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 09:22:25 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1798423wri.5
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4EG7j1pldU14gCzAjZ66HgIBha+VehsSBPdvG7LRApg=;
        b=VwBMA+r36WYBEHfduIT/MXRU2h6CB5JEq/37xwxQnLImh7DZbEcsGmS97f1k3mrKxT
         ldf1L7F/oN4H5Ks2bhmN5uf3k8Haxn9SZxU2d0yFDAFXd+fJs1kp0KdfCm2BafEmL6ku
         eDRwjhw4O5l6WBS1GG0m+SbujJT5XZNlwXsLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FNnZ9oJIfw9NU51SE/B44474nLh2kH++XpjexvyhuOERZz7ttgGavVmFKHOaY0OGoS
         lEzzGRKdXZnVa2aFAmH/qY7qEVsEEkwENG/QVBmMJwBkfPhHceGZZznwdKBYRmXUVwGI
         /DVuUFM3mG8GSIDZJQDElBbTVDVgAVBCfGdAg=
Received: by 10.90.93.13 with SMTP id q13mr9986174agb.106.1214227344860;
        Mon, 23 Jun 2008 06:22:24 -0700 (PDT)
Received: by 10.90.32.7 with HTTP; Mon, 23 Jun 2008 06:22:24 -0700 (PDT)
In-Reply-To: <970bc7c80806230619i6c060c4eld329729ec7eef1da@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85862>

I can't seem to get git status to return that a file has changed. I
think my environment is hosed up, but I don't know for sure. My
machine is ubuntu 8.04  with kernel  2.6.24-17-generic #1 SMPx86_64
GNU/Linux . I set up a test repo and it added one file to it ,
modified the file and saved . Doing git status returns nothing, git
gui finds no modified files. Doing git add * finds the modified file
and stages it. I can get someone a strace for the git status it is
only about a 1 page.

Thanks,
Ben
