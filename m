From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: FW: Windows. Git, and Dedupe
Date: Wed, 20 Mar 2013 20:54:52 +0100
Message-ID: <514A140C.1040901@lsrfire.ath.cx>
References: <02803146dc74414191fab53b0de33fa1@BLUPR03MB019.namprd03.prod.outlook.com> <5148D3BD.4040608@lsrfire.ath.cx> <614e174a0b4548a1bcdc6c24c2682829@BLUPR03MB019.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, 
 "msysgit@googlegroups.com" <msysgit@googlegroups.com>
To: Josh Rowe <Joshua.Rowe@microsoft.com>
X-From: msysgit+bncBCJMNOMZRUPBBFFIVCFAKGQEWJZSHRI@googlegroups.com Wed Mar 20 20:55:27 2013
Return-path: <msysgit+bncBCJMNOMZRUPBBFFIVCFAKGQEWJZSHRI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJMNOMZRUPBBFFIVCFAKGQEWJZSHRI@googlegroups.com>)
	id 1UIP6a-0005Wh-Ed
	for gcvm-msysgit@m.gmane.org; Wed, 20 Mar 2013 20:55:24 +0100
Received: by mail-wi0-f191.google.com with SMTP id hn17sf755800wib.8
        for <gcvm-msysgit@m.gmane.org>; Wed, 20 Mar 2013 12:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=Q5Rgneic0LKxIhjuuuXM7ryCP5XnUgepNjbQ0TqdCaY=;
        b=SNHWma2JBSf6oASiteDfoIqbdQ0MQom8OrE6k6jNQkFMxXcBCi/1+9N+eE/WKN/6lk
         zK2dF7u1W8Ub8WelcGpkY2/aVFzo25HQMbOYOSAEgZJc8fk4mlythe/TFMTD+YyCUJYv
         uDn+mmQi8Ncozp1DU8A4rDvSp0Z5CH+yXpnmWuU28w5oFzwohUfbyluLSwayJ3XmvrnR
         NDi9tuRm73zK6IFUYyLV1shLi6FevX7seiq23C9tJ/jXcxQ/Y/FXPFHFcqVcc2+Ya/Ox
         cUGL6Gwc/oNiBZYAOuBi9iq4U9 
X-Received: by 10.180.75.14 with SMTP id y14mr61110wiv.20.1363809301314;
        Wed, 20 Mar 2013 12:55:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.93.201 with SMTP id cw9ls652971wib.14.gmail; Wed, 20 Mar
 2013 12:55:00 -0700 (PDT)
X-Received: by 10.14.220.131 with SMTP id o3mr35254568eep.3.1363809300135;
        Wed, 20 Mar 2013 12:55:00 -0700 (PDT)
Received: from india601.server4you.de (india601.server4you.de. [85.25.151.105])
        by gmr-mx.google.com with ESMTP id 47si1101002eeh.1.2013.03.20.12.55.00;
        Wed, 20 Mar 2013 12:55:00 -0700 (PDT)
Received-SPF: neutral (google.com: 85.25.151.105 is neither permitted nor denied by best guess record for domain of rene.scharfe@lsrfire.ath.cx) client-ip=85.25.151.105;
Received: from [192.168.2.105] (p4FFDB75E.dip.t-dialin.net [79.253.183.94])
	by india601.server4you.de (Postfix) with ESMTPSA id 973801E6;
	Wed, 20 Mar 2013 20:54:59 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <614e174a0b4548a1bcdc6c24c2682829@BLUPR03MB019.namprd03.prod.outlook.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218670>

Am 19.03.2013 22:36, schrieb Josh Rowe:
> Yes, Dedup is in fact a Server-only feature.

Is there an easier way to reproduce the issue than registering and=20
downloading the Windows Server 2012 evaluation version?  It's not that=20
hard, admittedly, but still.

> The reparse point could be decoded as being a non-symlink reparse
> itemusing; in those cases, treating the file as an "ordinary"
> file would be appropriate.
>
> For example, see the following. The reparse tag value for symlinks
> isIO_REPARSE_TAG_SYMLINK (0xa000000c) and for deduped files is
 > (IO_REPARSE_TAG_DEDUP) 0x80000013.

That's interesting and invalidates my initial checks with mklink,=20
because if I read compat/mingw.c [1] correctly then git handles symlinks=20
on Windows in a special way, but should treat dedup reparse points as=20
normal files already.

Hrm, but probably st_size is set to zero for them.  Do the deduped files=20
appear as empty?  "git ls-tree -r HEAD" would show them with a hash of=20
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391.  If true then how do we get=20
their real content sizes using Win32 API calls?

By the way, what does the command "git version" return for you?

Thanks,
Ren=E9


[1] https://git.kernel.org/cgit/git/git.git/tree/compat/mingw.c#n427

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
