From: Johannes Schneider <mailings@cedarsoft.com>
Subject: Re: How to resolve conflict: Moved away vs. created new file with
 same   name
Date: Tue, 19 Jan 2010 17:46:37 +0100
Message-ID: <4B55E1ED.7090100@cedarsoft.com>
References: <4B559328.2010206@cedarsoft.com> <4B559DAB.9030605@viscovery.net> <4B55C481.90406@cedarsoft.com> <4B55C7E0.7030604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 17:46:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXHE4-0008Fc-LB
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 17:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab0ASQqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 11:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754581Ab0ASQqk
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 11:46:40 -0500
Received: from hosting.cedarsoft.com ([188.40.238.168]:33842 "EHLO
	cedarsoft.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754563Ab0ASQqj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 11:46:39 -0500
Received: from [192.168.0.36] (HSI-KBW-095-208-171-090.hsi5.kabel-badenwuerttemberg.de [95.208.171.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by cedarsoft.eu (Postfix) with ESMTP id 5F38C10CBE5E
	for <git@vger.kernel.org>; Tue, 19 Jan 2010 17:47:14 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091215 Lightning/1.0b2pre Shredder/3.0
In-Reply-To: <4B55C7E0.7030604@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137472>

On 01/19/2010 03:55 PM, Johannes Sixt wrote:
> Please keep the discussion on the list. I'm not your personal support dude.

Sorry, unintentional. TB3 has a menu entry called "reply to list" that 
obviously does not what I expected from...

>
> Johannes Schneider schrieb:
>> On 01/19/2010 12:55 PM, Johannes Sixt wrote:
>>>> So I am trying to mimic the change in TopicA:
>>>>
>>>> cd client
>>>> mkdir client3
>>>> mv pom.xml client3
>>>> mv src client3
>>>> ...commit...
>>>
>>> Did you do this during the merge? If not, go back to TopicA and redo it;
>>> then you avoid the conflict during the merge.
>>
>> Yes, I have done this in TopicA *before* the merge. I knew that there
>> will be conflicting directories and tried to clean that up before.
>>
>>> During the merge without the fixup suggested above:
>>>
>>> git rm -f client/client3/pom.xml
>>> git checkout TopicA -- client/pom.xml
>>> git mv client/pom.xml client/client3/pom.xml
>>> git checkout TopicB -- client/pom.xml
>>>
>>> but it leaves you with an ugly history, and it would be far better to fix
>>> up TopicA before the merge.
>>
>> Yep. I prefer a clean history ;-). So do you know how to solve that
>> issue with a cleaned up TopicA branch?
>
> I don't see an issue if you have cleaned up TopicA. Where is it? Did you
> really do what you said you did?
>
> -- Hannes
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
