From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11 2/5] command-list.txt: add the common groups block
Date: Tue, 26 May 2015 12:13:27 -0700
Message-ID: <xmqqwpzvjgo8.fsf@gitster.dls.corp.google.com>
References: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>
	<1432229962-21405-3-git-send-email-sebastien.guimmara@gmail.com>
	<CAPig+cRciCgBZyuT4fz0JZLY9SRmODaXq=gvsimVQ7sdt+AzcA@mail.gmail.com>
	<55635C84.7080108@gmail.com>
	<CAPig+cRPE30=euNYMEek4h8WgfMVFZKgxTqD8=L6BE11FAs8YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?S=C3=A9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 26 21:13:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxKIC-0003zE-4y
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 21:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbbEZTNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 15:13:31 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36908 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbbEZTNa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 15:13:30 -0400
Received: by igbsb11 with SMTP id sb11so61331382igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=LbNdyWv+4f2/d8gcbAXp+2/HCht3sikXKnPT4CL0Z60=;
        b=M/uonQ3XqILyd5D6BzNkUzzqLdIZW1f5pv3yfgE6uRP38ixGfBxF0D9snJWSDqoqcy
         qf0G9Ouml2zhiRVpMKoK7FsgqRjHcS1NFKs7eIqx6C+ZlYgrD128/i+7XpQGz6rD2MOc
         Tj8vRVS6vpNW16bl/rpeDvqxNWUUxILVFwyCaapN6ALHJ84Zxn6QEuwI4joDNPJAwilr
         JiX5b6IE2gBn6JQ6z0PLhtU5J3u+oEy/YMMu5aDoPXlfzVDP9aPTXq2o3KJ3oCS+pfy4
         +Iz1U/192CAxHhUASWlRX85a3kKHmWKBf9jGbpCg+VT0L1CKACFCq9BGeB9L6SS3JLGe
         X5dg==
X-Received: by 10.42.88.197 with SMTP id d5mr31782416icm.44.1432667610074;
        Tue, 26 May 2015 12:13:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id q78sm11654255ioe.9.2015.05.26.12.13.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 12:13:29 -0700 (PDT)
In-Reply-To: <CAPig+cRPE30=euNYMEek4h8WgfMVFZKgxTqD8=L6BE11FAs8YA@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 26 May 2015 14:31:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269966>

Eric Sunshine <sunshine@sunshineco.com> writes:

>>>> +history      grow, mark and tweak your common history
>>>> +remote       collaborate (see also: git help workflows)
>>>> +
>>>> +# List of known git commands.
>>>
>>> This is odd. The above line was removed in 1/5 but then re-appears
>>> here in 2/5. I think the intent is that it should remain removed.
>>>
>>>>   ### command list (do not change this line)
>>>>   # command name                          category [deprecated] [common]
>>>>   git-add                                 mainporcelain common
>>
>> My mistake. This will be corrected in the next version. Thank you for taking
>> time to review this series.
>
> Junio already made these corrections locally when he picked up the
> series. Take a look at his 'pu' branch, and you'll find the series
> there with the corrections[1]. Thus, no need to re-send.
>
> [1]: Series currently merged into 'pu' at de905cf0.

Yeah, resurrecting "List of known git commands." does look somewhat
strange, but looking at what this step does, especially this bit:

> diff --git a/command-list.txt b/command-list.txt
> index 181a9c2..32ddab3 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -1,3 +1,14 @@
> +# common commands are grouped by themes
> +# these groups are output by 'git help' in the order declared here.
> +# map each common command in the command list to one of these groups.
> +### common groups (do not change this line)
> +init         start a working area (see also: git help tutorial)
> +worktree     work on the current change (see also: git help everyday)

I do not think we would terribly mind an introductory comment that
applies to the next "###" block before it, e.g.

    # list of known git commands; ordered alphabetically
    # for easy spotting
    ### command list (do not change this line)

For some reason the patch seems to want to spell that comment in all
lowercase, so I just imitated it here.

In any case, if somebody wants to add such a comment there for
symmetry, that can be done as a follow-up patch after dust from
these patches settles, I think.  Let's have these 5 patches graduate
to 'next' without further bikeshedding ;-)
