From: Wataru Noguchi <wnoguchi.0727@gmail.com>
Subject: Re: Re: [PATCH] git-compat-util.h: reduce optimization
 level to 1 on MinGW env.
Date: Thu, 26 Sep 2013 09:47:54 +0900
Message-ID: <CAFRcQ0Fzikruv9tM5--hK9ELHZHDHQCcYyXxH7S9Xwv2p7_REg@mail.gmail.com>
References: <1380123941-25941-1-git-send-email-wnoguchi.0727@gmail.com>
	<20130925191527.GY9464@google.com>
	<alpine.DEB.1.00.1309252142220.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBDD7TRGTWYIBBO4IR2JAKGQELVAEQ6Q@googlegroups.com Thu Sep 26 02:47:56 2013
Return-path: <msysgit+bncBDD7TRGTWYIBBO4IR2JAKGQELVAEQ6Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f59.google.com ([209.85.215.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDD7TRGTWYIBBO4IR2JAKGQELVAEQ6Q@googlegroups.com>)
	id 1VOzkK-00007S-Co
	for gcvm-msysgit@m.gmane.org; Thu, 26 Sep 2013 02:47:56 +0200
Received: by mail-la0-f59.google.com with SMTP id ec20sf40112lab.24
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Sep 2013 17:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=viwAWcftwHipMhz+W2R5pNxFSMoMcH4gWRUIkSuHMbk=;
        b=RvBpvzrppmwn+7iiPRXKhGvJhIwQhtWJuJyKxObekk54brsQyGGWzavrbU8gW0V6do
         MyvugYVegsagl+lFYjIS5qke+rgDA1t2pUJ8T/7vdXAhgcFfHKk41+j9XxLwDNlQXedz
         ff04cvmp4v8ibTpEGZHhI55cRRFuQOKwfVemr4NuLYIQXLGUkWXIWMBHZxSwh3RKDqPf
         5q/P91KOxyOuPNuXPMeYpGdvdxux9YwNVNQLnLwNbP2cHRl/DJzritS+7HYMprIqViDP
         +eZXd/l9WGONwepH+OuWKjUBNFPAKoiJyLZSUCfI8o45DP7rbLwqTHHLWT2yAKh3Ll5/
         7lyQ==
X-Received: by 10.180.39.41 with SMTP id m9mr1036554wik.19.1380156476089;
        Wed, 25 Sep 2013 17:47:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.206.66 with SMTP id lm2ls461383wic.24.gmail; Wed, 25 Sep
 2013 17:47:54 -0700 (PDT)
X-Received: by 10.180.216.106 with SMTP id op10mr7330645wic.4.1380156474659;
        Wed, 25 Sep 2013 17:47:54 -0700 (PDT)
Received: from mail-wg0-x236.google.com (mail-wg0-x236.google.com [2a00:1450:400c:c00::236])
        by gmr-mx.google.com with ESMTPS id gt5si36451wib.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 17:47:54 -0700 (PDT)
Received-SPF: pass (google.com: domain of wnoguchi.0727@gmail.com designates 2a00:1450:400c:c00::236 as permitted sender) client-ip=2a00:1450:400c:c00::236;
Received: by mail-wg0-f54.google.com with SMTP id m15so424904wgh.33
        for <msysgit@googlegroups.com>; Wed, 25 Sep 2013 17:47:54 -0700 (PDT)
X-Received: by 10.180.183.51 with SMTP id ej19mr25301603wic.60.1380156474558;
 Wed, 25 Sep 2013 17:47:54 -0700 (PDT)
Received: by 10.216.68.72 with HTTP; Wed, 25 Sep 2013 17:47:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1309252142220.1191@s15462909.onlinehome-server.info>
X-Original-Sender: wnoguchi.0727@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of wnoguchi.0727@gmail.com designates 2a00:1450:400c:c00::236
 as permitted sender) smtp.mail=wnoguchi.0727@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235385>

Hi,

I'm sorry resend email many times...
My GMail setting default to HTML format.
So mail sent to Git ML is rejected...

----------------------------
Thanks for your reply.

> If changing the optimization level turns out to be the right fix, I
> would prefer to see this change made in the Makefile instead of
> git-compat-util.h.

