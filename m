From: Carlo Trimarchi <mr.spoon21@gmail.com>
Subject: pushing a branch without merging
Date: Mon, 20 Jun 2011 16:11:28 +0200
Message-ID: <BANLkTin4fpwX9NgnP0U1+z9tRA=akR6MDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 20 16:11:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYfCk-0002Hv-Hz
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 16:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171Ab1FTOLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 10:11:49 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51279 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab1FTOLs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 10:11:48 -0400
Received: by gwaa18 with SMTP id a18so340132gwa.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=dB4Em/Z86LpsU8Km818BjE2DbnTYnkP1MSIDM518iDY=;
        b=fPMNLJSkg0W5SP9bCGeuYLGqtaS22Zf5ArascMxDkvgbiPknofMIDlXxTkzMPqE9uO
         EAVzscNDPZLyIQpv8/rzBtG1kkme9uslEDMpDyb8FEhwFSOF7BXs4VNdjvO6TL7khPZg
         SXUdzdQCmh4AJyAzHhnMDBS6slX+Tl7UIoz2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=T5Vb8zygxFQja5zH+XuqydYQCoSnc+7/7DlOGlvPrRKZ8eC2ED54j/I46bplRqxywD
         ICnaQwkVwOWROsJ7lk23Kbq71BVA9kEGSkNvNjjr5fzZFZ2iW/BpSDPA0FbLTVGkVkZP
         2TTxMjIrdHR9IsoMrAftR3zjfAqtQNVntEBZ4=
Received: by 10.236.119.228 with SMTP id n64mr8216206yhh.302.1308579108165;
 Mon, 20 Jun 2011 07:11:48 -0700 (PDT)
Received: by 10.236.108.143 with HTTP; Mon, 20 Jun 2011 07:11:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176068>

Hi,
I'm managing a website with Git. I work on my local machine and push
changes to a bare git repository on a remote server. Then there there
is a hook to pull those changes in a directory with the live website.
I use the server only for the development version of the site and it
happens that when I'm working on a branch feature I want to show to
others what I'm doing.

So, on the local machine I can easily create a new branch, but I don't
know how to push what I modified in the new branch without affecting
the master branch.
What am I missing?
