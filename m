From: "Dilip M" <dilipm79@gmail.com>
Subject: Re: gitk doesn't work w/o sudo.
Date: Mon, 19 Jan 2009 20:07:06 +0530
Message-ID: <c94f8e120901190637i294d379dke3a07a90da5076f8@mail.gmail.com>
References: <c94f8e120901190216x246589ebwc4a44dd85bb655d2@mail.gmail.com>
	 <3f4fd2640901190359w39ded50ds246903808e94246c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Reece Dunn" <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 16:33:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOw7D-0005fJ-HM
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 16:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbZASPbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 10:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbZASPbM
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 10:31:12 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:19909 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbZASPbL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 10:31:11 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1255032yxm.1
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 07:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=N8ln2sGgyN/PAz+MsS7L12LWzVWtYOpny5cHsOtNAVA=;
        b=ThQnrXfmR0l5QiaFZbjzVoOfxaMencVLWfKJ9ynkTcIam+sDIhknYJcB0S4CRhfXii
         6vKp+2U5eAa4h9hIhlhdPQFYUyr1fz48e+aL7G7URzhJqogkHankuX3odCufJEzQ9tpg
         1xDLNmiiLfwPWR/4JTtyzuAE9T2T4jZTOu8NU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Dcsow/Fia2c4/qb0Oh3VvjuQUkIgGY+W2sHtPyZMo984/oVtGqzRYbqfYOZ3xT8iMT
         H6KkaX+IebzvPQJ3PZsAnd812L7clPSoee4utIcwqzEOTiiAXCfiawh+KZYOK1xgVgAi
         IVDxc6Yg6jBb6tCb0HPc++xKGCOx/I5t2X5Uk=
Received: by 10.100.140.15 with SMTP id n15mr3934144and.111.1232375826461;
        Mon, 19 Jan 2009 06:37:06 -0800 (PST)
Received: by 10.100.128.10 with HTTP; Mon, 19 Jan 2009 06:37:06 -0800 (PST)
In-Reply-To: <3f4fd2640901190359w39ded50ds246903808e94246c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106364>

On Mon, Jan 19, 2009 at 5:29 PM, Reece Dunn <msclrhd@googlemail.com> wrote:
> 2009/1/19 Dilip M <dilipm79@gmail.com>:
>> Hi,
>>
>> ..I recently install GIT on Ubuntu (hardy) box....I am able to use
>> 'gitk' only If I do 'sudo'. Without 'sudo' it complains 'repository
>> not found'
>
> Who is the owner of the repository directory (and the .git directory)
> and what are the permissions on the directory? You can run (on the
> command line from the Terminal program):
>
>   ls -lh directory
>
> to find this out (where directory is the directory you are interested
> in) and run:
>
>   sudo chown user -R directory
>
> to change ownership of that directory (and all of its content) to the
> specified user (i.e. the one you are currently logged in as). This
> will make it so that you own that directory and can make changes to
> it. This should allow you to run gitk without using sudo.

Even I suspected that it may be related to some permission and checked
them...But I couldn't find the actual cause.

dm-laptop:~/repos/atria> id -a
uid=1000(dm) gid=1000(dm)
groups=4(adm),20(dialout),24(cdrom),25(floppy),29(audio),30(dip),44(video),46(plugdev),107(fuse),109(lpadmin),115(admin),1000(dm)

dm-laptop:~/repos/atria> ls -lh .git/
total 44K
drwxr-xr-x 2 dm dm 4.0K 2009-01-18 23:24 branches
-rw-r--r-- 1 dm dm  256 2009-01-18 23:28 config
-rw-r--r-- 1 dm dm   58 2009-01-18 23:24 description
-rw-r--r-- 1 dm dm   23 2009-01-18 23:28 HEAD
drwxr-xr-x 2 dm dm 4.0K 2009-01-18 23:24 hooks
-rw-r--r-- 1 dm dm 3.8K 2009-01-18 23:28 index
drwxr-xr-x 2 dm dm 4.0K 2009-01-18 23:24 info
drwxr-xr-x 3 dm dm 4.0K 2009-01-18 23:28 logs
drwxr-xr-x 4 dm dm 4.0K 2009-01-18 23:24 objects
-rw-r--r-- 1 dm dm   94 2009-01-18 23:28 packed-refs
drwxr-xr-x 5 dm dm 4.0K 2009-01-18 23:28 refs

'dm' is a user I created while installing Ubuntu.

dm-laptop:~/repos/atria> ls -l `which gitk`
-rwxr-xr-x 1 root root 237778 2008-04-08 22:31 /usr/bin/gitk
dm-laptop:~/repos/atria>


-- DM
