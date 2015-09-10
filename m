From: Martin Fick <mfick@codeaurora.org>
Subject: Re: storing cover letter of a patch series?
Date: Thu, 10 Sep 2015 12:02:02 -0600
Message-ID: <18979417.pyyHNUINeQ@mfick1-lnx>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com> <xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>, Git List <git@vger.kernel.org>, repo-discuss@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: repo-discuss+bncBCF6VG7K3QDRBHMLY6XQKGQEOVXGRII@googlegroups.com Thu Sep 10 20:02:32 2015
Return-path: <repo-discuss+bncBCF6VG7K3QDRBHMLY6XQKGQEOVXGRII@googlegroups.com>
Envelope-to: gcvr-repo-discuss@m.gmane.org
Received: from mail-pd0-f190.google.com ([209.85.192.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <repo-discuss+bncBCF6VG7K3QDRBHMLY6XQKGQEOVXGRII@googlegroups.com>)
	id 1Za6Ai-00005O-7U
	for gcvr-repo-discuss@m.gmane.org; Thu, 10 Sep 2015 20:02:08 +0200
Received: by pdkh16 with SMTP id h16sf8591046pdk.1
        for <gcvr-repo-discuss@m.gmane.org>; Thu, 10 Sep 2015 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=YjwvD9sEBT4aplRsQ7x2yiAvBIux1lJQKGt66ml0ab0=;
        b=wrECsJo2agJYEU2Lf9YdfOdnCj5PfyzcKCMA7fESEJeB/4Rs5UfR4eOCXzYXaIgVJ5
         KKPGJ2v2eO3OD8nDcDsh3DtG8eeaZ5IZQOr/jjq7fg7gq2oAwGtsin92hvZH/MZm6NNU
         96Jcqynr2jbZIQEOq4uan+0XF62ZSOS1Zc+L5/Chj+1dqKo3+MA5rTp9KbENkn8x2hZa
         TCga9j83kO71udDd56AHpd4CngY5i34Ct2hQZ/sO0O3KR1vJgVfzZUJmTnVdd+AwnkWJ
         NpOZBAaE6JJ+2wWYZdNw1ksDOnrJ5v6dLCW3rWURIvhYP6/GGYuLNVTNfvWr6AURIGhi
         rCBw==
X-Received: by 10.140.19.85 with SMTP id 79mr270008qgg.22.1441908127443;
        Thu, 10 Sep 2015 11:02:07 -0700 (PDT)
X-BeenThere: repo-discuss@googlegroups.com
Received: by 10.140.35.179 with SMTP id n48ls1032493qgn.82.gmail; Thu, 10 Sep
 2015 11:02:05 -0700 (PDT)
X-Received: by 10.129.154.212 with SMTP id r203mr36639723ywg.12.1441908125006;
        Thu, 10 Sep 2015 11:02:05 -0700 (PDT)
Received: from smtp.codeaurora.org (smtp.codeaurora.org. [198.145.29.96])
        by gmr-mx.google.com with ESMTPS id lp10si1299137pab.1.2015.09.10.11.02.04
        for <repo-discuss@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2015 11:02:04 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of mfick@codeaurora.org designates 198.145.29.96 as permitted sender) client-ip=198.145.29.96;
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9F959140EC0;
	Thu, 10 Sep 2015 18:02:04 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 91EDD140EC4; Thu, 10 Sep 2015 18:02:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick1-lnx.localnet (unknown [129.46.10.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 3BF29140EC0;
	Thu, 10 Sep 2015 18:02:04 +0000 (UTC)
User-Agent: KMail/4.8.5 (Linux/3.2.0-75-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Original-Sender: mfick@codeaurora.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of mfick@codeaurora.org designates
 198.145.29.96 as permitted sender) smtp.mailfrom=mfick@codeaurora.org
Precedence: list
Mailing-list: list repo-discuss@googlegroups.com; contact repo-discuss+owners@googlegroups.com
List-ID: <repo-discuss.googlegroups.com>
X-Spam-Checked-In-Group: repo-discuss@googlegroups.com
X-Google-Group-Id: 540870184241
List-Post: <http://groups.google.com/group/repo-discuss/post>, <mailto:repo-discuss@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:repo-discuss+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/repo-discuss
Sender: repo-discuss@googlegroups.com
List-Subscribe: <http://groups.google.com/group/repo-discuss/subscribe>, <mailto:repo-discuss+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+540870184241+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/repo-discuss/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277618>

+repo-discuss@googlegroups.com (to hit Gerrit developers 
also)

On Thursday, September 10, 2015 09:28:52 AM Jacob Keller 
<jacob.keller@gmail.com> wrote:
> does anyone know of any tricks for storing a cover letter
> for a patch series inside of git somehow? I'd guess the
> only obvious way currently is to store it at the top of
> the series as an empty commit.. but this doesn't get
> emailed as the cover letter...
...
> I really think it should be possible to store something
> somehow as a blob that could be looked up later.


On Thursday, September 10, 2015 10:41:54 AM Junio C Hamano 
wrote:
> 
> I think "should" is too strong here.  Yes, you could
> implement that way.  It is debatable if it is better, or
> a flat file kept in a directory (my-topic/ in the example
> above) across rerolls is more flexible, lightweight and
> with less mental burden to the users. --

As a Gerrit developer and user, I would like a way to 
see/review cover letters in Gerrit.  We have had many 
internal proposals, most based on git notes, but we have 
also used the empty commit trick.  It would be nice if there 
were some standard git way to do this so that Gerrit and 
other tools could benefit from this standard.  I am not 
suggesting that git need to be modified to do this, but 
rather that at least some convention be established.

-Martin


-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

-- 
