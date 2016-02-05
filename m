From: Britton Kerin <britton.kerin@gmail.com>
Subject: no luck with colors for branch names in gitk yet
Date: Fri, 5 Feb 2016 11:48:33 -0900
Message-ID: <CAC4O8c-MPwrJ2H+iHjQxk+XoX4_vPm80Lz1=wbuHHd2gsB8R0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 21:48:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRnJ0-0001nD-Lm
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 21:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbcBEUsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 15:48:35 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36975 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbcBEUse (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 15:48:34 -0500
Received: by mail-wm0-f44.google.com with SMTP id g62so43581125wme.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 12:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=HTI/OPAcHd4exg6XHMibBarsxMhJvKANJgFqBXUANY0=;
        b=qM6ie9ZqOQgU030qgAw8UW31iMguJ/thQHTervEdC+dEgDe3WlOQ5+bhSvjGFvrX6m
         Qm5/6hYo47hefG6xX0Kr1R5aUKNk2QtmDQ7TUDs/6ixwDGKJDOfqFNsKQZIoyRWWKLST
         U9+Brdyxoh5LiaHvUBVigvpECvyXtJtu5tJuTcHuTC7MoAR4n3cd3xMhBJZVWDo1ngz3
         1tHKUsDn92aN5NG0MpanUgF5ORb5FyBM85KasJh+8Z4xWEM+RY6/PGVu0aop8hruyVnE
         V269d66xkQ4nkEGHnNN19N9BhWd5Oo4DsAMBSlZ8agbmC+PMrbS9JSMwS+ZbBH3kIPN3
         /bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=HTI/OPAcHd4exg6XHMibBarsxMhJvKANJgFqBXUANY0=;
        b=ML0n7CXSDCVgmWDtpLa9Qdpe61VrSIgSd35at7ZKfBMZ1/SR/dSwMom1FnEI/RknQm
         nUnD75R2EJF3dWTYox3+HofH36Mu12up7vHKpjlHw8N8eqHQ6NSJR+Zeb74bEAiWgd6+
         Whf6o2ro7wczB0CYPMbgJAD62jCNX67UeXbrVMUgQwt4uCpYzsEdrWHyRyCcIhfaFRdw
         JrAjIEFf//zJtYymRpjPCGoy+HRhZcRBqMd9vSd3Ex5u5N/GHalnOHCgOob8pzXtZLWy
         WtDBk2GxV5fSGMZgS7XO29i04CjznVR/2xMcHjUCp7B3ARFzWfI/B9rK+oeQfq+CciD9
         VW0Q==
X-Gm-Message-State: AG10YOQ2jV7C5Yvm8Jz617Vqk3yuzn6PFPB6tY2d2sDtpgWrIlZDyAj/Ljg0gsWswcAZSQSrjuki25qBjUY7mw==
X-Received: by 10.28.48.19 with SMTP id w19mr30672765wmw.18.1454705313560;
 Fri, 05 Feb 2016 12:48:33 -0800 (PST)
Received: by 10.194.178.161 with HTTP; Fri, 5 Feb 2016 12:48:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285629>

Someone suggested using color.branch.upstream, I tried like this and variants

[color "branch"]
  local = red bold
  upstream = red bold

Doesn't seem to matter what I put in for upstream, including invalid
colors, gitk just ignores it and does the dark green for local
branches
