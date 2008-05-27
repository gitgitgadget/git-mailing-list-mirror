From: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
Subject: setup_git_directory_gently contract question?
Date: Tue, 27 May 2008 17:10:42 +0300
Message-ID: <8e04b5820805270710v3a06e5c2if2dcf3b94ef40c1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 16:12:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0ztp-0006bB-Mf
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 16:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307AbYE0OKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 10:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757280AbYE0OKq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 10:10:46 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:28181 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756535AbYE0OKp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 10:10:45 -0400
Received: by py-out-1112.google.com with SMTP id p76so2113600pyb.10
        for <git@vger.kernel.org>; Tue, 27 May 2008 07:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=DVxghVc5WzH+bCMDn/NqoDS5/xm6cann64DISoN7KpA=;
        b=reqWl0WMkPVncc7Gt7Mg4jp/ZbN5L9a+PfWf5RwZQ38jqRHApN7Ur4IsEQr3cZjMuJ1jcChKoMhmxcJAL91sVEFdMYuDEciVgOSuWvcwYkXpsLKO7orJFAjg6k7QVduEkn9tLY1yWF7yyKz74zR5Cw1oht8mPSTiiE9S87d0mmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=irZGWFo+u+lZnotDhHFXM/qp93Qvs+8Ur5qQROLVK4AxlLt9Q4MjQWRUdmj02wjFibcjxGfFVHgmsfgkeRJhhMVgXbyTgfNLpLUijec+V4+V6cBmfw2Kne2M5flJF+8fdJvHTg4PirwccNFTXlz9jpnKD1kGTe4sdxcvpe0fs6Q=
Received: by 10.140.174.18 with SMTP id w18mr558520rve.227.1211897442204;
        Tue, 27 May 2008 07:10:42 -0700 (PDT)
Received: by 10.141.37.3 with HTTP; Tue, 27 May 2008 07:10:42 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83018>

    Is the function setup_git_directory_gently supposed to change the
current working directory, or should it keep the initial one?
    What is the meaning of nongit_ok?

    Because if I use nongit_ok != NULL, but *nongit_ok == 1, this
function changes the current working directory to the top of the
worktree directory.

    Thanks,
    Ciprian Craciun.
