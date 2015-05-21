From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Thu, 21 May 2015 10:43:55 -0700
Message-ID: <CAGZ79katx04bKiyyvS1JnzQ40G0dGO-yS+zYY4jQ62X4DpmbxA@mail.gmail.com>
References: <1432163517-22785-1-git-send-email-sbeller@google.com>
	<xmqqoaldkfmy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 19:44:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUVl-0002g7-B2
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 19:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326AbbEURn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 13:43:57 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33201 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbbEURn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 13:43:56 -0400
Received: by qkgv12 with SMTP id v12so61322311qkg.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 10:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Enompnm7bSsyEROjMuXMh0KGVqpY1lVPYrXd8295yg0=;
        b=knB4BSkkNYyzWGiqNE6sw0BHBztHPSqkDO6UI3991BAo5L/8vPCofDkYOMsaT7D115
         RJkMY539YmxW5pEobg/ox/XSrXAn1umQxeYmNuRdlYMHgl2CM6Lk44dg74xvWpUY5RFT
         s18lJbbzzRlVI1VAUf1G5r7l358aiJkoza0MYXs3WSvJtg3X9LsNaacfRVLiEG0jNcH7
         lka1vp5tVflmItHN649lMGAXTxU1snXn09JApVl7f1f5NaI+lauDIgYt7gSOZF2IEwgg
         czwNQsWtZklSu66CbgZCFvrQfGgbEGqOJZ+vq5mLH0iVlAtf30VkA5iTiPU19Lcior/1
         itBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Enompnm7bSsyEROjMuXMh0KGVqpY1lVPYrXd8295yg0=;
        b=Dm5I+NJRn97HMXYvbcvsiwZZyaRSQcAZ8Lc6qn3Hb4KqjHG0/+dNMQLqiELeQzHeca
         XJ/E9Fl7EB1HcsLxxhsY5951lilEWj03y7QTwXku89ZNt0S4NPoEcJBcfEs64Wc1HAuy
         9GNGITr8E1VE8USNFZdbBSgoE8kGGsOlNLpC+glpiKz364Sh7Ov8aXgZgEtqoE2b8H6v
         WwEP4qRcIESvJtwueH9udrSEzVdgyB3ue99NDN9UG3r4RHUU4IPGsDo3G+7mHa5kbJE5
         tJTOukFz5O6nF6t95giF137+XHGOGQL3pocG1ogx/OgIDIADd3uTzmrIZE1OkEpg8F33
         bNpQ==
X-Gm-Message-State: ALoCoQneEYPBH8KsPMkuJd0j/2iJvvlzb9COG8mxtA18GeBUR4rI7kmTnwyO8Dr/D0N6VmIFEWCs
X-Received: by 10.140.196.140 with SMTP id r134mr5513443qha.60.1432230235183;
 Thu, 21 May 2015 10:43:55 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Thu, 21 May 2015 10:43:55 -0700 (PDT)
In-Reply-To: <xmqqoaldkfmy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269627>

On Thu, May 21, 2015 at 10:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Reorder the paragraphs such that
>> the first short paragraph introduces the submodule concept,
>> the second paragraph highlights the usage of the submodule command,
>> the third paragraph giving background information,
>> and finally the fourth paragraph discusing alternatives such
>> as subtrees and remotes, which we don't want to be confused with.
>>
>> This ordering deepens the knowledge on submodules with each paragraph.
>> First the basic questions like "How/what" will be answered, while the
>> underlying concepts will be taught at a later time.
>
> Sounds good.
>
>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index 2c25916..6c38c0d 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -25,35 +25,12 @@ SYNOPSIS
>>
>>  DESCRIPTION
>>  -----------
>> -Submodules allow foreign repositories to be embedded within
>> -a dedicated subdirectory of the source tree, always pointed
>> -at a particular commit.
>> +Submodules allow other repositories to be embedded within
>> +a dedicated subdirectory of the source tree pointing
>> +at a particular commit in the other repository.
>
> Not a new problem, but I can misread this as if it requires the
> top-level superproject to have one single dedicated directory D to
> house all the foreign projects under it, D/project1, D/project2, ...

I agree, maybe we should reword the paragraphs themselves as well.

    Submodules allow you to keep another Git repository in a subdirectory
    of your repository. The other repository has its own history, which does not
    interfere with the history of the current repository. This can be used to
    have external dependencies such as libraries for example.

>
>> -This command will manage the tree entries and contents of the
>> -gitmodules file for you, as well as inspect the status of your
>> -submodules and update them.
>> +This command will manage the submodules for you, as well as
>> +inspect the status of your submodules and update them.
>
> Not a new problem, but does the command really "manage them for
> you"?  I view it more like "You can use this command to manage,
> inspect and update the submodules".

I agree.
