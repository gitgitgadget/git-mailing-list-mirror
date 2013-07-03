From: Gareth Collins <gareth.o.collins@gmail.com>
Subject: git subtree push-all and pull-all
Date: Wed, 3 Jul 2013 15:56:36 -0400
Message-ID: <CALemSr4Z+p7v_wQn7EOFTVHjtMYgxqGSBZf3zU5pn-eW_SEG5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 21:56:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuTAQ-0000ug-RS
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 21:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630Ab3GCT4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 15:56:39 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:61842 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab3GCT4i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 15:56:38 -0400
Received: by mail-ee0-f54.google.com with SMTP id t10so312675eei.41
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Z3E1vUzJLT+0wqz+SyAWq8Gzvf4rVBebsgCytYPCU08=;
        b=A33ovM6XZfKlRJ4epY8syGkyRyHSE6MWzbF6C3WnDXkBS50V+Jl3yJwVs2moHppRO2
         V1KR/t7APzgH1sCtfJnQu5fVS8JaYKHkivgDBlBWtXqq3S7WjMRB96WkyNi5dp3A0ZvY
         GYp8jUzJyf4R5FBOrXju0+qGcjDysK1Z0GFiqAq2Ho6NzaMZBfdBMOCeWGLRFjaiQbnE
         1O0ACCRUhOVqa96dkerB6sk0kSByE9+P6BBcAH/+XzyA87PwaGpARrjrn5suYSk2RHi3
         ubb5QeWGPCqP6HPoi1eRRu5eEWy6wLkrBNKjEyI3wS7kJ9nuGzmALREayQO7oKim7RCE
         Ujyg==
X-Received: by 10.14.193.199 with SMTP id k47mr2777624een.83.1372881397034;
 Wed, 03 Jul 2013 12:56:37 -0700 (PDT)
Received: by 10.223.73.196 with HTTP; Wed, 3 Jul 2013 12:56:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229517>

Hello,

I see over the last year (on the web and in this mailing list) there
was some activity to extend subtree with a .gittrees file and
push-all/pull-all commands.

Perhaps I missed it, but looking through the latest git code on the
github mirror I can't find any reference to the .gittrees file or
these commands.

Does anyone know the status of this feature? Was it decided that this
was a bad idea and the feature has been rejected? Or is this a feature
still "cooking"...which will likely make it into git mainline at some
point?

I ask because I would like to use something like this to be able to
keep a combined repository and separate project repositories in sync.
Of course, if it was decided that this feature is fundamentally a bad
idea then I will do something different.

Any pointers would be a big help.

thanks in advance,
Gareth Collins
