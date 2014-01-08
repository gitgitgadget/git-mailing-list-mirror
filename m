From: Li Zhang <zhanglii2011@gmail.com>
Subject: It seems there is a very tight character count limit in .gitconfig
Date: Wed, 8 Jan 2014 14:59:37 +0800
Message-ID: <CAFc+-Siu1nyBMWvUG52SXdoMPWE-NZ7GAjWe9C-W=z-MWnn5zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 08 07:59:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0n78-0005F2-JK
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 07:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbaAHG7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 01:59:39 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:51472 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaAHG7h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 01:59:37 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so1408034pde.7
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 22:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=UvfIUBT5TcSkui6CJs2Z/d75xhg2wY5/9oyOjoT7DGo=;
        b=SlBsbTU5hE5wCmi8L9i61/00uZdEF+VoINTWki+X+FrSMeVHbawDOpG7KE1RWnf2Iz
         pOZABaYLBYZ0wHIJU513EKedgN7LAvoIZf6PB4dOkTtNRtV1Yw1XCZNBdLD2I7r0MtEz
         9nEQs38+i8yLANMSLq2uauwQvqKRwo0GRKG4fz/VUYWcYbyO/7d92b4aV+lUv7b08xpl
         Owu3pMdsw91ivh3xeg8zhuMMxj62M1tEFjIVVgfxcm7JVIgLLZTBm3C83YI4HZjM5R2E
         j7Vcw2KXKRmqiayommOMtzS6H8j5WWH6E/5cm6FvCBggt+hKxTvswjI+iECIT3gsGkge
         gVIw==
X-Received: by 10.68.129.201 with SMTP id ny9mr140792928pbb.70.1389164377508;
 Tue, 07 Jan 2014 22:59:37 -0800 (PST)
Received: by 10.66.164.40 with HTTP; Tue, 7 Jan 2014 22:59:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240195>

I tried to add url xxx insteadof xxx in .gitconfig. If the length of
url exceed 125, git will not work.
I am using Ubuntu. The default version is 1.7.9.5. Maybe the latest
version solve this already.
