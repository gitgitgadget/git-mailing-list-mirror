From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git push from client is not updating files on server
Date: Tue, 06 Mar 2012 15:21:51 -0600
Message-ID: <4F567FEF.5000105@gmail.com>
References: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com> <4F567DC6.4070903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jerome Yanga <jerome.yanga@gmail.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Mar 06 22:22:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S51pY-0006AL-86
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 22:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160Ab2CFVVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 16:21:55 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61199 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910Ab2CFVVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 16:21:53 -0500
Received: by ghrr11 with SMTP id r11so2557073ghr.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 13:21:53 -0800 (PST)
Received-SPF: pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.80.39 as permitted sender) client-ip=10.236.80.39;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.80.39 as permitted sender) smtp.mail=nkreitzinger@gmail.com; dkim=pass header.i=nkreitzinger@gmail.com
Received: from mr.google.com ([10.236.80.39])
        by 10.236.80.39 with SMTP id j27mr37136721yhe.92.1331068913062 (num_hops = 1);
        Tue, 06 Mar 2012 13:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=GL3/stNYKpo2xgaGu3DVlLabtsZDkgMcfF+2EyoE5jA=;
        b=m/EeU0mEXBbLBl58Wn2K6mdgNWZUIxWvu1tuCL/OYXer+r2Vda0yZ7zu257rzKZogo
         EUrDYfeuCa9+ioQ9iNzcq5M7sUAAvPlYkMqsjeOK+N6f0GWss4HRqqBQiIuuoxIt1CAL
         EYXWLeIo/qexoi6XuobMwS0dHwrixUa7vqNPJ7JkEe03xseoKUgCiBAyzziTuNLbaB06
         ov4vwahw7nKKovHz4nOxElVjM0G2Jb9kFqvlU6v6zJiNAyDNJPVSkIVukFWPj2pIrXrZ
         +2OMy5+nrDX83zh9Hfsiq9okfeS8wQJD3DQsY6hZSZmfP5QvduP9zW9qic0wi+CuRq8F
         cD2w==
Received: by 10.236.80.39 with SMTP id j27mr29435548yhe.92.1331068912984;
        Tue, 06 Mar 2012 13:21:52 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id n72sm52141639yhh.21.2012.03.06.13.21.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 13:21:52 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <4F567DC6.4070903@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192398>

On 3/6/2012 3:12 PM, Neal Kreitzinger wrote:
> On 3/6/2012 10:52 AM, Jerome Yanga wrote:
>>
>> However, when I log into the central public Git server and look at
>> the files in the project, none of them have change. I can only see
>> the changes from the client via Gitweb.
>>
> Gitweb and gitk know how to look at .git (bare) repo and display the
> contents. (I use gitk to verify that a push did what I wanted.) There is
> no work-tree for a .git repo to do linux "ls" on. If you really want to
> use commandline you would have to use git commands like git-show,
> git-ls-files, git-cat-file, git-log, etc., to display and interrogate
> the contents of git objects (tags, commits, trees, blobs) in a .git repo.

scratch git-ls-files from that list.  Its not much use for bare repos, 
either.

v/r,
neal
