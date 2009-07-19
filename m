From: Rustom Mody <rustompmody@gmail.com>
Subject: how to start with non-master branch?
Date: Sun, 19 Jul 2009 18:23:32 +0530
Message-ID: <f46c52560907190553x4e21ffbdn6d55c43f2d6b08ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 14:58:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSVyY-0001yN-0b
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 14:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbZGSM6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 08:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754220AbZGSM6i
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 08:58:38 -0400
Received: from mail-px0-f185.google.com ([209.85.216.185]:49664 "EHLO
	mail-px0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbZGSM6i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 08:58:38 -0400
Received: by pxi15 with SMTP id 15so1310293pxi.33
        for <git@vger.kernel.org>; Sun, 19 Jul 2009 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=gM0rQnu7358goFuNKPFbJwVK9P6HUhskPj7sOsRGvTQ=;
        b=YUmszJhG5ksB7f53yYmkKuXvSHMvh1T3NAs1Q3sxQpCEnwvgtW3kOHI9yllsUPCzUB
         aNoqRwvHncXLtk+zrrss4XLe8XV3Qlbp6lKWXSGBjHK6IIP5Oauv4eKHPNx0Ij3AoLu+
         EyxaDyYlQuXE/Ysogtvidz9z3PwTdwWiGznfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=nHg6EdKXqP+CEb9NTBdp/kWUjhCTqDCBxXJECvhoDLnK/d0/M6Ui3ymum2GdhFjxd3
         traCAS9lzx9LQu7fDCWf7+PxFOth07ltOlafx+atYvLX9rlTR+6Etn1I6ld/2S6zp7nB
         kIglS9N8EEXDGtPJ6tSOPVn4mto/EwUt+B8Xs=
Received: by 10.114.147.1 with SMTP id u1mr5298100wad.108.1248008012381; Sun, 
	19 Jul 2009 05:53:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123551>

I want my first commit to be on a non-master branch.
So after the git init I do
$ git checkout -b newbranch

I get
fatal: You are on a branch yet to be born

Of course I can get by with making the first commit on master and then
switching.

But wondering if I am missing something basic?
