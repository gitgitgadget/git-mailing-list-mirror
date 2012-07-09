From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Git and Quilt
Date: Mon, 9 Jul 2012 23:38:45 +0800
Message-ID: <CANYiYbG2UuHJOU7b_jR7E5N6WxJqUK_URXkN2zrz+z3JEukOzw@mail.gmail.com>
References: <1341835029.10119.36.camel@sysadmin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jimmy Thrasibule <thrasibule.jimmy@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 17:38:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoG32-0007tZ-S9
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 17:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab2GIPir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 11:38:47 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55151 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab2GIPir (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 11:38:47 -0400
Received: by yenl2 with SMTP id l2so10182955yen.19
        for <git@vger.kernel.org>; Mon, 09 Jul 2012 08:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yi5ADcAm7/ZohWZkeeZlaw2jnujNZpWUJKkKV/YvpP4=;
        b=rKcs/99UHBtkuo+zS9TTsZr/RYocEYUlvkCbjrZphEzYjCKIjodJJAiIXyws5bRywf
         4756/0pzk5OOejibjPrm5HsZhT1J6QwN2C90lVhPUk/AGRa0oO2DAuxtPJyG9dEBdva/
         OADzwqvjw3I4uK0PKWLcRXSsZbVTUHt8HgrZS8W9kl/yckrcYkrwRY1/Gs+Zb5oICjZr
         FEs4hSzl4b+YkWv+I47SqkdAflvfmeZ+in2vm3X3O+uC+nWZRd0LfTsNZkeHQjssFd1o
         BvlOECo63k7ZfK3B718uKScjUMhtK+qCdbZa3mN1hP0gA/HWmk0EkiG3wRERL7hOMNh6
         9wwg==
Received: by 10.50.237.34 with SMTP id uz2mr8925168igc.19.1341848325981; Mon,
 09 Jul 2012 08:38:45 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Mon, 9 Jul 2012 08:38:45 -0700 (PDT)
In-Reply-To: <1341835029.10119.36.camel@sysadmin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201209>

2012/7/9 Jimmy Thrasibule <thrasibule.jimmy@gmail.com>:
> I have a core project on which I maintain a set of patches using Quilt.

Git + Topgit is a better solution for your case. See:

 * http://repo.or.cz/w/topgit.git/blob/HEAD:/README

E.g. In my fork of topgit, quilt patches resident in "debian/patches" directory:

 * https://github.com/ossxp-com/topgit/tree/master/debian/patches/t

And these patches are exported from the topic branches using this command:

 * https://github.com/ossxp-com/topgit/blob/master/debian/rules#L53

Git also has a command which can import quilt patches as commits
on to the current branch:

    $ git quiltimport

-- 
Jiang Xin
