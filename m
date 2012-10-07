From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Applying git technology to fix the locate command
Date: Sun, 7 Oct 2012 15:18:07 -0400
Message-ID: <CAKON4OwRuEhaHhCkv6oS+wL1NEp-3DyWcYbRqq5=RKuqgs8f0g@mail.gmail.com>
References: <CAKON4OzyAt-e0Ygj=7+Ze7ywU+RNTsi-Nn5huCnEWy8o=a-EUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 21:18:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKwMm-0000Ec-BS
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 21:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656Ab2JGTSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 15:18:10 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57270 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296Ab2JGTSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 15:18:08 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so7658556iea.19
        for <git@vger.kernel.org>; Sun, 07 Oct 2012 12:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=oXOx10co9/k4UZzHxLhX+vYye3oteb4Xqry+5DW4kmo=;
        b=gAYqEJxjUXb4ejzT+7gaph7AXAz32mGDtjc7hbiw4W393NxCTY1ZI+Vn/HvVZ5dq+w
         WWlwiNwn3ENT8z/5h/hoPx6ZREaU5Hfkfq8FR0lRzX3EMenuCtz69DIcx4vMd48MWfJe
         olEHwz3fSNd2Hiy35p3v+kNJR0dZeGQJ+fv1ob4XvCaKFyPw2C6xmsqjwcojJGxpEDXq
         l1J1gNJ931TOewQbfKiG61UrCeYD/KyKg9I9NM83sCfBIdS1lsVTTJwn7HvfvAZ8efqR
         38CnkSK3WllBCQ+y/ozEs1ksCJqKB9KiLF/JsjAhyv/L7rnKU/kzDHMK9+0D25ik6XsC
         5IFA==
Received: by 10.50.222.233 with SMTP id qp9mr6245169igc.61.1349637487975; Sun,
 07 Oct 2012 12:18:07 -0700 (PDT)
Received: by 10.64.55.234 with HTTP; Sun, 7 Oct 2012 12:18:07 -0700 (PDT)
In-Reply-To: <CAKON4OzyAt-e0Ygj=7+Ze7ywU+RNTsi-Nn5huCnEWy8o=a-EUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207187>

I played around with updatedb.conf to exclude .git files and my
/exports directory. I got the db down to 136MB and 4.5s for a null
search.  This command still needs help.  Given that I have the entire
db file cached it should be able to respond instantly on a null
search.

-- 
Jon Smirl
jonsmirl@gmail.com
