From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git bundle format
Date: Mon, 26 Nov 2012 21:56:14 +0100
Message-ID: <CAMP44s0x17AkYenj8HyXNpkgrPOXtB72dpFOvik882ESohPb7w@mail.gmail.com>
References: <871B6C10EBEFE342A772D1159D13208537ABF5AB@umechphj.easf.csd.disa.mil>
	<CAMP44s03QiO15jODBD4JO_JF8tCOT9OJG1tb4+r+L4dgPUOLFg@mail.gmail.com>
	<871B6C10EBEFE342A772D1159D13208537ABF676@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:56:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5jf-0002Ra-2E
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 21:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891Ab2KZU4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 15:56:18 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:44598 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab2KZU4P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 15:56:15 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so6106446vbb.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 12:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RG6Hn9Nq/27B+nxTOsoA7Crzq1fYtib41Q68Znsk1YQ=;
        b=kAfmSooYqF+ETEk1jlqLsaoUDlBvlRqRKOhtJVL/7hl6py161fRdyK1B4vIobby0TT
         5iymbl9cKPx2Jo0DpaeZ5owAlfPSjcd4LVpWVjJqFCdpm4hMyePRP/VIosoMTtBt7Y0B
         J//ZZKx+HyJkHZvVTzeUMpZ/yqHgqGEYeIWxSa/OhFIk9aB3xMd5tPXEAMp2dKQndiXu
         mS4irs5RGmBcjlXE9Ob4pZoQzOFuTd/q+hiusF66PaaKD6T3y8ciWQFkUdybd/6h75/R
         FAk7d5RwADoA2DV1q2cgtE1n1ZmY2fyshKMxkkRqZawZv9XrdIRHWUDHpK9jWNZaSPeF
         XJ0Q==
Received: by 10.220.241.141 with SMTP id le13mr20809886vcb.26.1353963374597;
 Mon, 26 Nov 2012 12:56:14 -0800 (PST)
Received: by 10.58.34.51 with HTTP; Mon, 26 Nov 2012 12:56:14 -0800 (PST)
In-Reply-To: <871B6C10EBEFE342A772D1159D13208537ABF676@umechphj.easf.csd.disa.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210488>

On Mon, Nov 26, 2012 at 9:50 PM, Pyeron, Jason J CTR (US)
<jason.j.pyeron.ctr@mail.mil> wrote:
>> -----Original Message-----
>> From: Felipe Contreras
>> Sent: Monday, November 26, 2012 3:20 PM
>>
>> On Mon, Nov 26, 2012 at 8:24 PM, Pyeron, Jason J CTR (US)
>> <jason.j.pyeron.ctr@mail.mil> wrote:
>> > I may need to be nudged in a better direction, but please try to
>> understand my intentions.
>> >
>> > I am facing a situation where I would like to use git bundle but at
>> the same time inspect the contents to prevent a spillage[1].
>> >
> <snip/>
>> >
>> > Am I barking up the right tree?
>>
>> Have you tried 'git fast-export'? The output is definitely not human
>> inspectable, but should be relatively easy to parse to generate such a
>> format. And instead of 'git bundle unbundle' you could use 'git
>> fast-import'. or simply do the conversion in your script.
>
> No. But I am going to read up on it today. It clearly says "You can use it as a human-readable bundle replacement"[4].

Ah, didn't notice that.

> My initial question is does it ever use deltas?

No.

> The repositories I just tested it on only seem to output full blobs (which is really nice from this use case point of view).

In my experience it's nice for most use-cases. Since git only deals
with full file contents, that makes sense.

Cheers.

-- 
Felipe Contreras
