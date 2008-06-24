From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: git status bug problem.
Date: Tue, 24 Jun 2008 03:49:15 +0200
Message-ID: <237967ef0806231849k2aa0c1ebt9f4dee45e2b40896@mail.gmail.com>
References: <970bc7c80806230619i6c060c4eld329729ec7eef1da@mail.gmail.com>
	 <970bc7c80806230622x326c5cd3mbce57949255a067b@mail.gmail.com>
	 <m3r6aol0u8.fsf@localhost.localdomain>
	 <970bc7c80806231837j19458b80x81063745a2ef40c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ben Bennett" <benbennett@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 03:50:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAxfk-0001HM-0T
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 03:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbYFXBtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 21:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbYFXBtU
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 21:49:20 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:34165 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbYFXBtT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 21:49:19 -0400
Received: by yw-out-2324.google.com with SMTP id 9so986746ywe.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 18:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gL9/P9BMY4K9vMKxvVAlXD/S2hJIqEOj/de8KWbQxdQ=;
        b=a2JEQ27XDVSBu1JBWKNflczk2A++rPLs/OIaCTyNAw++On/YvEno+WDYVzuwZWnM6k
         +j7bYj/qWi6KIHe8szek3ycHtJsGak56wGM0Z+//PG6jCVX5ZOAMrAmwAxFO2V1wN09u
         bal33WRx7+Uclw6mcYrg7fFmdCgBBmpIW+BiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ckvNBwPQHafuQ4XykeSpm4azoyv5rn94FjPsWehp5YsMDUa6L8Rfv4S//XNWvBm76c
         4vj5ShF05V8CFFXLrmMHLu/RCAGk3oPipS9+dex75EnjJ4nWOQgasrQaGs0/Ihn/6Ww8
         1KoPizwoedpxN93IBGAH3W21KI2PPOGCC2bd0=
Received: by 10.141.68.12 with SMTP id v12mr13797314rvk.111.1214272155747;
        Mon, 23 Jun 2008 18:49:15 -0700 (PDT)
Received: by 10.141.153.6 with HTTP; Mon, 23 Jun 2008 18:49:15 -0700 (PDT)
In-Reply-To: <970bc7c80806231837j19458b80x81063745a2ef40c4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85964>

2008/6/24 Ben Bennett <benbennett@gmail.com>:
> I made the initial commit.  git-gui doesn't return anything either.
> Something tells me it isn't getting the cwd. Add git status *  it will
> work correctly , but git-gui doesn't give anything.
>
> somewhere@something:~/git_test$ git status
> # On branch master
> nothing to commit (working directory clean)
>
> somewhere@something:~/git_test$ git status *
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       modified:   test/test2.txt
> #
> Thanks,
> Ben

The file isn't by chance matched by a git ignore rule somewhere? An easy
way to check is to try and git add the file, it will say you have to use
-f if it does.

-- 
Mikael Magnusson
