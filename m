From: Woody Wu <narkewoody@gmail.com>
Subject: Find the starting point of a local branch
Date: Mon, 24 Dec 2012 11:58:25 +0800
Message-ID: <20121224035825.GA17203@zuhnb712>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 24 05:00:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmzD4-0003Pf-BJ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 05:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab2LXD7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 22:59:55 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:48494 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab2LXD7y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2012 22:59:54 -0500
Received: by mail-pb0-f45.google.com with SMTP id mc8so3727483pbc.4
        for <git@vger.kernel.org>; Sun, 23 Dec 2012 19:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=C0+uysQaU7MUNHMg9kR2Ddc3LjvAk9rbvouOVwICHNw=;
        b=ITX4Dgji8bzu42eMnIuBwE6OsrBlrltz1JOq3mp3OJcoiYFON+SYMpyAVQyi1uEA0f
         c9tqS3aIYYvR5iltfgCoMixdw1BHWwsG5fRJ1wkVw6WHCXwsMHHa2VArpAF9SeQ8q0Ay
         883TjrXytXh+F7nHFYV6nIynSd8ze1wc3aA2JwPVwYHXUdqMVLFUZzJ1Rc98QHgxSgUb
         /BV0HW/YIf3QllLsbDVDykJR/YSjgC76arfzajlK9Yp5NahdX/K/Ff4mdv2ieWy4ftTy
         2x6pLXQn/GTStiNoUiys/ykdIn05d9KP2bNp0qNIfeFQgxzJ84bY6berMrpUzgSlrpUM
         z75Q==
X-Received: by 10.68.203.137 with SMTP id kq9mr62502764pbc.115.1356321594038;
        Sun, 23 Dec 2012 19:59:54 -0800 (PST)
Received: from localhost ([59.37.26.98])
        by mx.google.com with ESMTPS id a4sm12049908paw.21.2012.12.23.19.59.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Dec 2012 19:59:53 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212093>

Hi, list

How can I find out what's the staring reference point (a commit number
or tag name) of a locally created branch? I can use gitk to find out it
but this method is slow, I think there might be a command line to do it
quickly.

Thanks in advance.
-- 
woody
I can't go back to yesterday - because I was a different person then.
