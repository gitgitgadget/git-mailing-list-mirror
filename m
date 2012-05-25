From: "J.V." <jvsrvcs@gmail.com>
Subject: behaviour of .gitignore
Date: Fri, 25 May 2012 10:32:45 -0600
Message-ID: <4FBFB42D.3090303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 18:33:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXxRe-0007r9-4Y
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 18:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933442Ab2EYQct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 12:32:49 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64770 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110Ab2EYQcs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 12:32:48 -0400
Received: by pbbrp8 with SMTP id rp8so1966218pbb.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=RNXaX4DMeFYVJ/r1P4PUW/9KPNTtPNFaFtzdCS5cLd8=;
        b=QkjArR/R2y9Zupfzexs83//nuKft42cdX6OpqzMffwHyXGm9xJ4BZv9ZhnNWA59AxZ
         yFO+LzoN+FjEmj9uxchFYoXNcnbhoc0CntZoxOTjBKWwv9K7PoBCku1IXV3OImqa3wf1
         jhqRP87f9hDwFd8oG+7jJ+nQ4o7Kp1o4JxWDD1jEkxxMOAg0Nh/ETkkP9dovq3AdbcOd
         DkZJAzSX/vroDNhEy7ugPS9i7FeFpdnH9F3x8TyFBjxSH5oKiEi6uHQ5NdEdw8fsnOcz
         yrr+56lhI0hFxbiOi2xjkVu3v6DL6ZxeFDaeHgfhpvDpEqJKOnBJBqNd/V7x3EZpMN2z
         wsZg==
Received: by 10.68.225.135 with SMTP id rk7mr33841931pbc.38.1337963568308;
        Fri, 25 May 2012 09:32:48 -0700 (PDT)
Received: from [10.21.1.60] ([64.55.39.36])
        by mx.google.com with ESMTPS id ka5sm9525160pbb.37.2012.05.25.09.32.47
        (version=SSLv3 cipher=OTHER);
        Fri, 25 May 2012 09:32:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198481>

On my local machine, I create a /bin/ directory added some bash scripts, 
comitted and then pushed them to the repository.

Now today I do a git pull and they are gone but cannot see that anyone 
deleted them in the git log / history, but there is a /bin/ entry in the 
.gitignore file.

Does this mean, the files are still in the shared repository (orgin) 
that I could get them back?

I tried removing /bin/ from the git ignore and doing a pull but my /bin/ 
directory is still not there.

Is there anyway to do a pull now and have it look at my local gitignore 
and pull the directory back?

thanks


J.V.