Yes, I see.
I think so.
I shuld write optimization level change code to Makefile instead of
git-compat-util.h.



2013/9/26 Jonathan Nieder <jrnieder@gmail.com>:
> (cc-ing the Git for Windows maintainers)
> Hi,
>
> Wataru Noguchi wrote:
>
>> Git for Windows crashes when clone Japanese multibyte repository.
>> - Japanese Base Encoding is Shift-JIS.
>> - It happens Japanese multibyte directory name and too-long directory pa=
th
>> - Linux(ex. Ubuntu 13.04 amd64) can clone normally.
>> - example repository is here:
>>
>> git clone https://github.com/wnoguchi/mingw-checkout-crash.git
>>
>> - The reproduce crash repository contains following file only.
>>   - following directory and file name is encoded for this commit log.
>>   - actually file name is decoded.]
>>   %E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%=
88%E3%83%AA%201-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87=
%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%202-long-long-long-dirname/%E=
6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%8=
3%AA%203-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%=
A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%204-long-long-long-dirname/%E6%97%A5=
%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%20=
5-long-long-long-dirname/%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB%E3%81%8A%E8%A=
A%AD%E3%81%BF%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84.txt
>> - only one commit.
>>
>> This commit reduce gcc optimization level from O2 to O1 when MinGW Windo=
ws environment.
>>
>> Signed-off-by: Wataru Noguchi <wnoguchi.0727@gmail.com>
>
> Thanks.
>
>> ---
>>  git-compat-util.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index a31127f..394c23b 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -90,6 +90,8 @@
>>  #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
>>  #include <winsock2.h>
>>  #include <windows.h>
>> +/* reduce gcc optimization level to 1 */
>> +#pragma GCC optimize ("O1")
>>  #define GIT_WINDOWS_NATIVE
>>  #endif
>
> Do you know why reducing the optimization level avoids a crash?
> Perhaps this is just masking the symptoms and the problem is still
> lurking.
>
> If changing the optimization level turns out to be the right fix, I
> would prefer to see this change made in the Makefile instead of
> git-compat-util.h.  That way, the user building can still easily
> override the optimization settings to -O0 if they want to during a
> debugging session.
>
> What do you think?
>
> Hope that helps,
> Jonathan




Hi,

Thanks for your advise.

> To find out what the real cause is, I suggest using a tool similar to
> valgrind. Valgrind does not run on Windows, but I DuckDuckWent e.g.
> http://code.google.com/p/drmemory/ as an alternative that could be tried
> to identify the problem.

I will try debugging by using any tools more real cause.
* Valgrind and drmemory, etc.


2013/9/26 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Wed, 25 Sep 2013, Jonathan Nieder wrote:
>
>> Wataru Noguchi wrote:
>>
>> >   - actually file name is decoded.]
>> >   %E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%8=
3%88%E3%83%AA%201-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%=
87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%202-long-long-long-dirname/=
%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3=
%83%AA%203-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%8=
2%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%204-long-long-long-dirname/%E6%97%=
A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%=
205-long-long-long-dirname/%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB%E3%81%8A%E8=
%AA%AD%E3%81%BF%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84.txt
>> >
>> > This commit reduce gcc optimization level from O2 to O1 when MinGW
>> > Windows environment.
>>
>> Do you know why reducing the optimization level avoids a crash?
>
> I suspect that the optimization level causes smaller (or no) buffer bytes
> between data structures and the crash is the symptom of a buffer overflow=
.
> In that light, I think that reducing the optimization level is most likel=
y
> just working around this particular issue, and other scenarios might stil=
l
> crash until we fix the underlying bug.
>
> Most likely the problem is with our Windows-specific UTF-8 handling, I
> would not be surprised if it is my "favorite" bug: an off-by-one.
>
> To find out what the real cause is, I suggest using a tool similar to
> valgrind. Valgrind does not run on Windows, but I DuckDuckWent e.g.
> http://code.google.com/p/drmemory/ as an alternative that could be tried
> to identify the problem.
>
> Ciao,
> Johannes


Thanks!


--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
  Wataru Noguchi
  wnoguchi.0727@gmail.com
  http://wnoguchi.github.io/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

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
