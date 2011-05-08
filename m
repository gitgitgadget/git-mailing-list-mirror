From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3] git-p4: add option to preserve user names
Date: Sun, 08 May 2011 21:35:28 +0100
Message-ID: <4DC6FE90.6040406@diamand.org>
References: <1304577819-703-1-git-send-email-luke@diamand.org> <7vy62k2z8j.fsf@alter.siamese.dyndns.org> <4DC38657.7020703@diamand.org> <20110506235912.GA11842@arf.padd.com> <7viptmup53.fsf@alter.siamese.dyndns.org> <4DC67756.3090002@diamand.org> <7voc3dt7wq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 22:35:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJAhW-0000mg-MK
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 22:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab1EHUfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 16:35:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56638 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab1EHUfd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 16:35:33 -0400
Received: by wya21 with SMTP id 21so3461660wya.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 13:35:32 -0700 (PDT)
Received: by 10.227.10.141 with SMTP id p13mr507139wbp.75.1304886932145;
        Sun, 08 May 2011 13:35:32 -0700 (PDT)
Received: from [86.30.143.167] (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id b6sm3054409wby.62.2011.05.08.13.35.29
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 13:35:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Icedove/3.1.9
In-Reply-To: <7voc3dt7wq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173179>

On 08/05/11 18:32, Junio C Hamano wrote:
> Luke Diamand<luke@diamand.org>  writes:
>
>>> It looks to me that the message is not helping the users, even though it
>>> may help as a debugging aid for git-p4 developers.
>>
>> Should I just remove it?
>>
>> I guess it only adds a small amount of information which could be
>> explained in the instructions.
>
> I was trying to get a feel of how much thinking went behind that message,
> by suggesting a possible improvement to help users who forgot to pass the
> new option when they might have wanted to, instead of just assuring users
> who did pass the option when the command did the right thing for them.
>
> People learn to quickly ignore repeated and regular messages. They will
> learn that they will get that message whenever they pass the new option,
> and they learn that most of the time it says what they wanted, and will
> easily miss when the username you put in the message is different from
> what they expect.
>
> In our commit template, we say "# Author: author name" when and only when
> it is different from you. Most of the time, you are committing your own
> commit, so this line is _unusual_ and that is very much deliberate.
>
> If you do not think of a good way to improve the "help" part of the patch,
> that is Ok. We are still making progress by giving a functionality that
> has been missing.
>
> To remove or to keep, I am less qualified to judge than either you or
> Pete. I'm not the primary audience. If you think it helps users, leave it
> in. Otherwise remove.

Per your suggestion, I'm working on a pair of patches that are:

(a) the previous patch ("minor improvements"), but without the warning. 
git-p4.txt is updated to make it clearer what to expect.

(b) a second patch that puts a warning in the commit template if you are 
going to lose authorship information. The warning is disableable  via 
git-config.

Regards!
Luke
