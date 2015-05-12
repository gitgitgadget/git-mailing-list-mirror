From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] config.txt: Clarify allowTipSHA1InWant with camelCase
Date: Tue, 12 May 2015 14:33:44 -0700
Message-ID: <xmqqvbfxeb0n.fsf@gitster.dls.corp.google.com>
References: <xmqqy4l1sblq.fsf@gitster.dls.corp.google.com>
	<1431465265-18486-1-git-send-email-fredrik.medley@gmail.com>
	<CAPig+cTc7qE_tD2-DtpnMGrSFthwaGakFnOWAtkq=a5aOQNMbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fredrik Medley <fredrik.medley@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 12 23:33:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsHoF-0002iN-H7
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbbELVdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:33:47 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33320 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbbELVdq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:33:46 -0400
Received: by iebgx4 with SMTP id gx4so14478422ieb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HpOEmuu7e4QsS3TDlyfjnWYjYAL2huW/PQc+3uueTCY=;
        b=AuuHH7yLw6B2qy/wxXK5Gwg/RN3CvjNVwxb7sapldnrvR7sHZqNjDI5pDcafAE6CaU
         5YO9RiqYevgTwYMWPso4vpolt7MI2naVmLPFMWmas5GgYBmFRTiDN7EeHvyr9XBOvfYo
         JAnTmK+LwPLd1a6IUSpYeW8Zwubu2IxbE5rWD7Uj6dfyyYiV99Yklybx1XI3LWV7Fd/e
         C0MBsx3l03sQTaoq02+5A8DQLkEIFRS8IYPexDk/ssI/usAFHf+Qfs1cvHWE+Ot3sj+7
         tz7/j0L3RAUgdMZUMrT+g8ReJrGYuEqC2IFshjnHpOFbhfbmti1fSqNerSJCafeujuEF
         XN+g==
X-Received: by 10.42.79.197 with SMTP id s5mr5321344ick.85.1431466425938;
        Tue, 12 May 2015 14:33:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id s5sm2069722igh.6.2015.05.12.14.33.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 14:33:45 -0700 (PDT)
In-Reply-To: <CAPig+cTc7qE_tD2-DtpnMGrSFthwaGakFnOWAtkq=a5aOQNMbQ@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 12 May 2015 17:24:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268890>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> -uploadpack.allowtipsha1inwant::
>> +uploadpack.allowTipSHA1InWant::
>
> This was already attempted here[1]; some inconsistencies with acronyms
> and abbreviations pointed out here[2]; and delayed here[3].

This was entirely my "fault"; see $gmane/268493.
