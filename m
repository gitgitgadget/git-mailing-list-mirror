From: Martin L Resnick <mresnick@bbn.com>
Subject: Re: ACLs for GIT
Date: Mon, 16 May 2011 09:22:31 -0400
Message-ID: <4DD12517.1000308@bbn.com>
References: <4DD02876.1040404@bbn.com> <20110515201608.GX6349@kiwi.flexilis.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "R. Tyler Croy" <tyler@monkeypox.org>
X-From: git-owner@vger.kernel.org Mon May 16 16:06:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLyRO-0004NY-A7
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 16:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461Ab1EPOG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 10:06:29 -0400
Received: from smtp.bbn.com ([128.33.0.80]:53230 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755303Ab1EPOG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 10:06:28 -0400
Received: from dhcp89-069-009.bbn.com ([128.89.69.9]:60628)
	by smtp.bbn.com with esmtps (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.74 (FreeBSD))
	(envelope-from <mresnick@bbn.com>)
	id 1QLxkl-00081R-Uy; Mon, 16 May 2011 09:22:31 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110515201608.GX6349@kiwi.flexilis.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173736>

Thanks for the reply.

But gitolite would only work to deny reads on a repository or ref basis
not a pathname level.


On 05/15/2011 04:16 PM, R. Tyler Croy wrote:
>
> On Sun, 15 May 2011, Martin L Resnick wrote:
>
>> Is anyone working on adding access control to GIT ?
>>
>> I'm looking for the Subversion equivalent of mod_authz_svn.
>> I need to restrict read access of ITAR documents that are
>> scattered throughout the source tree.
>> This restriction would need to deny fetch of the ITAR
>> documents yet allow fetch of any other files.
>>
>> Looking through the source code it would seem that
>> putting a hook call in the fetch-pack code would do it.
>
> It sounds like 'gitolite' might be what you're looking for:
> <https://github.com/sitaramc/gitolite>
>
> - R. Tyler Croy
> --------------------------------------
>      Code: http://github.com/rtyler
>   Chatter: http://identi.ca/agentdero
>            http://twitter.com/agentdero
