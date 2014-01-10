From: Enno Weichert <enno.weichert@gmail.com>
Subject: Re: Subject: Something like cat-file for the index?
Date: Fri, 10 Jan 2014 15:27:31 +0100
Message-ID: <CABtFQN4q9un81W3G-o7tbG3-LUSEf2YdP0e9zP84JGYu6qwOfw@mail.gmail.com>
References: <CABtFQN6n_FKTfGt1ubkL51t8n_iJ0vcYW4ZEYLOkAsFNCq0GQw@mail.gmail.com>
	<871u0g2dtn.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 10 15:27:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1d3j-0000xt-Ey
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 15:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755686AbaAJO1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 09:27:34 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:51142 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbaAJO1c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 09:27:32 -0500
Received: by mail-ie0-f178.google.com with SMTP id lx4so5187517iec.37
        for <git@vger.kernel.org>; Fri, 10 Jan 2014 06:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SkY31M7TKBEzxdGqNCpHdezS1gMQOx4HPOfHhv3twcY=;
        b=SKP+NYVswQL3R8x2SsEdLB5vwFb6TdDB9Dt53ZkQtTtq3avd7IPtVYsxj5IfEkZCWv
         zyM7GGr4KKxXbavG7EhDZH9/Ywbv8XP6+VPWI89nGGJkofposd3groR0FcCCI+mjW1e3
         TCVELhaB8kYXgFM7Z0xKR2CFQAONwQE53t4J7kN0+06uCv+/F26IcbxBfuiINWHuAJL5
         0EiG87T9wDSLsS9bFTQPRfibQ2DDx58SCnPL8tYnnQwekmMyVkbwp3rr57mvmMbhvBIW
         nCiOyiTHrlJbN5BVbkHhJjJJE0NvASLguqE78oDprxC/6tbPFLIO+oH7CWKM5DXSYc2C
         GBAA==
X-Received: by 10.50.159.194 with SMTP id xe2mr3693491igb.13.1389364051113;
 Fri, 10 Jan 2014 06:27:31 -0800 (PST)
Received: by 10.64.17.233 with HTTP; Fri, 10 Jan 2014 06:27:31 -0800 (PST)
In-Reply-To: <871u0g2dtn.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240304>

Thank you :)

On 1/10/14, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> Hi,
>
> Enno Weichert <enno.weichert@gmail.com> writes:
>> Hi,
>>
>> I'd like to have a more technical look into the index file and what/how
>> it
>> stores data; call it educational spelunking.
>>
>> I know the index-format.txt but I'd really like to save me the work to
>> implement a pretty-printed output based on it.
>> I know ls-files but that's obviously not the whole thing.
>>
>> So: is there something like cat-file, that basically gives me a readable
>> version of the information (version number and all...) in the index
>> already
>> implemented or did nobody care until now?
>
> You can use `git ls-files --debug` and `git ls-files --stage` to get all
> the information about the files in the index.  The meaning of the flags
> is the only thing that's not shown by the command, and I don't think
> there is a tool yet to examine them.
>
> The undocumented --resolve-undo flag to git ls-files shows you the
> resolve undo data that is stored in the index.
>
> If you build git yourself, the `test-dump-cache-tree` helper can be used
> to show all information about the cache-tree that is stored in the
> index.
>
> The you can get the version of the index either by using
> `test-index-version` when you build git yourself, or by using `file
> .git/index`, which in addition will give you the number of entries that
> are in the index.
>
> --
> Thomas
>
