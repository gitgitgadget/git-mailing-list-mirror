From: dhruva <dhruvakm@gmail.com>
Subject: Re: git build on msys fails (and fix)
Date: Mon, 1 Dec 2008 18:37:30 +0530
Message-ID: <e3f230850812010507y54dff6dh3757bf97c78c0329@mail.gmail.com>
References: <e3f230850811300302y68992b9doe4897d97d513de3a@mail.gmail.com> <4933A922.7080300@viscovery.net> <e3f230850812010132g48fcdf2fm46310b601990e51d@mail.gmail.com> <e3f230850812010252i67d9846cg439b5951485ee7fe@mail.gmail.com> <e3f230850812010348w793e17c2q6ab92cf9b2c04972@mail.gmail.com> <4933D10E.6020706@viscovery.net> <e3f230850812010402n69cced19s3f36a5bcb84977c6@mail.gmail.com>
Reply-To: dhruvakm@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Dec 01 14:08:52 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L78WB-0001vT-5K
	for gcvm-msysgit@m.gmane.org; Mon, 01 Dec 2008 14:08:51 +0100
Received: by yx-out-2122.google.com with SMTP id 22so717384yxm.63
        for <gcvm-msysgit@m.gmane.org>; Mon, 01 Dec 2008 05:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=9A9Is1jsEcEN0/x8tkT8IitTmq+Nz86JIJ/VTIHoFGM=;
        b=g4SYQcOvdno/eyQWdqU03NpdrapfWRw+naPCGCBd+zKW1L90Dc1kqvxUrkOJQgHcV+
         oJCJ1Ya+soTWIEo1wLxe0Cfu5vD0qDr2qDJE8XaJVU1IDdjh2upNYH8vpw89+GZkNSdn
         4WPsh/x9iuaX6+GeemN6YCgajB8hFKWYmFw6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:to:subject
         :cc:in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:references:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=L9w9RiQhOD6cm8FtYizHtSwYLGYCTcxL4p/7NWjn2lMKTl7P7Y9xV7bIwastQaDFj6
         KKROFM5GL0h8s3pwVexB5TSg1Xogb44cKvrmYa8G2l+dAKMoiLu6zY+Twzowvmr0Fg4P
         xjxjJpZD359ja0n4Nk9OF+oHRjJQSr62UtREc=
Received: by 10.101.1.16 with SMTP id d16mr902692ani.7.1228136852731;
        Mon, 01 Dec 2008 05:07:32 -0800 (PST)
Received: by 10.176.58.42 with SMTP id g42gr3194yqa.0;
	Mon, 01 Dec 2008 05:07:32 -0800 (PST)
X-Sender: dhruvakm@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.118.19 with SMTP id q19mr3988220agc.22.1228136851525; Mon, 01 Dec 2008 05:07:31 -0800 (PST)
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154]) by mx.google.com with ESMTP id 7si5709126yxg.0.2008.12.01.05.07.30; Mon, 01 Dec 2008 05:07:30 -0800 (PST)
Received-SPF: pass (google.com: domain of dhruvakm@gmail.com designates 74.125.46.154 as permitted sender) client-ip=74.125.46.154;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of dhruvakm@gmail.com designates 74.125.46.154 as permitted sender) smtp.mail=dhruvakm@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by yw-out-1718.google.com with SMTP id 5so910159ywm.14 for <msysgit@googlegroups.com>; Mon, 01 Dec 2008 05:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to :subject:cc:in-reply-to:mime-version:content-type :content-transfer-encoding:content-disposition:references; bh=8Zf4ez/sNchC+TYopYP+u7v+avGQ6t3o4Pkt/ds9rBE=; b=e5ytwiB22TXrUeFd3BBH5peoSsmWaPpFswy+t+5ItKmtJrfQzirfRD6eguNt0/vBd/ A/0opWZInrKcwNZCSjKTZLUjEm9qHz50TgB4RgNsc9L0N83D6E2uboA2Ft4UfMB9KL1Z 8ac2KYyEax/9heWwl381mi2iiBKuXHWs3TTeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version :content-type:content-transfer-encoding:content-disposition :references; b=InbHxekp4QlI9Is+fRSjz8V3AwueiYetqmZR3jNsiOkdJWw0kZZHb3tsGLNH60hKxp Wk+adGLyLC+Xg9qv3EiHsVWh3vDcOr7p3/tbrXklB/BEFaS9cq8ckRmX8CsLFIZFUtfh ajPt6QsdypAnU+qFrjd15wm8ZDHLNlcb7sVyw=
Received: by 10.142.141.21 with SMTP id o21mr4487846wfd.270.1228136850425; Mon, 01 Dec 2008 05:07:30 -0800 (PST)
Received: by 10.142.110.21 with HTTP; Mon, 1 Dec 2008 05:07:30 -0800 (PST)
In-Reply-To: <e3f230850812010402n69cced19s3f36a5bcb84977c6@mail.gmail.com>
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102030>


Hi,
I am trying to push to 'mob'.

$ git branch --track mob origin/mob
$ tar -zxvf ~/pthread.tar.gz
$ make prefix= html all install
$ git push repo.or.cz:/srv/git/msysgit.git
fatal: protocol error: bad line length charact
@:/
[531]$ Access denied
Access denied
Access denied
Access denied
Access denied
Access denied
FATAL ERROR: Server sent disconnect message
type 2 (protocol error):
"Too many authentication failures for dhruva"

Could someone help me out with this?

-dhruva

On Mon, Dec 1, 2008 at 5:32 PM, dhruva <dhruvakm@gmail.com> wrote:
> Hello,
>
> On Mon, Dec 1, 2008 at 5:27 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> dhruva schrieb:
>>>  I got the mob branch and I fail to see the Makefile. I decided to
>>> just add the pthread related files and push so that someone could
>>> build, I get authentication failures. I had tried to push perl
>>> sometime back when I had a gcc compiler perl (before strawberry perl)
>>> and had similar problems. I am fairly certain I am doing something
>>> wrong but cannot figure it out!
>>
>> msysgit.git is *not* a git.git clone; it is the MSYS/MinGW environment to
>> build git.git on Windows.
>>
>> You should apply the steps 1. to 4. that you mentioned in an earlier mail
>> and push the result; but you cannot apply 5. because that is a change to
>> git itself.
>
> I request someone to just pull the archive I have placed just this
> time, I will try again for other patches. I will create a clone in a
> separate folder for msysgit and keep it ready. Unknowingly, I just
> cleaned up the remote and lost all the changes I had pulled earlier :(
>
> -dhruva
>
> --
> Contents reflect my personal views only!
>



-- 
Contents reflect my personal views only!
