From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How to resolve conflict: Moved away vs. created new file with
 same   name
Date: Tue, 19 Jan 2010 15:55:28 +0100
Message-ID: <4B55C7E0.7030604@viscovery.net>
References: <4B559328.2010206@cedarsoft.com> <4B559DAB.9030605@viscovery.net> <4B55C481.90406@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schneider <mailings@cedarsoft.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 15:55:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXFUY-0005Nz-Ql
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 15:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090Ab0ASOzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 09:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986Ab0ASOzg
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 09:55:36 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24705 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab0ASOze (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 09:55:34 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NXFUO-0001Nw-VS; Tue, 19 Jan 2010 15:55:29 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A9B0E1660F;
	Tue, 19 Jan 2010 15:55:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B55C481.90406@cedarsoft.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137462>

Please keep the discussion on the list. I'm not your personal support dude.

Johannes Schneider schrieb:
> On 01/19/2010 12:55 PM, Johannes Sixt wrote:
>>> So I am trying to mimic the change in TopicA:
>>>
>>> cd client
>>> mkdir client3
>>> mv pom.xml client3
>>> mv src client3
>>> ...commit...
>>
>> Did you do this during the merge? If not, go back to TopicA and redo it;
>> then you avoid the conflict during the merge.
> 
> Yes, I have done this in TopicA *before* the merge. I knew that there
> will be conflicting directories and tried to clean that up before.
> 
>> During the merge without the fixup suggested above:
>>
>> git rm -f client/client3/pom.xml
>> git checkout TopicA -- client/pom.xml
>> git mv client/pom.xml client/client3/pom.xml
>> git checkout TopicB -- client/pom.xml
>>
>> but it leaves you with an ugly history, and it would be far better to fix
>> up TopicA before the merge.
> 
> Yep. I prefer a clean history ;-). So do you know how to solve that
> issue with a cleaned up TopicA branch?

I don't see an issue if you have cleaned up TopicA. Where is it? Did you
really do what you said you did?

-- Hannes
