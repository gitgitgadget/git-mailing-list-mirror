From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: git grep: search whole tree by default?
Date: Wed, 23 Oct 2013 10:25:55 +0200
Message-ID: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 23 10:26:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYtlS-00074H-2b
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 10:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723Ab3JWIZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 04:25:58 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:38770 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab3JWIZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 04:25:56 -0400
Received: by mail-ee0-f42.google.com with SMTP id b45so260450eek.15
        for <git@vger.kernel.org>; Wed, 23 Oct 2013 01:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=QzA9KLUNCmCqzofGfEBsM2hnHXua7tQexKUjvoG1P8o=;
        b=nw3Z0edgKlCiHjt1ecpGPkkS48GYkWVqTUeADb7p2P12+gQbJKN6uvCOUNeW+sJ0ty
         LaiYsotsmDpQdjjvhYuCMSGfLrCfg0N+caoNQc6yefsKBdLQw2BrqcInD4vzxpD1Xshm
         R1PQ770W8jbmKqUtCa5DjnQCBp5lniR4lRtR1nXaGKVcKBL8ppcsZAetq6IrvmyYmm0g
         kEnj4TMMZrmi65YWZpKIW2dpCWlL6h11vsVfL8KN8qC90yRpgYmsFBqqNSgnUqalKYp3
         3sv05+T1LnCOoNX7XJEG+muQdQykl3tp94u0OU7e4pe7iINWWjoZVOgjNo80lzU3wypU
         QsLw==
X-Received: by 10.14.88.132 with SMTP id a4mr463771eef.60.1382516755349; Wed,
 23 Oct 2013 01:25:55 -0700 (PDT)
Received: by 10.223.168.9 with HTTP; Wed, 23 Oct 2013 01:25:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236502>

Hi,

it would be nice if grep searched not only in current directory and
subdirectories, but in whole tree.

I know I can use ":/" as a pathspec, but since most git commands work
tree, I got used to this and forgot that grep is different.

It's easy to make a mistake and believe that your code does not
contain searched string XXX - because you have searched from a
subdirectory, not from the top level of your working tree. OTOH, if
grep searches whole tree, you'll notice you get results from outside
of CWD and if you don't want that, you will be able to limit the
search to '.'

I think there were discussion about how there are several git commands
which do not search in whole tree by default and that it's going to be
changed. I think "add" is one of such commands. Is 'grep' left
unchanged?

Last discussion I found is from 2011 March
(http://thread.gmane.org/gmane.comp.version-control.git/168063/focus=168188)
and it says it's not going to be changed :(

-- 
Piotr Krukowiecki
