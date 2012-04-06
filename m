From: Alexander Kostikov <alex.kostikov@gmail.com>
Subject: Status shows untracked directory without any untracked file in it
Date: Thu, 5 Apr 2012 22:19:00 -0700
Message-ID: <CAGAhT3n3hHV+UhT+D1o60OAS23WFmx+Lxg=aqYMGC=U-LR1QUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 07:19:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG1Zk-0006bo-7u
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 07:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab2DFFTB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 01:19:01 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52975 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab2DFFTA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 01:19:00 -0400
Received: by gghe5 with SMTP id e5so1156033ggh.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 22:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=4Ff7KDAkaFLtvQjnVPj0R1jg3xUQJGsYh/b4gLUBVfA=;
        b=HVaS4xZFABq0BzC9MMaR4toJxvXq6R2HBtK/0PT4YQ+OHmiJylrOaakRAo2+LmGtkf
         i4wOu1U0CsVasc9zPS7j1yv9FMyOGtnMRwFoTeYnXjk3Jd2Apu9B3NaYb93lcHuYHMJW
         +GZRUg5KiabeIx+9WRUqPa3TQ6E6uNWRXAHX/0GqbP4fr/ldyyRRDB2y/wEgFGg3TnOX
         yNSv0kOyGCKzIqVpPJTH6i60WQp7H0h50F9YDTbZwhfTv2vY0Ct6XzwgKe6AAaOhJrxm
         27DR+akJzVFEhjT++l3CfV35l7NtS9o7p2kgsHaaFPNwby8KkwTRqqozeeJ+YtS6RBH+
         XX+g==
Received: by 10.236.78.74 with SMTP id f50mr5531238yhe.26.1333689540260; Thu,
 05 Apr 2012 22:19:00 -0700 (PDT)
Received: by 10.146.84.15 with HTTP; Thu, 5 Apr 2012 22:19:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194845>

How that is possible? Is it a bug?

alexko@ALEXKO-LAB b:\
=BB git status --untracked-files=3Dnormal
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       data/fex/lba/hi/qna/
nothing added to commit but untracked files present (use "git add" to t=
rack)

alexko@ALEXKO-LAB b:\
=BB git status --untracked-files=3Dall
# On branch master
nothing to commit (working directory clean)

--
Alexander Kostikov
