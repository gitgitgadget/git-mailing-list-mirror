From: "Dilip M" <dilipm79@gmail.com>
Subject: Re: gitk doesn't work w/o sudo.
Date: Tue, 20 Jan 2009 22:21:09 +0530
Message-ID: <c94f8e120901200851n21c6d67r3c43e3efd435e3db@mail.gmail.com>
References: <c94f8e120901190216x246589ebwc4a44dd85bb655d2@mail.gmail.com>
	 <3f4fd2640901190359w39ded50ds246903808e94246c@mail.gmail.com>
	 <c94f8e120901190637i294d379dke3a07a90da5076f8@mail.gmail.com>
	 <200901200912.14432.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Reece Dunn" <msclrhd@googlemail.com>,
	"git list" <git@vger.kernel.org>
To: "Brian Foster" <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 17:52:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPJq7-0007j6-Gl
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 17:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761488AbZATQvO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 11:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761467AbZATQvM
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 11:51:12 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:48120 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758053AbZATQvK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2009 11:51:10 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1537295yxm.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 08:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KbGBkZpishk0wa97UmG5vPcj8vKKRxC+PXs4USpKKvI=;
        b=vJPYDLBaURDlptSmREvxOPHGmeAnadptEaNdHWPcFdjGwK9ezYlo7o0leNi9uDGOQT
         ydQz9yD8G80kjE6NDJoEjCA2oa4foE3pYuiQPcYGghx8X4jaGoa5SHgpB4l5Fc5R8VOs
         p6MoYzd5VWUN0Yy10AYnPvPCGl0cZqj1Jq/zs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iMD79IUlNXQ5O5yZ3m8Nipjah5Qih12KFPl5TBnfFH9h34giY2AF8bVaoS3aFCvOu9
         byKu/qlWu3UxLwj1m/bdP76V5Xyk6v8HLUXZrLlLOLN3zn0WUNJvSQgPMNGPiAFN8RYk
         hVqNgdKbuR1CdgPEF0wXlSHBN8Als8IrZx9RU=
Received: by 10.100.136.15 with SMTP id j15mr2248482and.11.1232470269362;
        Tue, 20 Jan 2009 08:51:09 -0800 (PST)
Received: by 10.100.128.10 with HTTP; Tue, 20 Jan 2009 08:51:09 -0800 (PST)
In-Reply-To: <200901200912.14432.brian.foster@innova-card.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106491>

On Tue, Jan 20, 2009 at 1:42 PM, Brian Foster
<brian.foster@innova-card.com> wrote:
> On Monday 19 January 2009 15:37:06 Dilip M wrote:
>> On Mon, Jan 19, 2009 at 5:29 PM, Reece Dunn <msclrhd@googlemail.com>=
 wrote:
>> > 2009/1/19 Dilip M <dilipm79@gmail.com>:
>> >> ..I recently install GIT on Ubuntu (hardy) box....I am able to us=
e
>> >> 'gitk' only If I do 'sudo'. Without 'sudo' it complains 'reposito=
ry
>> >> not found'
>> >
>> > Who is the owner of the repository directory (and the .git directo=
ry)
>> > and what are the permissions on the directory?  [ ... ]
>>
>> dm-laptop:~/repos/atria> id -a
>> uid=3D1000(dm) gid=3D1000(dm)  [ ... ]
>> dm-laptop:~/repos/atria> ls -lh .git/
>>[... all looks Ok ...]
>
>  repeating Reece's question, what is the permissions/owner
>  _of_the_directory_which_contains_ the '.git/' directory?
>  I can reproduce this behaviour (git 1.6.0.4) simply by
>  denying myself search (n=E9e execute) permission on that
>  directory, for entirely obvious reasons.

It's the same issue....Any ENV variable I can set to debug this...?

dm-laptop:~/repos/atria> id -a
uid=3D1000(dm) gid=3D1000(dm)
groups=3D4(adm),20(dialout),24(cdrom),25(floppy),29(audio),30(dip),44(v=
ideo),46(plugdev),107(fuse),109(lpadmin),115(admin),1000(dm)

dm-laptop:~/repos/atria> ls -ld .git
drwxr-xr-x 8 dm dm 4096 2009-01-19 22:34 .git

dm-laptop:~/repos/atria> ls -la .git
total 68
drwxr-xr-x 8 dm dm 4096 2009-01-19 22:34 .
drwxr-xr-x 6 dm dm 4096 2009-01-18 23:28 ..
drwxr-xr-x 2 dm dm 4096 2009-01-18 23:24 branches
-rw-r--r-- 1 dm dm   20 2009-01-19 22:28 COMMIT_EDITMSG
-rw-r--r-- 1 dm dm  256 2009-01-18 23:28 config
-rw-r--r-- 1 dm dm   58 2009-01-18 23:24 description
-rw-r--r-- 1 dm dm   89 2009-01-19 20:15 FETCH_HEAD
-rw-r--r-- 1 dm dm   23 2009-01-19 21:49 HEAD
drwxr-xr-x 2 dm dm 4096 2009-01-18 23:24 hooks
-rw-r--r-- 1 dm dm 5280 2009-01-19 22:28 index
drwxr-xr-x 2 dm dm 4096 2009-01-19 22:34 info
drwxr-xr-x 3 dm dm 4096 2009-01-19 22:34 logs
drwxr-xr-x 4 dm dm 4096 2009-01-19 22:34 objects
-rw-r--r-- 1 dm dm   41 2009-01-19 20:15 ORIG_HEAD
-rw-r--r-- 1 dm dm  153 2009-01-19 22:34 packed-refs
drwxr-xr-x 5 dm dm 4096 2009-01-18 23:28 refs

dm-laptop:~/repos/atria> umask
22


-- DM
