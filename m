From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] git: make "git -C '' <cmd>" not to barf
Date: Wed, 04 Mar 2015 14:11:16 +0530
Message-ID: <E3F15B02-CDDA-473C-86D0-2A337FBDF185@gmail.com>
References: <1425397291-25435-1-git-send-email-karthik.188@gmail.com> <vpq385mgifi.fsf@anie.imag.fr> <CAPc5daWFAV2P_MCCo=oz2Be=2_L5NVxNweY+rUbU5OcK84wVaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 04 09:41:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT4s0-0008Ep-SZ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 09:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbbCDIl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 03:41:28 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:42234 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbbCDIl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 03:41:27 -0500
Received: by padfa1 with SMTP id fa1so31621269pad.9
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 00:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=uI1Pr9H8A17aJX4cJXCcGrWJxNNwOa3SPMgSXe9B+qk=;
        b=ykucRbIJmpb9PWY5Uf5L0euOa7wRUH4ug/WFSd4g5NbOa4peaXVD+w00V6Gxe5VsQa
         MXpxRcmJHjRO5aAioyxxWBSxLIkjXW2thYjE7mT0Han3EBowwSwgAspfLWFKoTfzzYy+
         vAsb+JlAoZ/nBg3KFwjWvhJ6bOCoRyopet+o7mc9oynXRSp+LybZz/1yHdZp/OjtSMm2
         5qqZ7kWJEFzjLTgg42enhXXhNk3lEbsMyOQPsWYUC+e6mWPyAx040ekPhKSDbUw7klvF
         BFOKKv128rMV/8wRBdwFD0S51743ZDAU+bevyJrGTVxOyp9rgya5vNwAcOmuuKvJuyqV
         TB3Q==
X-Received: by 10.70.127.166 with SMTP id nh6mr4693376pdb.159.1425458487342;
        Wed, 04 Mar 2015 00:41:27 -0800 (PST)
Received: from [100.85.210.38] ([182.156.10.68])
        by mx.google.com with ESMTPSA id om6sm3256434pdb.40.2015.03.04.00.41.24
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Mar 2015 00:41:26 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPc5daWFAV2P_MCCo=oz2Be=2_L5NVxNweY+rUbU5OcK84wVaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264735>



On March 3, 2015 11:30:13 PM GMT+05:30, Junio C Hamano <gitster@pobox.com> wrote:
>On Tue, Mar 3, 2015 at 8:22 AM, Matthieu Moy
><Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> now it works like cd "" which silently succeeds
>>
>> Missing "." at end of sentence.
>
>And lack of capitalization at the beginning.
Yes, noted, Will fix with next patch.
>
>More importantly, lack of justification--why is it a good idea to make
>"it works like cd ''" in the first place?
>
>>
>>>  git.c | 4 +++-
>>
>> That would probably also deserve a test.
Will include a patch with next patch version.
>
>Another "huh?" I had on the actual code was if this counts as
>"envchanged", if
>you are not actually changing the directory at all.
>
>Is this meant as a "micro" for GSoC, by the way?
Yes, it's meant for GSoC.
I did overlook that. Will fix in next patch version. 
Thanks for your suggestions
