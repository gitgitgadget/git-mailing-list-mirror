From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Finding all branches(remote and local) include given commit?
Date: Sat, 12 May 2012 20:42:10 +0900
Message-ID: <CAFT+Tg9nJZ7E3FB3nA6+_TR=KUqu80128rL8b2DuRGtBavsj-Q@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 13:42:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STAiG-0000PF-GB
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 13:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911Ab2ELLmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 07:42:12 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57726 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab2ELLmL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 07:42:11 -0400
Received: by obbtb18 with SMTP id tb18so4572026obb.19
        for <git@vger.kernel.org>; Sat, 12 May 2012 04:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=8vpC4KWX0NoEea5iPxNl+154IQFf15wbbeqU4u40Y7A=;
        b=j/wnqKN/1lxXSjyHfB8YpvmTfRvpUIk6CKDdANnayaD8JFOL6vObW+nI9tUYKkKj5g
         kQU96BcnkgQ1nnWJVbOMLWRol1evpH9tp04EsmUrrnc9t6tSTwTZd05cds96VCDjeB+C
         9n28N9kB9uZkpgmXSA25g/7zh3yyEFYBFIOLU13k/bQYsJidlniQS50zspKuhv99QWm/
         jVpBiSDFZ9OAmsWaN4YlqKFJlY5Z2L4lzWcSpE1WQZwZZZFOMKwK34vQHZC02mu7Sjlt
         nBTwcjgwNDat8q8ySdI0DZ2aiWJf3Ntdm4ZD0xX/uda3vw7eWzgYCGTRHtVOaqyWchyA
         yw0A==
Received: by 10.60.7.103 with SMTP id i7mr1949949oea.64.1336822930884; Sat, 12
 May 2012 04:42:10 -0700 (PDT)
Received: by 10.182.53.39 with HTTP; Sat, 12 May 2012 04:42:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197726>

Is there any way to find remote and local branches include given commit?

e.g.

$ git branch --all --contains 499e7b31509cfbb59dcb2a046f8e2fd1a3e73d6f
* master
  remotes/origin/next

As you know, it does not work and "git branch --contains" finds only
local branches.
