From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Git for Windows 1.9.5.msysgit.1
Date: Fri, 20 Mar 2015 00:03:43 +0100
Message-ID: <550B55CF.4090701@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCL7JHHTPAINHK5NVACRUBHR7G5WY@googlegroups.com Fri Mar 20 00:03:48 2015
Return-path: <msysgit+bncBCL7JHHTPAINHK5NVACRUBHR7G5WY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f59.google.com ([74.125.82.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAINHK5NVACRUBHR7G5WY@googlegroups.com>)
	id 1YYjTg-0001Q2-72
	for gcvm-msysgit@m.gmane.org; Fri, 20 Mar 2015 00:03:48 +0100
Received: by wggz12 with SMTP id z12sf27916027wgg.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 19 Mar 2015 16:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=SC5+VtddDJz6IOHIMkNBqBXLOJXy27tuyIAaRP9awf0=;
        b=zAyXkjd7gr9e27Nv11x1ZvFlQTzx7fKTrY4mkYNPO6vCkt0+k9Mxt4/6M9UQQKqd/8
         tDmssBKzmX0JO+fqs0Yr6FOYIYJt+gIFHfzpUb4SNSJHPXQ8/OAoQnta2D5fpapHwcFi
         aZmXR3vvgtEp0anhyFx/DNMFL3Um5GOrMBHHINBU01ssF3isfkJ3+bRuddrXPE/THpw0
         eZuaf9C8EfouPZO71JigdC7+crxG0T5vijsn3fj4rEJ1Q7stHFWk2whN5yqI3QmOnS8b
         CC7YxjRXWSv3HTWFp9RmWkksBoI1FmN9JxkCgFsKH0sh1jk/Kng4bfte9WlAnTUi7ePo
         wtqw==
X-Received: by 10.180.76.167 with SMTP id l7mr140060wiw.8.1426806227583;
        Thu, 19 Mar 2015 16:03:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.23.100 with SMTP id l4ls225715wif.7.gmail; Thu, 19 Mar
 2015 16:03:46 -0700 (PDT)
X-Received: by 10.180.80.35 with SMTP id o3mr971512wix.0.1426806226841;
        Thu, 19 Mar 2015 16:03:46 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [80.237.132.163])
        by gmr-mx.google.com with ESMTPS id el6si24428wib.0.2015.03.19.16.03.46
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Mar 2015 16:03:46 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=80.237.132.163;
Received: from p5ddc2b9d.dip0.t-ipconnect.de ([93.220.43.157] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1YYjTe-0005hC-A3; Fri, 20 Mar 2015 00:03:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1426806226;09ffb9fa;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted
 sender hosts) smtp.mail=thomas.braun@virtuell-zuhause.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265850>

Hi,

the Git for Windows team just released the first maintenance release of
the Windows-specific installers for git 1.9.5.

It can be downloaded from the usual place [1] and I also attached some
(although non-gpg-signed) SHA sums [2].

New Features
- Comes with Git 1.9.5 plus Windows-specific patches.
- Make vimdiff usable with git mergetool.

Security Updates
- Mingw-openssl to 0.9.8zf and msys-openssl to 1.0.1m
- Bash to 3.1.23(6)
- Curl to 7.41.0

Bugfixes
- ssh-agent: only ask for password if not already loaded
- Reenable perl debugging ("perl -de 1" possible again)
- Set icon background color for Windows 8 tiles
- poll: honor the timeout on Win32
- For git.exe alone, use the same HOME directory fallback mechanism as
/etc/profile

Have phun,
Thomas

[1]:
https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-preview20150319/Git-1.9.5-preview20150319.exe
[2]:
SHA1(Git-1.9.5-preview20150319.exe)=
a8658bae0de8c8d3e40aa97a236a4fcf81de50df
SHA1(PortableGit-1.9.5-preview20150319.7z)=
44e7f249797af9a3833b88e17575bcbf22c282df
SHA1(msysGit-netinstall-1.9.5-preview20150319.exe)=
60b73db7959fb841b7d29286608e2333f429ca85

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
