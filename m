From: Oleg Serov <serovov@gmail.com>
Subject: Incorrect time on different machines = file changes loss.
Date: Sat, 12 May 2012 16:12:45 +0400
Message-ID: <CAMkKa8D0+9M8QF51r_5kPx19rQMKh+8oXs7z9dtSLkfb=a2MtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 14:13:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STBCC-00006h-Cr
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 14:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285Ab2ELMNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 08:13:07 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:61702 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab2ELMNG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 08:13:06 -0400
Received: by qadb17 with SMTP id b17so1871380qad.19
        for <git@vger.kernel.org>; Sat, 12 May 2012 05:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=C6YZD6MGCd2NTFh5H7Ck0H0c7BhyD+83zsgCry1B/+w=;
        b=dItRDTvcAXOCzN8JMWmb8qNpMA89n2r88Na6wyuKdWonf4lMja8ft+lpZi7WrBGit0
         ENB+F1JNKbu7Sc3pkZ1bnxFtvKtPC3WYEMNsN6Nj+BKwWF+uJfW/YlKkGbpessoJC929
         MIIpkUKZl8hN86C3IT3msMvKNZ9zz/o2+R6Vr9KoePkfEKZEFjQ1MUjEDdIqePu/9Qtn
         kkDBDy2emahU2WBBq407xmFNYK6kpk7Xb3ZKopmL2PkhNkFOMZ2tG0dALXOZjyYdVP6W
         zumLNMgSPRQTXF61Zg119a0RtGUXIGMdyArsW1meu6MNfKe1ZCi+XsdjRp74qBBmowJN
         WP+g==
Received: by 10.224.209.4 with SMTP id ge4mr2411732qab.12.1336824786263; Sat,
 12 May 2012 05:13:06 -0700 (PDT)
Received: by 10.229.18.8 with HTTP; Sat, 12 May 2012 05:12:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197728>

Please add local and server time difference check when happing pull or push.

Incorrect time on different machines = file changes loss.

Thanks!
