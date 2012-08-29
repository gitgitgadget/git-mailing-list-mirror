From: Dun Peal <dunpealer@gmail.com>
Subject: "warning: There are too many unreachable loose objects; run 'git
 prune' to remove them."
Date: Wed, 29 Aug 2012 14:16:55 -0700
Message-ID: <CAD03jn7yxgJgN3n9yV7gfDx8OE5e+V0EQtcOFro1Hmb8Da8AjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 23:18:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6peD-0007hW-Op
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 23:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab2H2VRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 17:17:18 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40927 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab2H2VQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 17:16:56 -0400
Received: by eekc1 with SMTP id c1so433361eek.19
        for <git@vger.kernel.org>; Wed, 29 Aug 2012 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ZKXnn+U/2yu8s/FVwZ/J88MPQz3XYHf7lgcRlYcHR6g=;
        b=fAkrOWWQgSyrG0Z3oZhZpxVKOe5Xxfy7N8hx0UhYMAad8eeEAknfXWGyPR3//JDNwS
         JXnuQqp7GQO5TDh06eWOGieEV2GyeLHtyKXIwiCpNQy7hzmhAIP2fSDkLi38ju1cfzHW
         WYUNBgGA9HpRh2HmsoQPwe4+bxxGn1sU8nI34ECrW7NPPsSOtS3MHY1oTuQ/4LzXnahN
         L1PDmtPaeBdhuVfIAv9xwmxJKruE3hr2zWnZMiG1QYr7Fw5LdUCskmGBRVqin4D8pxhs
         f5bIt7zX6IpJXahC7xfCdY5VXqjlwDPJlZG23d11A5dhbKbIElwilDxZwMnYvEo9b+5/
         QcsA==
Received: by 10.14.5.78 with SMTP id 54mr3843655eek.1.1346275015313; Wed, 29
 Aug 2012 14:16:55 -0700 (PDT)
Received: by 10.14.183.73 with HTTP; Wed, 29 Aug 2012 14:16:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204500>

Hi,

I am getting this error every time I pull. All the following have been
executed, but failed to remove this warning:

git prune
git prune --expire now
git gc
git gc --aggressive

What should I do?

Thanks, D.
