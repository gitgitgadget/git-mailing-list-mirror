From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH 13/14] Add README for MSVC build
Date: Wed, 16 Sep 2009 07:26:40 +0200
Message-ID: <4AB07710.4080604@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com>	 <ffd7cfd6114f08c6502b21140d56d9bcd5d2a554.1253021728.git.mstormo@gmail.com>	 <4924c3de4fa490d1f41b75d18864f0a57fbd0eda.1253021728.git.mstormo@gmail.com>	 <88c817f030cfcc1e3b9e08f80d7ccfbcdfad7ecb.1253021728.git.mstormo@gmail.com>	 <8bcd4b022f59a5f55b63f87c9cf6a4dadc71cc44.1253021728.git.mstormo@gmail.com>	 <606db5a89cc49818fa225312a3bb6dbda18867a6.1253021728.git.mstormo@gmail.com>	 <65347d022ba857d57d3c081f28b239b9b665c587.1253021728.git.mstormo@gmail.com>	 <cover.1253021728.git.mstormo@gmail.com>	 <9fc49662e1ec00388adb3d50c41d20561ed58939.1253021728.git.mstormo@gmail.com>	 <22e0abb5a1e91c3ca95f8538d8396c167bb1028d.1253021728.git.mstormo@gmail.com> <a4c8a6d00909151822p6f9d8dffr9391d7e58077de2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,  git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com,  snaury@gmail.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 07:27:34 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f156.google.com ([209.85.211.156])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnn3F-00034H-Lj
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 07:27:33 +0200
Received: by ywh28 with SMTP id 28so10841631ywh.14
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Sep 2009 22:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=5SG7hCuVh6Qyg//3JyedFn9kVHauei2Gc1yyku3bZes=;
        b=sJPDGJSsPekpHRcsrQ0lQpF3VLkHoiQ0PhlZeeqXVT0imWKbb4UqCuxeulOtbEzhZu
         DEbAI6WOd15RlGxMmjTiNCzexIfTgvjtNe0mR8gucC8BLKTOO8NcrWH52Piitit/FX/F
         W8bvehtPTp2EYKpLtkXuNjtgk2BPn7QH+NZp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=25znUXrNzd47kd3Z4XbXXaIfb0XoFHa+MDGBtWtKTYxBOiSoYbzYTs234AaVl0cxcx
         4ZmXfHRnNKG+n7V538gZDJcdFyWqIG7qO2mk9PK3++wneCVIwzMlHZ5FXfNWqnIOcAyr
         LpWr/42EM0ydcCuKaxlE0i4b7Hv0pSyeVb60I=
Received: by 10.150.5.1 with SMTP id 1mr2494026ybe.18.1253078845738;
        Tue, 15 Sep 2009 22:27:25 -0700 (PDT)
Received: by 10.176.233.14 with SMTP id f14gr7030yqh.0;
	Tue, 15 Sep 2009 22:27:10 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.9.6 with SMTP id 6mr1400686ebi.29.1253078829297; Tue, 15 Sep 2009 22:27:09 -0700 (PDT)
Received: by 10.210.9.6 with SMTP id 6mr1400685ebi.29.1253078829276; Tue, 15 Sep 2009 22:27:09 -0700 (PDT)
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com [209.85.219.220]) by gmr-mx.google.com with ESMTP id 16si1651997ewy.3.2009.09.15.22.27.08; Tue, 15 Sep 2009 22:27:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.220 as permitted sender) client-ip=209.85.219.220;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.220 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ewy20 with SMTP id 20so4091074ewy.45 for <msysgit@googlegroups.com>; Tue, 15 Sep 2009 22:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from :user-agent:mime-version:to:cc:subject:references:in-reply-to :content-type:content-transfer-encoding; bh=227dag/9m9T8KaYJG377SRZ5wR5LTNsKhRKl2Gt38vc=; b=o+INHM4kRp8Fh3N+oEMdw3Hmz54T5FwrtwEL+O6n5vHdNq0CszFBC1y9dx+gIHohZ9 qG1O9A+5XNHKFtiIEgulzTDjl/LJTlMjopi90V809PSc+9cSmKdPdLz69L1utOoBAgGK CVIChlwP70I2HiyMqEi/zCDNKX7ySZt51OQ60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:user-agent:mime-version:to:cc:subject :references:in-reply-to:content-type:content-transfer-encoding; b=Uup25YA/xarhQzfunDV0mvDk+JNWmSjXuj+WSEY2UcL4rESc4++J6YnyugTeiq1S7h w14qrS2j2UO6VEmZ5scYmLmq0kvEXYFVOg+tvfczCVYEeOwJdHiBr/+BKtwhGJwx5tS8 f0/ajZfIp8bTdEqiHctlYUuZ/kgrukXaweNCo=
Received: by 10.211.144.7 with SMTP id w7mr9446667ebn.28.1253078828163; Tue, 15 Sep 2009 22:27:08 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104]) by mx.google.com with ESMTPS id 28sm8196619eyg.4.2009.09.15.22.27.06 (version=TLSv1/SSLv3 cipher=RC4-MD5); Tue, 15 Sep 2009 22:27:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <a4c8a6d00909151822p6f9d8dffr9391d7e58077de2@mail.gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128607>


Thiago Farina said the following on 16.09.2009 03:22:
> On Tue, Sep 15, 2009 at 10:44 AM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
>> Based on original README patch from Frank Li
>>
>> Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
>> ---
>>  compat/vcbuild/README |   39 +++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 39 insertions(+), 0 deletions(-)
>>  create mode 100644 compat/vcbuild/README
>>
>> diff --git a/compat/vcbuild/README b/compat/vcbuild/README
>> new file mode 100644
>> index 0000000..5d7a07a
>> --- /dev/null
>> +++ b/compat/vcbuild/README
>> @@ -0,0 +1,39 @@
>> +The Steps of Build Git with VS2008
>> +
>> +1. You need the build environment, which contains the Git dependencies
>> +   to be able to compile, link and run Git with MSVC.
>> +
>> +   You can either use the binary repository:
>> +
>> +       WWW: http://repo.or.cz/w/msvcgit.git
>> +       Git: git clone git://repo.or.cz/msvcgit.git
>> +       Zip: http://repo.or.cz/w/msvcgit.git?a=snapshot;h=master;sf=zip
>> +
>> +   and call the setup_32bit_env.cmd batch script before compiling Git,
>> +   (see repo/package README for details), or the source repository:
>> +
>> +       WWW: http://repo.or.cz/w/gitbuild.git
>> +       Git: git clone git://repo.or.cz/gitbuild.git
>> +       Zip: (None, as it's a project with submodules)
>> +
>> +   and build the support libs as instructed in that repo/package.
>> +
>> +2. Ensure you have the msysgit environment in your path, so you have
>> +   GNU Make, bash and perl available.
>> +
>> +       WWW: http://repo.or.cz/w/msysgit.git
>> +       Git: git clone git://repo.or.cz/msysgit.git
>> +       Zip: http://repo.or.cz/w/msysgit.git?a=snapshot;h=master;sf=zip
>> +
>> +   This environment is also needed when you use the resulting
>> +   executables, since Git might need to run scripts which are part of
>> +   the git operations.
>> +
>> +4. Inside Git's directory run the command:
> Shouldn't be 3.?
>> +       make common-cmds.h
>> +   to generate the common-cmds.h file needed to compile git.
>> +
>> +5. Then build Git with the GNU Make Makefile in the Git projects root
> 4.?

Heh, you're right.. I've been modifying this file too much lately :-)

--
.marius
