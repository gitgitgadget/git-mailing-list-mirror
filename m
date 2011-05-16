From: Martin L Resnick <mresnick@bbn.com>
Subject: Re: ACLs for GIT
Date: Mon, 16 May 2011 11:36:08 -0400
Message-ID: <4DD14468.1000401@bbn.com>
References: <4DD02876.1040404@bbn.com> <20110515201513.GA27758@jpl.local> <4DD1250D.50005@bbn.com> <4DD143CA.3000700@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Magnus_B=E4ck?= <magnus.back@sonyericsson.com>,
	git@vger.kernel.org
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Mon May 16 17:36:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLzqE-0002vo-3s
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 17:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213Ab1EPPgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 11:36:12 -0400
Received: from smtp.bbn.com ([128.33.0.80]:56573 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755999Ab1EPPgL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 11:36:11 -0400
Received: from dhcp89-069-009.bbn.com ([128.89.69.9]:59057)
	by smtp.bbn.com with esmtps (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.74 (FreeBSD))
	(envelope-from <mresnick@bbn.com>)
	id 1QLzq5-000A90-AH; Mon, 16 May 2011 11:36:09 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DD143CA.3000700@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173742>

Wonderful. Thanks a lot.

That's a great idea to use submodules WITH encrypting the source.

I like it! I'm going to propose we use it.

Thanks for the suggestion.

On 05/16/2011 11:33 AM, Phil Hord wrote:
> On 05/16/2011 09:22 AM, Martin L Resnick wrote:
>> Thanks Mangus.
>>
>> You pointed out some hurdles I'll have to think about
>> (blocked files not matching the SHA and so can't be committed).
>>
>> As to why I want to do this consider NSA non-export rules.
>> Our application would be built with NSA encryption
>> but we have foreign nationals working on the code
>> and so they are not permitted to see that part.
>> The makefiles look to see if the NSA encryption code file
>> is there and link it in. If not a stub is used.
>
> We use submodules for this same need here.  If the submodule is loaded,
> the code is used from that.  If not, pre-built binaries are used
> instead.  These could be stubs.
>
> When we share code with outside partners, we give them access only to
> the modules they need.
>
> We further guard the code in the submodule by PGP-encrypting the source
> files and storing them in the repository (as binaries).  This practice
> lets us be more free with the repository and not worry so much that it
> may be cloned well out of our control.  Storing code as shrouded
> binaries negates much of git's power, but only for this one submodule.
> Our other submodules are still quite git-friendly.
>
> Phil
>
>
