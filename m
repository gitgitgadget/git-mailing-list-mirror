From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: Add stash.showFlag config variable
Date: Fri, 28 Aug 2015 11:10:20 -0700
Message-ID: <xmqqy4gv1dyr.fsf@gitster.mtv.corp.google.com>
References: <1440683528-11725-1-git-send-email-namhyung@gmail.com>
	<xmqq614043u0.fsf@gitster.mtv.corp.google.com>
	<20150828015433.GB17656@sejong>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:10:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVO6g-0006t1-Fu
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbbH1SKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:10:25 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34846 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbbH1SKY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:10:24 -0400
Received: by pacdd16 with SMTP id dd16so69883596pac.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=iPugO6p0EhTJMwKVavWXg9qz/y1N3IBvFi01oIV+xf0=;
        b=k9ejTeifNGu1VPgBe4Wk+g8GZ3MTZtOPZTfZbNRP0YvJFHei8hSeGuigddCknCfjH2
         0nwmjG0cHqiFYa63QQQEpLwp5ieiMiGzwyQmTaAz8ZE4sFky21EeCiHzMqj1A05bo2AI
         30rOnExjOMyifepaJFWV3QbVrs7cC30NQg4/4/SonANU/M8lVWWFBNPubTyAucAKG7Tx
         TFauhGlEkKi5uayqGxXumyjZ4+C0P7jRObyh/dn2/r3W91+f5kQ6ucKk5iG8abZGcueR
         OF3jsb7TuSSKoEMzZ4Dci+NjG0EKYU92ziSV2zE/t7PtuoxduWnMdthrGpYeib0DsPEz
         JV8w==
X-Received: by 10.66.158.65 with SMTP id ws1mr17768316pab.18.1440785423640;
        Fri, 28 Aug 2015 11:10:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id w17sm6423885pbt.17.2015.08.28.11.10.20
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 28 Aug 2015 11:10:21 -0700 (PDT)
In-Reply-To: <20150828015433.GB17656@sejong> (Namhyung Kim's message of "Fri,
	28 Aug 2015 10:54:33 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276741>

Namhyung Kim <namhyung@gmail.com> writes:

>> Perhaps a pair of new booleans
>> 
>>  - stash.showStat (defaults to true but you can turn it off)
>>  - stash.showPatch (defaults to false but you can turn it on)
>> 
>> or something along that line might be sufficient and more palatable.
>
> Hmm.. I agree with you, but I don't know what we should do if both of
> the options were off.  Just run 'git diff' with no option is ok to you?

If the user does not want stat or patch, then not running anything
would be more appropriate, don't you think?
