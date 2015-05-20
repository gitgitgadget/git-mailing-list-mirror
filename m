From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v9 2/5] command-list.txt: add the common groups block
Date: Wed, 20 May 2015 21:51:33 +0200
Message-ID: <555CE5C5.8000209@gmail.com>
References: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>	<1432149781-24596-3-git-send-email-sebastien.guimmara@gmail.com> <CAPig+cTM4L7Vt1gYb5zvAgt8hsqGQdLWigN_yB-VsWukNbt=zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 20 21:51:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvA1y-0001ZG-G7
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135AbbETTvi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 15:51:38 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36518 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbbETTvg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 15:51:36 -0400
Received: by wizk4 with SMTP id k4so167220417wiz.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=q1G2OpRmZEAOPF5Da9ZZ4iiBYtIx4+pDijFR6/5NZzM=;
        b=ZgqTLUXY5ztrg9/WiqCzJu2r4EiBMKR6KBxwc4qJVz903epTWUxXCN6srty/xzoesN
         Fn2TELbOOS3xKRsQ6F3+53su4dXwxPW1Apah8xuVpXl/VbCWWMBp7RKTxZa67g0yOam6
         A0/K6L5WCGGfIaTwVknvTU9rmZ0DK86yqPDh6y04uXcar6BVmrQFRdgqWP9HdmHDSgYh
         cRVay0PbpuI9peQdxtr268RSmF4mNJntu0eocXuybZDzNJoFLMf5ww6vq5sxM4HABtC2
         kO97NwXoYBkqkmi9bPaCIcaHhZ4MWBj/RY2OWQKxK9EVLSruS4zrIiTGHDEM+/sBxxDU
         GhTg==
X-Received: by 10.180.206.211 with SMTP id lq19mr45074591wic.26.1432151495779;
        Wed, 20 May 2015 12:51:35 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id r9sm28434824wjo.26.2015.05.20.12.51.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 12:51:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAPig+cTM4L7Vt1gYb5zvAgt8hsqGQdLWigN_yB-VsWukNbt=zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269511>



On 05/20/2015 09:48 PM, Eric Sunshine wrote:
> On Wed, May 20, 2015 at 3:22 PM, S=C3=A9bastien Guimmara
> <sebastien.guimmara@gmail.com> wrote:
>> The ultimate goal is for "git help" to display common commands in
>> groups rather than alphabetically. As a first step, define the
>> groups in a new block, and then assign a group to each
>> common command.
>>
>> Add a block at the beginning of command-list.txt:
>>
>>      init         start a working area (see also: git help tutorial)
>>      worktree     work on the current change (see also:[...]
>>      info         examine the history and state (see also: git [...]
>>      history      grow, mark and tweak your history
>>      remote       collaborate (see also: git help workflows)
>>
>> storing information about common commands group, then map each commo=
n
>> command to a group:
>>
>>      git-add          mainporcelain        common worktree
>>
>> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com=
>
>> ---
>>   command-list.txt | 50 ++++++++++++++++++++++++++++++--------------=
------
>>   1 file changed, 30 insertions(+), 20 deletions(-)
>
> Hmm, did your update to Documentation/technical/new-command.txt get
> lost? I don't see it any of the patches, but would have expected it t=
o
> be included in this patch which introduces the "common groups"
> section.
>

Ah, you're right. A commit got lost in the process. Will fix that. Than=
ks.

>> diff --git a/command-list.txt b/command-list.txt
>> index 609b344..c2bbdc1 100644
>> --- a/command-list.txt
>> +++ b/command-list.txt
>> @@ -1,3 +1,13 @@
>> +# common commands are grouped by themes output by 'git help'
>> +# map each common command in the command list to one of these group=
s.
>
> Discussed previously: It also would be a good idea to mention that th=
e
> order in which "git help" displays the groups themselves is the order
> they are declared here. Maybe just add one more line between the two
> you already have above:
>
>      # groups are output by 'git help' in the order declared here.
>

Indeed, I'll add the mention.

>> +### common groups
>
> In the block below, the "### command list" line is protected by a "#
> do not molest the next line" warning. Perhaps the same should be done
> here? Alternately, make them more compact by incorporating the
> warning:
>
>      ### common groups (do not change this line)
>      ...
>      ### command list (do not change this line)
>
> ?
>

Yes, it's better. I shall modify this.

>> +init         start a working area (see also: git help tutorial)
>> +worktree     work on the current change (see also: git help everyda=
y)
>> +info         examine the history and state (see also: git help revi=
sions)
>> +history      grow, mark and tweak your common history
>> +remote       collaborate (see also: git help workflows)
>> +
>> +# List of known git commands.
>>   # do not molest the next line
>>   ### command list
>>   # command name                          category [deprecated] [com=
mon]
