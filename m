From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 5/8] t9901: fix line-ending dependency on windows
Date: Sat, 15 Oct 2011 13:25:25 +0100
Message-ID: <87pqhyigqy.fsf@fox.patthoyts.tk>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
	<1318632815-29945-6-git-send-email-patthoyts@users.sourceforge.net>
	<7vsjmux0z3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncCM7pyrzTCBDH-eX0BBoE9E3-bQ@googlegroups.com Sat Oct 15 14:30:31 2011
Return-path: <msysgit+bncCM7pyrzTCBDH-eX0BBoE9E3-bQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCM7pyrzTCBDH-eX0BBoE9E3-bQ@googlegroups.com>)
	id 1RF3Nl-0007te-I5
	for gcvm-msysgit@m.gmane.org; Sat, 15 Oct 2011 14:30:29 +0200
Received: by wwf25 with SMTP id 25sf1007137wwf.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 15 Oct 2011 05:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:cc:subject:references:x-face:x-url
         :x-home-page:x-web:date:in-reply-to:message-id:user-agent
         :mime-version:x-cloudmark-analysis:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=JQH2bYVUxu7YrShBUv7jP71Z8oBCAN47NBft9Lm3LN0=;
        b=tM4CboP7C7MRNLBKRcKvUpuCQ4JB9Uh0w2He3i4bQH7+qlpVbLSc86XK/TxWSowV0R
         N0pcGtD9ajQ8ech0/Xa4ZM4OaTkoLZBdMcV9uYIdowdXKvup/5CHNWuTvskbP24PfWPR
         CuiUDuZ7Go2twp1587kejgs171oDL2dMY9R+8=
Received: by 10.216.230.139 with SMTP id j11mr462741weq.22.1318681799862;
        Sat, 15 Oct 2011 05:29:59 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.216.202.220 with SMTP id d70ls16612093weo.3.gmail; Sat, 15 Oct
 2011 05:29:58 -0700 (PDT)
Received: by 10.216.132.219 with SMTP id o69mr320831wei.9.1318681798595;
        Sat, 15 Oct 2011 05:29:58 -0700 (PDT)
Received: by 10.216.223.82 with SMTP id u60mswep;
        Sat, 15 Oct 2011 05:25:28 -0700 (PDT)
Received: by 10.227.156.204 with SMTP id y12mr345502wbw.10.1318681527874;
        Sat, 15 Oct 2011 05:25:27 -0700 (PDT)
Received: by 10.227.156.204 with SMTP id y12mr345501wbw.10.1318681527851;
        Sat, 15 Oct 2011 05:25:27 -0700 (PDT)
Received: from mtaout01-winn.ispmail.ntl.com (mtaout01-winn.ispmail.ntl.com. [81.103.221.47])
        by gmr-mx.google.com with ESMTP id es13si6577981wbb.3.2011.10.15.05.25.27;
        Sat, 15 Oct 2011 05:25:27 -0700 (PDT)
Received-SPF: neutral (google.com: 81.103.221.47 is neither permitted nor denied by best guess record for domain of patthoyts@users.sourceforge.net) client-ip=81.103.221.47;
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015122527.SGGS13501.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 13:25:27 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RF3It-0003xv-An; Sat, 15 Oct 2011 13:25:27 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 26499201AC; Sat, 15 Oct 2011 13:25:26 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <7vsjmux0z3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 14 Oct 2011 22:44:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=sTYQEScDxnoA:10 a=kj9zAlcOel0A:10 a=ybZZDoGAAAAA:8 a=FP58Ms26AAAA:8 a=A1X0JdhQAAAA:8 a=Rf460ibiAAAA:8 a=eEKPzJ7vjPf_BeNKdkMA:9 a=AJXe8AY2BrZqTQTw9SwA:7 a=CjuIK1q_8ugA:10 a=qIVjreYYsbEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
X-Original-Sender: patthoyts@users.sourceforge.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 81.103.221.47 is neither permitted nor denied by best guess record for domain
 of patthoyts@users.sourceforge.net) smtp.mail=patthoyts@users.sourceforge.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183650>

Junio C Hamano <gitster@pobox.com> writes:

>Pat Thoyts <patthoyts@users.sourceforge.net> writes:
>
>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>> ---
>>  t/t9901-git-web--browse.sh |   10 +++++-----
>>  1 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
>> index 7906e5d..1185b42 100755
>> --- a/t/t9901-git-web--browse.sh
>> +++ b/t/t9901-git-web--browse.sh
>> @@ -12,7 +12,7 @@ test_expect_success \
>>  	echo http://example.com/foo\&bar >expect &&
>>  	git config browser.custom.cmd echo &&
>>  	git web--browse --browser=custom \
>> -		http://example.com/foo\&bar >actual &&
>> +		http://example.com/foo\&bar | tr -d "\r" >actual &&
>>  	test_cmp expect actual
>>  '
>
>This is unnice for two reasons. We have web--browse five times in this
>test script, and you add tr exactly the same way to each and every one of
>them. And you are losing the error condition from each and every one of
>these web--browse invocations.
>
>Having to do the same change to all invocations of the same command
>suggests that perhaps you can and should wrap that pattern into a single
>helper, perhaps like:
>
>test_web_browse () {
>	# browser=$1 url=$2
>	git web--browse --browser="$1" "$2" >actual &&
>        tr -d '\015' <actual >text &&
>        test_cmp expect text
>}
>
>or something?

OK - The suggested code works fine so I shall re-roll this one shortly.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
