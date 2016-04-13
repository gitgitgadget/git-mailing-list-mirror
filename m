From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: 0 bot for Git
Date: Wed, 13 Apr 2016 14:16:54 +0200
Message-ID: <BF053934-BA62-4621-AAAA-11F821B274EA@gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com> <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com> <vpq60vnl28b.fsf@anie.imag.fr> <CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com> <vpqoa9ea7vx.fsf@anie.imag.fr> <xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com> <vpqegaa9i89.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 13 14:17:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqJjB-00063a-W9
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966364AbcDMMQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 08:16:58 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38780 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197AbcDMMQ4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2016 08:16:56 -0400
Received: by mail-wm0-f52.google.com with SMTP id u206so74207330wme.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WU/o4MJnR6Wva1zRyvJeXmZXHFGbdT9M8Orv7cvShQA=;
        b=JskY0oNyPT0GTk0y/zMVBWybgt4WKPGscHvrkt4wv+b/yLDuysRrVlzSKTnvxzqfDa
         rxMFdFNDugShU/UxGxz1AI9RFZYdJ6uJzXDInMwqalCv2Iko9LgB+sWzbBaNlytz1Fy9
         e8f9MibiXuZTzR3W80KDhfG4cPMMQLNa5EVXE7b6CNTxENDf2VvkNtSnm2IZhhVxUrPK
         p0uiH0xZ8mVAZAmW+FMZ++ZPTLQUZX3FQI/1s7fmytrw9VZChW1asHaCFF0owoLrhAgz
         Uq4BYd6/dUuGFdtZ0wZbrMrj7TqG0YttjY7c4MK0vatpxFanAjq7RUVnHiekpvF6sAXN
         9yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WU/o4MJnR6Wva1zRyvJeXmZXHFGbdT9M8Orv7cvShQA=;
        b=TgcyXJZFXu1yuQkV5f1bOh29+iTmiwl5xhgk31qYllsZF+WojjJabDmIFVm8L63/ZS
         o+MYRIh/slN/BqcEAYsJ7GQWM8ip79iLr8G4oDmfNtgn7PUBjrOxxu4b3IItWM6Ew6HR
         m2vGnXEeG2cClYZ7RB1VIYyt5poH2dgM7wLOgGp5kvq0J4IP//HDcss7ktwkMH2hXp8o
         r82aVzMisdtgneOKFUfVkKmZrXxzc9PL7sfjx8DnaxmddZLh7qzNbayOoKZwdXsPdqVv
         Rne+ti6W2OerW+ub65ll/QEktSEn1SF8kKBDWfdQo77fAv7XYqvYfyn0S5OwlqvG/IYF
         434Q==
X-Gm-Message-State: AD7BkJIMivyaC8H0PBgDaEdRP93nSbCZU5jmvvu0esIY4aUqqluR7mSa+7bDoXPt9HVlIw==
X-Received: by 10.28.177.132 with SMTP id a126mr29335513wmf.86.1460549815529;
        Wed, 13 Apr 2016 05:16:55 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id kj9sm38441543wjb.14.2016.04.13.05.16.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Apr 2016 05:16:54 -0700 (PDT)
In-Reply-To: <vpqegaa9i89.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291391>


> On 13 Apr 2016, at 07:43, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> 
>> True, presumably the Travis integration already solves that part, so
>> I suspect it is just the matter of setting up:
>> 
>> - a fork of git.git and have Travis monitor any and all new
>>   branches;
>> 
>> - a bot that scans the list traffic, applies each series it sees to
>>   a branch dedicated for that series and pushes to the above fork.
> 
> ... and to make it really useful: a way to get a notification email sent
> on-list or at least to the submitter as a reply to the patch series.
> Just having a web interface somewhere that knows how broken the code is
> would not be that useful.

Travis CI could do this but I intentionally disabled it to not annoy anyone.
It would be easy to enable it here:
https://github.com/git/git/blob/7b0d47b3b6b5b64e02a5aa06b0452cadcdb18355/.travis.yml#L98-L99

Cheers,
Lars