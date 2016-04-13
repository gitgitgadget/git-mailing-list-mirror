From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: 0 bot for Git
Date: Wed, 13 Apr 2016 19:09:41 +0200
Message-ID: <BF9D5A7E-CB73-4F82-8D5F-42E120D07A3B@gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com> <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com> <vpq60vnl28b.fsf@anie.imag.fr> <CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com> <vpqoa9ea7vx.fsf@anie.imag.fr> <xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com> <88CF8CB5-4105-4D0C-8064-D66092169111@gmail.com> <xmqqa8kxlbix.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 19:09:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqOIV-0004L8-QV
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 19:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbcDMRJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 13:09:44 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34976 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbcDMRJn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 13:09:43 -0400
Received: by mail-wm0-f46.google.com with SMTP id a140so112609821wma.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ot1bFsvc3wD/PaiYl2UFzplk64mAgmsx6S+Shbi5je8=;
        b=iQn18vyVxJ+4bZJwDyPPcpwdY39JPSlxhWcah/0TYjFNqzEewi3dAo65OON4RL9SPV
         5RBCDs+9aM9yi4H9b0bnMlia0q797Kl9PWaBEypzzv1Y18tALlBCsAjWD4BUToxL7L0f
         t5Bov5CMmDFbX2ZVIOcYfcQYllCYC7JhNIRRywfIAKh3pd+mOEyhQ6g8YdGBOxRoP+yL
         3l4B1w7/cGHxoEOMonyoAgKe/Y6cZBohF4WTk9aktsXAGSMmAHCjjAE2UqsevIXis89G
         2+l7xGx2nM0tFee479ekiNQRtaz8gjXia05BWXkmoMJ1Q8KvHeXs/iEf9TT949MvdsJH
         JpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ot1bFsvc3wD/PaiYl2UFzplk64mAgmsx6S+Shbi5je8=;
        b=fTggI2SdBSPj476yWKL1UcX4et++anUOT8I88zULa1TLMxnsqnFNGazN3UpbYb9hCh
         4NMOS8k3Ck+SmRofXd5XdltK88m4w6pTl5OTY78tmnU925uYPu6THc4mOneirrOBMoMO
         CNmje3HsFsNnEWHIBrxiKB1RenAmDj7TK/vAqQm5BxC67d2Kle8jMDkHbiaItGL2ExrE
         uF+KNT7n6YY/UGd0229uwPSyncni8uGO6e0IDGs7XpLeW7wOrO84Bj0RR6kaj+k3b3PB
         9SR6471bQ4qV6cm1RTVOA7ME5ZdZV+TebL56mfOtA7HlrCr6W/uAJK5nSU/b4vQMkaRc
         c7aA==
X-Gm-Message-State: AOPr4FXbCigSIuxReL0uTE+i+3PPIoEc87+AOky32b2z3EQk7Y1VrbS0xIKGX5PWmCM8Wg==
X-Received: by 10.194.58.138 with SMTP id r10mr10865179wjq.153.1460567382014;
        Wed, 13 Apr 2016 10:09:42 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id k139sm2179818wmg.24.2016.04.13.10.09.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Apr 2016 10:09:41 -0700 (PDT)
In-Reply-To: <xmqqa8kxlbix.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291461>


> On 13 Apr 2016, at 18:27, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> @Junio:
>> If you setup Travis CI for your https://github.com/gitster/git fork
>> then Travis CI would build all your topic branches and you (and 
>> everyone who is interested) could check 
>> https://travis-ci.org/gitster/git/branches to see which branches 
>> will break pu if you integrate them.
> 
> I would not say such an arrangement is worthless, but it targets a
> wrong point in the patch flow.
> 
> The patches that result in the most wastage of my time (i.e. a
> shared bottleneck resource the community should strive to optimize
> for) are the ones that fail to hit 'pu'.  Ones that do not even
> build in isolation, ones that may build but fail even the new tests
> they bring in, ones that break existing tests, and ones that are OK
> in isolation but do not play well with topics already in flight.

I am not sure what you mean by "fail to hit 'pu'". Maybe we talk at
cross purposes. Here is what I think you do, please correct me:

1.) You pick the topics from the mailing list and create feature 
    branches for each one of them. E.g. one of my recent topics 
    is "ls/config-origin".

2.) At some point you create a new pu branch based on the latest
    next branch. You merge all the new topics into the new pu.

If you push the topics to github.com/gitster after step 1 then
Travis CI could tell you if the individual topic builds clean 
and passes all tests. Then you could merge only clean topics in 
step 2 which would result in a pu that is much more likely to 
build clean.

Could that process avoid wasting your time with bad patches?

> Automated testing of what is already on 'pu' does not help reduce
> the above cost, as the culling must be done by me _without_ help
> from automated test you propose to run on topics in 'pu'.  Ever
> heard of chicken and egg?
> 
> Your "You can setup your own CI" update to SubmittingPatches may
> encourage people to test before sending.  The "Travis CI sends
> failure notice as a response to a crappy patch" discussed by
> Matthieu in the other subthread will be of great help.
> 
> Thanks.
> 
