From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: git fetch without --recurse-submodules option
Date: Wed, 16 Jan 2013 13:45:31 +0800
Message-ID: <CAHtLG6RE-xGYsp-Apcu3hk8OVck+HLYZdBtWvcweaBNetwtKNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 06:45:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvLou-00065D-TW
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 06:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab3APFpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 00:45:32 -0500
Received: from mail-vb0-f42.google.com ([209.85.212.42]:50070 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab3APFpc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 00:45:32 -0500
Received: by mail-vb0-f42.google.com with SMTP id fa15so974993vbb.29
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 21:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=TtyhteERy8IBxUIRUAlKN9kMFlJFBS33ekWC6nVLvOc=;
        b=WEZqsz+aKaJYr/SoHagO7G2IVzCyyPalWRFen2pFwyZhrK3YGTnv4Nv42THEXXul4O
         XByM1OuT1cZOGYtChG+JqFsDxftKUJ/vfT0uWqIvwS7aLnuJyYZQ8CvNqwbb4jYgdo7k
         ArDG7pXRD453oJJbZr0xliL5/UdWQWhSuKDx5OYk0lQtcu1QxF92kYGyHyLVUI+c1xbE
         CssqL0GprzMGhLRLXcRVN7EKhZ/WY/qc/MGKikX1e9s8N+WvFqT0HGeGJKn2YJKqqwe+
         z0IkS0925RvW/cfcdXUmt3U8W3VolTmtBKttb975iptB1viPYcyffhpgfo1UWZrRg8l1
         Nk9A==
Received: by 10.221.2.11 with SMTP id ns11mr106237753vcb.3.1358315131423; Tue,
 15 Jan 2013 21:45:31 -0800 (PST)
Received: by 10.221.6.201 with HTTP; Tue, 15 Jan 2013 21:45:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213728>

Hi,
With git pull or git fetch without specifying --recurse-submodules,
what is the default action?
It seems git fetches submodules wtihout specifying --recurse-submodules.
If this is not clear, please update documentation.

In git pull document --recurse-submodules option, it tells users to
see git-config(1) and gitmodules(5), but does not tell users to refer
to git fetch --recurse-submodules for the meaning of the switches.
In git fetch document --recurse-submodules option, it does not tell
users to see git-config(1) or gitmodules(5).
