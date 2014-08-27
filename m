From: Max Kirillov <max@max630.net>
Subject: [RFC] add detached HEAD to --all listing
Date: Wed, 27 Aug 2014 17:18:21 +0300
Message-ID: <CAF7_NFRKzU0_5Eq4kgtW3RChW3z5q8QBjWvvN+TSyOhORkf8hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 16:18:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMe3Q-0006Gw-JD
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 16:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934769AbaH0OSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 10:18:24 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:52888 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933583AbaH0OSX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 10:18:23 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so505773wib.14
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=j/sATXg0DUClgh/wymrWacjhgcrR3gdMHuzqcgdGAuQ=;
        b=a0PsVnIcP6EfgehE9cgTYSspl18KVcCBa8UHrRPJzXnXMBMZ54TPjzTtg66krz7J5U
         +Ld3j9Cjd0lmwSFjKmW14OYxG9zGeQovc14Qh6o8E0AxKxAWdIIE1/92se6QCT6JklQY
         6qYcHKCU7OfVS1M48+YsvuiAzz09QFXk5PtVWEkVhXAACGTWo7oeSS0BfXi88j0iIOZF
         /a6BBKoyo1GpFDZN8VUnFPEXwubIvLktgFD/dJqH/+Dst6Y0EDmlkb2I6/Kst8++831R
         YsFDSWQk1oS6+iwHXJHE7c0WWPYnvyqWZMqC5QhuVNBghiu+XbKkY8RRI0PdcwtbZAS5
         mrlg==
X-Received: by 10.180.36.236 with SMTP id t12mr22828970wij.38.1409149101935;
 Wed, 27 Aug 2014 07:18:21 -0700 (PDT)
Received: by 10.180.9.170 with HTTP; Wed, 27 Aug 2014 07:18:21 -0700 (PDT)
X-Google-Sender-Auth: 6hDvCmEU4tJVwT4hd2vkhcYMNEc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255996>

Hello.

Could HEAD be added to list of heads while using --all switch?
Detached heads are not something very unusual and incorrect, in
submodules for example, or for some scripts. Having to specify it
additionally when I meet such checkout feels like some flaw.

What are opinions on that, could it be changed?

-- 
Max
