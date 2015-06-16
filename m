From: Florian Aspart <florian.aspart@gmail.com>
Subject: Using clean/smudge filters with difftool
Date: Tue, 16 Jun 2015 16:11:03 +0200
Message-ID: <CAGA3++LiX9NyK94RPiuiG83X8FSRN4EkaxMchir51hGSQY90Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 16:18:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4rgn-0001U7-PX
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 16:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbbFPOSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 10:18:05 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34946 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbbFPOSD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 10:18:03 -0400
Received: by ykar6 with SMTP id r6so14374673yka.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 07:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=o1zU1RFLnqv/q+Owdx4dlKKGVd9NICaYdPcrcD0gev8=;
        b=n0MkUJYgM7cAk2r/Bvjk89zQxvtGw1lnMjgU6gCDJgaK05lOmKmRV4UHwC/NmY7vX7
         //vP67JctprnQuOIVoQwYfLfur4b5gJFq59TTyXmYB018KBzovlJbFZu5LwE3u39+NCO
         9Mt4zi46CYzKQlyMhPl2xW2R2cyMuAGPIrRnBlhmDNuRCFSCnXmY26EbdoxNgjF9P/G1
         s0KXGl9olMHupNgm2JbbIn3joB8o49KGsuHjU51u2mMzIf3hSOBfLzwwGF/U0HoLRgC7
         /c71vTK5INScrFAmp4/cvMSJkbub2Gj4Y1br+rVMcjyblsQI1gg5E5D6uFDVqR7pkF6r
         Vmzw==
X-Received: by 10.129.87.133 with SMTP id l127mr741597ywb.2.1434463883841;
 Tue, 16 Jun 2015 07:11:23 -0700 (PDT)
Received: by 10.37.114.85 with HTTP; Tue, 16 Jun 2015 07:11:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271753>

Hi everyone,

I created a clean filter to apply on some files before commiting them.
The filter works correctly when I commit the file and is also applied
when I usethe iff command line tool.
However, when using difftool with meld, the filter is not applied and
the different versions of the files are compared without any
filtering.

Is there a way to apply the clean/smudge filters when comparing the
working copy of a file to the HEAD version in a gui diff tool?

I'm using git version 2.4.3 under Ubuntu.

Best,
Florian
