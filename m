From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3] git-p4: add option to preserve user names
Date: Sun, 08 May 2011 11:58:30 +0100
Message-ID: <4DC67756.3090002@diamand.org>
References: <1304577819-703-1-git-send-email-luke@diamand.org> <7vy62k2z8j.fsf@alter.siamese.dyndns.org> <4DC38657.7020703@diamand.org> <20110506235912.GA11842@arf.padd.com> <7viptmup53.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 12:58:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ1hM-0006Xz-Tu
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 12:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab1EHK6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 06:58:35 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34255 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab1EHK6f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 06:58:35 -0400
Received: by wwa36 with SMTP id 36so4855912wwa.1
        for <git@vger.kernel.org>; Sun, 08 May 2011 03:58:34 -0700 (PDT)
Received: by 10.227.182.2 with SMTP id ca2mr5987230wbb.89.1304852313859;
        Sun, 08 May 2011 03:58:33 -0700 (PDT)
Received: from [86.30.143.167] (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id b6sm2792073wby.11.2011.05.08.03.58.31
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 03:58:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Icedove/3.1.9
In-Reply-To: <7viptmup53.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173091>

On 07/05/11 23:22, Junio C Hamano wrote:
> Pete Wyckoff<pw@padd.com>  writes:
>
>> luke@diamand.org wrote on Fri, 06 May 2011 06:25 +0100:
>>> On 06/05/11 06:07, Junio C Hamano wrote:
>>>> Luke Diamand<luke@diamand.org>   writes:
>>>>
>>>>> This is version 3 of my patch.
>>>>

<snip>

>
> So the only thing lacking at this point is the commit log message?
>
> I am not sure if the "actual user is luke" message you give when (and only
> when) preserveUser is used is a good "reminder".  Isn't it that the user
> needs reminder when the user should have used but forgot to use this
> option, not the other way around like your patch does?

I put that in so that when I'm at the point where I'm about to submit to 
Perforce I know that git-p4 hasn't forgotten that it's going to patch up 
the user name, and hasn't got it horribly wrong.

i.e. to reassure me it's not about to mess up Perforce.

>
> I suspect that the message would show an unexpected name only when the new
> codepath is buggy or the P4 changes the code is interacting are formatted
> in ways that the new codepath is not expecting (well, they amount to the
> same thing after all, no?),

Exactly.

(The submit template does have a userid field in it, but this is always 
*your* userid, which I thought might be a bit confusing. Hence the message).

> and having such a message may prevent users
> from submitting the changeset under an incorrect name, but at that point
> what recourse do they have?

Apart from not submitting the changelist, none.
>
> It looks to me that the message is not helping the users, even though it
> may help as a debugging aid for git-p4 developers.

Should I just remove it?

I guess it only adds a small amount of information which could be 
explained in the instructions.

Regards!
Luke
