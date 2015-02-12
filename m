From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 0/3] Win32: nanosecond-precision file times
Date: Thu, 12 Feb 2015 23:57:30 +0100
Message-ID: <54DD2FDA.7030604@gmail.com>
References: <54DBEAA5.6000205@gmail.com> <xmqqbnkysygl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBBWW76STAKGQEUIC3CGI@googlegroups.com Thu Feb 12 23:57:31 2015
Return-path: <msysgit+bncBCH3XYXLXQDBBWW76STAKGQEUIC3CGI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f59.google.com ([74.125.83.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBWW76STAKGQEUIC3CGI@googlegroups.com>)
	id 1YM2hP-0003rd-9k
	for gcvm-msysgit@m.gmane.org; Thu, 12 Feb 2015 23:57:31 +0100
Received: by mail-ee0-f59.google.com with SMTP id d17sf3397603eek.4
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Feb 2015 14:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=DEXroQr3TFebYmoR9HmT8wORo582TUyrzz4dk8jAOB0=;
        b=SL6CtEa1RnpMeY5avGH2HAQ0prGrw4AWiTpEHeXmTY8nqfYZrv15d8Sj7/b1VgS4DV
         jU1vCyv2bMdXzjj0YEH1NVaUKCdsncRPkUTnoJCxrMuTmAzOTQI69zMojLQyDTr8a60I
         TIdBylFImP0JScvbjMghtwRiotm05/fG/vzPUcLmEkypqWZ7i6+vOsmVZq+YQNvKNETm
         i8sKhcVNQxV5gKbfGki/3z77JrFZVw5Lgid7Oux1hgsikMFMznaheiXxep5LAjwsxV68
         5cJay0bUHHKeW6u14KP+944EPajSvWbkvUNQZ1qdRvk/VxdqUj0uW2xdPjVb11yv0UGl
         Icvw==
X-Received: by 10.180.186.67 with SMTP id fi3mr59736wic.15.1423781850903;
        Thu, 12 Feb 2015 14:57:30 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.91.116 with SMTP id cd20ls230658wib.30.canary; Thu, 12 Feb
 2015 14:57:30 -0800 (PST)
X-Received: by 10.194.142.174 with SMTP id rx14mr937378wjb.4.1423781850035;
        Thu, 12 Feb 2015 14:57:30 -0800 (PST)
Received: from mail-wg0-x234.google.com (mail-wg0-x234.google.com. [2a00:1450:400c:c00::234])
        by gmr-mx.google.com with ESMTPS id ew5si2944037wid.1.2015.02.12.14.57.30
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 14:57:30 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::234 as permitted sender) client-ip=2a00:1450:400c:c00::234;
Received: by mail-wg0-f52.google.com with SMTP id x12so3394590wgg.11
        for <msysgit@googlegroups.com>; Thu, 12 Feb 2015 14:57:30 -0800 (PST)
X-Received: by 10.180.79.65 with SMTP id h1mr10598767wix.59.1423781849923;
        Thu, 12 Feb 2015 14:57:29 -0800 (PST)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id hd5sm4373469wib.21.2015.02.12.14.57.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 14:57:29 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqbnkysygl.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::234
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263781>

Am 12.02.2015 um 20:48 schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> However, some users have expressed concerns that 'same size and
>> mtime' [2] may theoretically happen by chance in daily operation.
> 
> Hmph.
> 
> Haven't we already accepted that it is not just "may theoretically
> happen" and had counter-measures in racy-git detection machinery
> for quite some time?
> 

Racy-git only triggers for files that are modified at the same time
as .git/index (i.e. we don't know if the stat cache is up to date).

This is more about copying 'old' things around, which usually also
copies mtime on Windows. E.g.:

  # create two files with slightly different mtime
  for i in {1..10}; do (echo "v1" >> test); done &&
  for i in {1..10}; do (echo "v2" >> test2); done
  # wait a bit so that '.git/index' is always newer than 'test' / 'test2'
  sleep 1
  git add test
  git commit -m v1
  # copy test2 over test (similar to 'cp -p', but native 'copy' also
  # copies mtime nanoseconds)
  cmd //c "copy /y test2 test"
  git add test
  git commit -m v2

Without these patches, git does not detect the change, and the second
git add / git commit are noops.

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
