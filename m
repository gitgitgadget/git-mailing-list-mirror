From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v11 2/5] command-list.txt: add the common groups block
Date: Tue, 26 May 2015 14:31:17 -0400
Message-ID: <CAPig+cRPE30=euNYMEek4h8WgfMVFZKgxTqD8=L6BE11FAs8YA@mail.gmail.com>
References: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>
	<1432229962-21405-3-git-send-email-sebastien.guimmara@gmail.com>
	<CAPig+cRciCgBZyuT4fz0JZLY9SRmODaXq=gvsimVQ7sdt+AzcA@mail.gmail.com>
	<55635C84.7080108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 20:31:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxJdL-0000b2-8q
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 20:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbbEZSbT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 14:31:19 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34530 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbbEZSbS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2015 14:31:18 -0400
Received: by igbhj9 with SMTP id hj9so67448886igb.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=UybJG5xDq7NgqDcyt6uNOQ7zu0kr7VfvjrLcMZRmwNs=;
        b=kb1lc32UwBIHMbCCOegUHlkAWOgqjuRVY1KpkkqJuHoNruFwjL+U+fb/sOlPSjqfRy
         OtROCW1r4H3FvQnN/hc7ZvjW4oXYz2rbIXAkglSNrmlP6qrjNQsWKeQxSSmd2zm7tHgq
         NEuB0YUNLuKNcqel8pdufiuk5rg3J4QHGU31VR6bE0g/GOJDG1OYpj5ggBOKTcIet0cT
         HBWuQ+2/15EBlxsU5evIjw9d3cbAjdK80HqlLATM2/OL8RTHGOr7Gw2mGZFNUkMkjdLG
         m8ixiiegG8hYnHJPjCG1r5Me3q9UrrGvWNKlagGJ+V+61t4Ua3rXndiCH1gV2uf9Cssw
         6YOQ==
X-Received: by 10.42.67.80 with SMTP id s16mr30760277ici.25.1432665077574;
 Tue, 26 May 2015 11:31:17 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 26 May 2015 11:31:17 -0700 (PDT)
In-Reply-To: <55635C84.7080108@gmail.com>
X-Google-Sender-Auth: FaIb3X3avCY6uoHl65V0vKbO9_8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269963>

[Re-sending this for on-list completeness. It was sent off-list
earlier when I was using an email client capable only of HTML
messages.]

On Mon, May 25, 2015 at 1:31 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> On 05/21/2015 08:01 PM, Eric Sunshine wrote:
>> On Thu, May 21, 2015 at 1:39 PM, S=C3=A9bastien Guimmara
>> <sebastien.guimmara@gmail.com> wrote:
>>>
>>> The ultimate goal is for "git help" to display common commands in
>>> groups rather than alphabetically. As a first step, define the
>>> groups in a new block, and then assign a group to each
>>> common command.
>>>
>>> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.co=
m>
>>> ---
>>> diff --git a/command-list.txt b/command-list.txt
>>> index 181a9c2..32ddab3 100644
>>> --- a/command-list.txt
>>> +++ b/command-list.txt
>>> @@ -1,3 +1,14 @@
>>> +# common commands are grouped by themes
>>> +# these groups are output by 'git help' in the order declared here=
=2E
>>> +# map each common command in the command list to one of these grou=
ps.
>>> +### common groups (do not change this line)
>>> +init         start a working area (see also: git help tutorial)
>>> +worktree     work on the current change (see also: git help everyd=
ay)
>>> +info         examine the history and state (see also: git help
>>> revisions)
>>> +history      grow, mark and tweak your common history
>>> +remote       collaborate (see also: git help workflows)
>>> +
>>> +# List of known git commands.
>>
>> This is odd. The above line was removed in 1/5 but then re-appears
>> here in 2/5. I think the intent is that it should remain removed.
>>
>>>   ### command list (do not change this line)
>>>   # command name                          category [deprecated] [co=
mmon]
>>>   git-add                                 mainporcelain common
>
> My mistake. This will be corrected in the next version. Thank you for=
 taking
> time to review this series.

Junio already made these corrections locally when he picked up the
series. Take a look at his 'pu' branch, and you'll find the series
there with the corrections[1]. Thus, no need to re-send.

[1]: Series currently merged into 'pu' at de905cf0.
