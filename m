From: Jacob Keller <jacob.keller@gmail.com>
Subject: =?UTF-8?Q?Re=3A_Exclude_a_file_from_a_pull_request=E2=80=8F?=
Date: Wed, 7 Oct 2015 17:30:07 -0700
Message-ID: <CA+P7+xqZwbLkLhG=1PvBXSRW_bJ_7CphTJDAY3Wrc1SyjCFsaA@mail.gmail.com>
References: <88A9B78851BE8145A87C05C88FC3ED840101DEB1@bsrspdag001.boursorama.fr>
 <87oaga8wq6.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rudy YAYON <Rudy.YAYON.ext@boursorama.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Oct 08 02:30:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjz6N-0001P7-Qd
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 02:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbbJHAa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 20:30:28 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33143 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbbJHAa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 20:30:27 -0400
Received: by iofh134 with SMTP id h134so41413642iof.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 17:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HfvogSthB/TAVnOWKb670pz8wToPZ7qwyyoNMBdAxvU=;
        b=HRZuM6JqvufwyxAVZIFYNYe9cYRvNPfCdSH4nzkfHPjhSRX6D+vVYdmJIT6zh1q4dm
         kmZ5CMpKbgA2w3OnbBFQrLQTV/HW7yZEGELnkIsYGF7twOOvOC2Umr0wQG1l3ypnfl27
         BwIK2ZlheSyC+uxTSKqM3ehisbEGEHH+1WvdR7NCIQLAXc1ERBiwJwVIrJ4pWcaJCqKw
         ZBWH/eGT5cDCPnrHriOH0Ilo5htIc61aV7VKA3f6oOByl6KAaxvzRdD2ogjfq0m2vmgQ
         PhvSBYK6W+JgFXHR0OkmAGSHOAnNNKfrWMburxUKBUdGkF+4Ni1smAEVk2dQVVIsjB0B
         Ssow==
X-Received: by 10.107.166.201 with SMTP id p192mr6239788ioe.0.1444264226527;
 Wed, 07 Oct 2015 17:30:26 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Wed, 7 Oct 2015 17:30:07 -0700 (PDT)
In-Reply-To: <87oaga8wq6.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279212>

On Wed, Oct 7, 2015 at 9:33 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Rudy YAYON <Rudy.YAYON.ext@boursorama.fr> writes:
>
>>   My concern is that one important file (Puppetfile) needs to be pushed to my remote repository so I can check the changes I commited.
>>   To do that, I need to commit changes (included to the Puppetfile) then I need to push it to the remote repository.
>>
>>   Once I want to merge these changes from a specific branch to the master branch, I do NOT want to include this file. In other words, I want to merge all files except the Puppetfile file.
>>
>>   What is the best way for you to do that?
>
> Create a branch that does not include the file.
>
> Andreas.
>

Why do the changes to "Puppetfile" need to be pushed to your github?
Just test it locally and then push it and pull-request a commit which
doesn't have those changes in it.

Regards,
Jake
