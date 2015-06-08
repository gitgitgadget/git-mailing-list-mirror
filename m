From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: GNU diff and git diff - difference on myers algorithm?
Date: Mon, 8 Jun 2015 11:34:25 -0700
Message-ID: <CAB=NE6XRnKAY6t+dxT7vO_4wqngXvULh-CqezEAs2r99FkNCTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Julia Lawall <julia.lawall@lip6.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 20:34:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z21sq-0003Ti-Ul
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 20:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbbFHSes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 14:34:48 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36371 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbbFHSer (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 14:34:47 -0400
Received: by igbpi8 with SMTP id pi8so68518915igb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:cc:content-type;
        bh=IDpjTKtEOMcrEt7aE8CzYQ4hMQTGa6GK3/mw3htU16I=;
        b=A4nNwwAuhMZE6I4g0QfuvSPLGX0AIvQY2XgsM0Pf5AuZNPO+W+3Nfa5n9p/jOoNWHV
         /bYLVMYiQ6nCOjVyOVupTKMD4LvLAmtvculg5Dg/3irhOAgo1TySF6a+uIVlbx6+gtGD
         BgkxUehYDynyxm2OB5NfucwdCMGiY1Sj0u0G9cNhj9pOd74aSziaiw087HZ73161QqAK
         aJproajS/dFS3VoDknaMwmWeNUduY52J41EI0ZpZKfzlOP3cnLxtdPxAguUDI/BvjVMh
         HTWuxIpMBBUEeTyN/OLJrm7rJIN1iqNtTzJ/HvthTEYExHS8PdV4m6tr5cvkcmn0tGR/
         Ep3A==
X-Received: by 10.107.17.66 with SMTP id z63mr17658356ioi.81.1433788486246;
 Mon, 08 Jun 2015 11:34:46 -0700 (PDT)
Received: by 10.107.29.196 with HTTP; Mon, 8 Jun 2015 11:34:25 -0700 (PDT)
X-Google-Sender-Auth: Ki75ciiS4_8GqVLHoCMGr-Yx_ys
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271103>

Based on a cursory review of the git code I get the impression that
GNU diff and git 'diff' do not share any code for the possible diff
algorithms. I'm in particularly curious more about the default "myers"
algorithm. I can take time to do a precise code review of the
algorithms used on both GNU diff and git but if someone can already
vet for any differences that'd be appreciated as it would save time.

 Luis
