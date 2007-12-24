From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] Document git rev-list --first-parent
Date: Mon, 24 Dec 2007 10:36:37 +0200
Message-ID: <476F6F95.1030506@qumranet.com>
References: <1198484450-16454-1-git-send-email-avi@qumranet.com> <7v3atstry4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 09:37:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6io4-0006IE-2k
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 09:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbXLXIgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 03:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbXLXIgj
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 03:36:39 -0500
Received: from il.qumranet.com ([82.166.9.18]:59825 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbXLXIgi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 03:36:38 -0500
Received: from balrog.qumranet.com (balrog.qumranet.com [10.0.57.202])
	by il.qumranet.com (Postfix) with ESMTP id 39373A0009;
	Mon, 24 Dec 2007 10:36:37 +0200 (IST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7v3atstry4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69206>

Junio C Hamano wrote:
> Avi Kivity <avi@qumranet.com> writes:
>
>   
>> Document git rev-list's --first-parent option.  Documentation taken from
>> git log.
>> ...
>> +--first-parent::
>> +	Follow only the first parent commit upon seeing a merge
>> +	commit.  This  option gives a better overview of the
>> +	evolution of a particular branch.
>> +
>>     
>
> I am afraid that this description is not sufficient.  The
> history given by --first-parent is useful only in a very limited
> use case, and the user needs to be aware of it.
>   

I don't know which use case you are referring to; I can describe my own:

I have a post-receive hook which sends all patches since the last push.  
To avoid sending the constituent commits of a pull, I use --first-parent 
to throw away anything I did not commit directly.

[Initially I used ^origin to cancel out these merges, but that failed as 
soon as I merged from some other branch]

I'm not sure this is what you meant.  Let me know, and I will update the 
patch.

-- 
error compiling committee.c: too many arguments to function
