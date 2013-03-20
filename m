From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: FW: Windows. Git, and Dedupe
Date: Wed, 20 Mar 2013 22:45:20 +0100
Message-ID: <514A2DF0.2080708@lsrfire.ath.cx>
References: <02803146dc74414191fab53b0de33fa1@BLUPR03MB019.namprd03.prod.outlook.com> <5148D3BD.4040608@lsrfire.ath.cx> <614e174a0b4548a1bcdc6c24c2682829@BLUPR03MB019.namprd03.prod.outlook.com> <514A140C.1040901@lsrfire.ath.cx> <2156b5b7b012490490c1b52637a6164a@BLUPR03MB019.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, 
 "msysgit@googlegroups.com" <msysgit@googlegroups.com>
To: Josh Rowe <Joshua.Rowe@microsoft.com>
X-From: msysgit+bncBCJMNOMZRUPBB5O3VCFAKGQEMJW374Y@googlegroups.com Wed Mar 20 22:45:49 2013
Return-path: <msysgit+bncBCJMNOMZRUPBB5O3VCFAKGQEMJW374Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f187.google.com ([209.85.212.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJMNOMZRUPBB5O3VCFAKGQEMJW374Y@googlegroups.com>)
	id 1UIQpR-0007kl-6b
	for gcvm-msysgit@m.gmane.org; Wed, 20 Mar 2013 22:45:49 +0100
Received: by mail-wi0-f187.google.com with SMTP id hm14sf842702wib.24
        for <gcvm-msysgit@m.gmane.org>; Wed, 20 Mar 2013 14:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=0UfWT/hkKx0I+07z2otstwCXcVq7Q3FImAH0TS83a2s=;
        b=qavD9gta/StuzWYtEsy8G0usx7Q9RMp1OzT/v43/iWe7/m/wNq4wwi7oT+ODCh++LQ
         1bwXYGEsl2cB4gyQNAGIyDW1crvwUJB0NLX+oyGv8CV/AQjfFJeMq01YDr3fyAlBz3MV
         VgM1RKZGpjNEDIdyQRsgkgMnLKehuolLu4T/8VLUecvTjpFatwEZ1RLtjlWQ7+9ttpSa
         tZwMFrdsabZS1aownzcj1/asQKTY2NrL+ngihfKswolDMZtEwxv6ve7MTB81uD9C6Lom
         cuswldtGoxsykSzqvPig+rMa6D 
X-Received: by 10.180.19.66 with SMTP id c2mr116298wie.4.1363815925839;
        Wed, 20 Mar 2013 14:45:25 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.84.161 with SMTP id a1ls734287wiz.4.gmail; Wed, 20 Mar
 2013 14:45:24 -0700 (PDT)
X-Received: by 10.15.21.137 with SMTP id d9mr35695097eeu.1.1363815924978;
        Wed, 20 Mar 2013 14:45:24 -0700 (PDT)
Received: from india601.server4you.de (india601.server4you.de. [85.25.151.105])
        by gmr-mx.google.com with ESMTP id 6si1159557eej.0.2013.03.20.14.45.23;
        Wed, 20 Mar 2013 14:45:23 -0700 (PDT)
Received-SPF: neutral (google.com: 85.25.151.105 is neither permitted nor denied by best guess record for domain of rene.scharfe@lsrfire.ath.cx) client-ip=85.25.151.105;
Received: from [192.168.2.105] (p4FFDB75E.dip.t-dialin.net [79.253.183.94])
	by india601.server4you.de (Postfix) with ESMTPSA id 13C131DD;
	Wed, 20 Mar 2013 22:45:23 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <2156b5b7b012490490c1b52637a6164a@BLUPR03MB019.namprd03.prod.outlook.com>
X-Original-Sender: rene.scharfe@lsrfire.ath.cx
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 85.25.151.105 is neither permitted nor denied by best guess
 record for domain of rene.scharfe@lsrfire.ath.cx) smtp.mail=rene.scharfe@lsrfire.ath.cx
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218684>

Am 20.03.2013 21:43, schrieb Josh Rowe:
> If you have Win8 or HyperV 2012, I can ship you a small NTFS .vhd
> with some deduped files.  I'm not sure if that will be readable, but
> I would hazard a guess that it would be.  It definitely will not be
> readable on Win7.

It would be nice if you could upload it to an FTP server or website and=20
post a public link so that the real git-on-Windows developers can get it=20
as well.  You can also send it to me personally and I'll see if I can=20
mount it using Windows 8 and where I get from there.  In any case,=20
please make sure there's no sensitive or private data in the VHD file.

How big is it after compression using (preferably) 7-Zip or ZIP?

> I'm using:
>
> PS C:\> git version git version 1.8.0.msysgit.0

That means compat/mingw.c is directly relevant to you; more about MinGW,=20
MSys and git at http://msysgit.github.com/ and http://mingw.org/.

> The file sizes show up as their original size with Windows tools
> (powershell, Win32, cmd, .Net, etc).  git ls-tree -r HEAD does not
> show that hash code for files that are not intentionally empty.

So we can likely (hopefully) get the sizes of deduped files with the=20
same API calls as for regular ones.  Which makes me even more puzzled=20
over the question of why git makes a difference between the two kinds.

Ren=E9

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
