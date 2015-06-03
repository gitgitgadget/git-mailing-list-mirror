From: Tummala Dhanvi <dhanvicse@gmail.com>
Subject: Minor bug report
Date: Wed, 3 Jun 2015 11:24:19 +0530
Message-ID: <CAMOUyJ_2snCaKcWNoOgH7aoHrdbUsCucqu_W_J3aH9_QQe1jEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 07:54:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z01dd-0004jm-Gh
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 07:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbbFCFyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 01:54:44 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34040 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbbFCFyk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 01:54:40 -0400
Received: by iecwk5 with SMTP id wk5so5228633iec.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 22:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=WTRRH+foRTq8gprmB+OjtmXVPEBhlR0GAmg2BzkZsFk=;
        b=UBzo+z2q5e47On3WO6NMEzNrJP9Y99F+pSH+I4MSymhf1pUKTrI7IHhIEzPxNEjsD0
         DojyK2j2iL6/CAsZrurqVa6TzCXcfiLndDhBMTiWN8J4UwfwTqCkEBCt14SNQ398t5Z/
         kNnWr+QiBr4yPzDr/tN+zRFuhGCamQAYYFm0453tWFuXaRaa0e2VMnudhoRVehCEFXmQ
         B2ayQjd9N1mPQPtxd8GyoawXCUO6AQcuFeA73HF1JJyJ7rivgexLLqPzhMgLOUmjqr/0
         JoZal0iX5Hp5npJ7DYgfIMeBjmfK+razuEXvp9ET5rkY9q4/CgLE91FOlDn7fM91up69
         +y9w==
X-Received: by 10.107.134.153 with SMTP id q25mr37374887ioi.27.1433310879975;
 Tue, 02 Jun 2015 22:54:39 -0700 (PDT)
Received: by 10.50.132.97 with HTTP; Tue, 2 Jun 2015 22:54:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270629>

When we do create a new empty git repo using git init or create a
orphan branch and do a git log then I am getting an error saying that
fatal: bad default revision 'HEAD'

Well the error should have been something like no commits to show
either the branch is orphan / you didn't make any commits in the new
repo

I would like to fix the trival bug myself can some one point me in the
right direction to fix it
