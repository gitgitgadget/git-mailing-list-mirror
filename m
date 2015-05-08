From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Fri, 08 May 2015 22:08:13 +0200
Message-ID: <554D17AD.9070306@gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>	<554B30D5.3050909@emmajane.net> <554CFEC3.5030105@gmail.com> <xmqqh9rmlwut.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Emma Jane Hogbin Westby <emma.westby@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 22:08:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqoZL-00084w-Ag
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 22:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbbEHUIT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 16:08:19 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:32871 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbbEHUIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 16:08:16 -0400
Received: by wgin8 with SMTP id n8so81995379wgi.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 13:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6qIUhJmZfb6s5SZjXXQEvK8m58JNvHALcn0vIEfLj2k=;
        b=1B/pzV7/J6cRdG4qxyQlT8wv+W9C2+le7zVEdDL1zA+1sQtIY0J+dqXh0WYgQAuE6B
         FlJwLaNbrCKL3z8F8FhtUL3IKRRPmqswAgMHy6+O1oIl6xTeWugqd6BxVxysikTKeF3O
         g/m4Zq/3zEZ2M6y0atgCFai/8PlbyOBvlXAr34RO0qwrA6I300itdLI7VFKELAc2Jo3Q
         nWEJKfcp3NLBStsP1Ks+ahJTdW25c8OvHwAqPrGMTOxjyRrnBUVSbypzkwizt9c/2aa0
         LejJprZTK87dNaV3Uym/cZaZwO38tTZ/LSSPzPKXnspF0yzedp4iDF5aq3pmSKWbTz6u
         cJcA==
X-Received: by 10.194.57.40 with SMTP id f8mr10692307wjq.86.1431115695331;
        Fri, 08 May 2015 13:08:15 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id kc4sm9885229wjc.2.2015.05.08.13.08.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 13:08:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqh9rmlwut.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268656>

On 05/08/2015 08:58 PM, Junio C Hamano wrote:
> S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:
>
>> On 05/07/2015 11:31 AM, Emma Jane Hogbin Westby wrote:
>>
>>>> The most commonly used git commands are:
>>>>
>>>>      * starting a working area:
>>>>         clone      Clone a repository into a new directory
>>>>         init       Create an empty Git repository or reinitialize =
[...]
>>>>
>>>>      * working on the current change:
>>>>         add        Add file contents to the index
>>>>         reset      Reset current HEAD to the specified state
>>> I could not live without status at this stage, and status always te=
lls
>>> me what I should do next. I'm tempted to see it up here instead...
>>
>> The layout was not designed to be workflow oriented (even if it appe=
ars
>> so), but rather theme oriented.
>
> I tend to agree with Emma here; even if your original ordering was
> not using the workflow as the grouping criterion, that is something
> that can easily be fixed, I would think.
>
> After all, the very original did not categorize and sorted
> alphabetically, so there is no room for the "we chose to be
> theme-oriented (I am not sure what it means, though) and a major
> redesign at this point will confuse users" kind of resistance to
> come into the picture.  At least not yet.
>
> Thanks.
>

Exactly. The new version will be workflow-oriented.

By "theme-oriented", I mean that the group order does not necessarily
follow a "typical workflow" chronological order, even though it was
heavily implied. I should emphasize this "workflow" thing in the next
patch.
