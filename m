From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 03/17] (msvc-build) Vcproj.pm: remove duplicate GUID
Date: Sun, 28 Jun 2015 09:44:18 +0100
Organization: OPDS
Message-ID: <27766BC958B74F8C805221782F93B2DE@PhilipOakley>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org><1435190633-2208-4-git-send-email-philipoakley@iee.org> <CAPig+cTpJ2cz49guBFOHpOsP1UEip=JV-c2fPyjfdSegzZACJQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "GitList" <git@vger.kernel.org>,
	"MsysGitList" <msysgit@googlegroups.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>
X-From: msysgit+bncBDSOTWHYX4PBBC7HX2WAKGQEWCI3YMY@googlegroups.com Sun Jun 28 10:42:52 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBC7HX2WAKGQEWCI3YMY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f55.google.com ([74.125.82.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBC7HX2WAKGQEWCI3YMY@googlegroups.com>)
	id 1Z98At-0000rV-SE
	for gcvm-msysgit@m.gmane.org; Sun, 28 Jun 2015 10:42:51 +0200
Received: by wggx12 with SMTP id x12sf39734687wgg.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Jun 2015 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=oEjsK3rtTgJRGAQYx5EOd/BA4wvbmwjdSK+Ow6JiZ2U=;
        b=y2vOUSoyhtigcZvEgP2pyq3pOl3CRvDMO5EsYTKc5FpdwAxPwIlWlK2Pb1FW7xd5B7
         8KIJVHzvj6GTWfw7poKbTC2NbFtanwQPNS4B3ck6wXz2MzzBSf3cphpUiVbcbgaz4b6a
         gOIQn5hnhHSMl4QBGkqwtOwXlf+lrBhDDwB2pBS1vHzzVOD3Aj4mLP2ApGSAflYYbi6b
         XBrnsfXQMiYnHDeis9rzvcI9Bfg9jf71u0Sk+qkPyFcCrrJJSX8E+M/UckHs7icFGKiv
         XgHkCK4mFEOUVdALqEwYyAetGjzQn0YhSPAOv5QNIvuDlt4d9YUc+sQIQYVKAKCxPLpJ
         gGCw==
X-Received: by 10.180.188.105 with SMTP id fz9mr37125wic.5.1435480971512;
        Sun, 28 Jun 2015 01:42:51 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.98.226 with SMTP id el2ls408295wib.45.gmail; Sun, 28 Jun
 2015 01:42:50 -0700 (PDT)
X-Received: by 10.180.106.10 with SMTP id gq10mr4917155wib.0.1435480970699;
        Sun, 28 Jun 2015 01:42:50 -0700 (PDT)
Received: from out1.ip04ir2.opaltelecom.net (out1.ip04ir2.opaltelecom.net. [62.24.128.240])
        by gmr-mx.google.com with ESMTP id bk2si206860wib.1.2015.06.28.01.42.50
        for <msysgit@googlegroups.com>;
        Sun, 28 Jun 2015 01:42:50 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.240 as permitted sender) client-ip=62.24.128.240;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BEWwAps49VPPUQFlxbgxFUX4ZMbbFRhgmFdgQEAoEkTQEBAQEBAQcBAQEBQAEkG0EBAgKDVwUBAQEBAwgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBBoGBwMGDgYTCAIBAgMBiCK4UIZUj1OBIYophCFlgm8vgRQFlAQBgQODVYh4lj+BCXI3HIFTPTGBA4FFAQEB
X-IPAS-Result: A2BEWwAps49VPPUQFlxbgxFUX4ZMbbFRhgmFdgQEAoEkTQEBAQEBAQcBAQEBQAEkG0EBAgKDVwUBAQEBAwgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBBoGBwMGDgYTCAIBAgMBiCK4UIZUj1OBIYophCFlgm8vgRQFlAQBgQODVYh4lj+BCXI3HIFTPTGBA4FFAQEB
X-IronPort-AV: E=Sophos;i="5.13,692,1427756400"; 
   d="scan'208";a="536001975"
Received: from host-92-22-16-245.as13285.net (HELO PhilipOakley) ([92.22.16.245])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 28 Jun 2015 09:42:26 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.240 as permitted sender) smtp.mail=philipoakley@iee.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272873>

From: "Eric Sunshine" <sunshine@sunshineco.com>
> On Wed, Jun 24, 2015 at 8:03 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> Delete the duplicated GUID from the generation code for the Visual 
>> Studio
>> .sln project file.
>>
>> The duplicate GUID tended to be allocated to test-svn-fe, which was 
>> then
>> ignored by Visual Studio / MSVC, and it's omission from the build 
>> never
>
> s/it's/its/

Thanks, will fix.
>
>> noticed.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  contrib/buildsystems/Generators/Vcproj.pm | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/contrib/buildsystems/Generators/Vcproj.pm 
>> b/contrib/buildsystems/Generators/Vcproj.pm
>> index cfa74ad..1b01d58 100644
>> --- a/contrib/buildsystems/Generators/Vcproj.pm
>> +++ b/contrib/buildsystems/Generators/Vcproj.pm
>> @@ -52,7 +52,6 @@ my @GUIDS = (
>>      "{00785268-A9CC-4E40-AC29-BAC0019159CE}",
>>      "{4C06F56A-DCDB-46A6-B67C-02339935CF12}",
>>      "{3A62D3FD-519E-4EC9-8171-D2C1BFEA022F}",
>> -    "{3A62D3FD-519E-4EC9-8171-D2C1BFEA022F}",
>>      "{9392EB58-D7BA-410B-B1F0-B2FAA6BC89A7}",
>>      "{2ACAB2D5-E0CE-4027-BCA0-D78B2D7A6C66}",
>>      "{86E216C3-43CE-481A-BCB2-BE5E62850635}",
>> --
>> 2.3.1
> 

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
