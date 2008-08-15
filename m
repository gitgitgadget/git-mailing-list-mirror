From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Fix t3700 on filesystems which do not support question marks in names
Date: Fri, 15 Aug 2008 01:23:40 -0700
Message-ID: <333CFE63-8410-45F5-9483-4AC6FFEB57F3@sb.org>
References: <81b0412b0808150011r534d8453yab2a5c42b255657f@mail.gmail.com> <7vproabvcr.fsf@gitster.siamese.dyndns.org> <81b0412b0808150023sd30559fi68ff1e439013f26e@mail.gmail.com> <81b0412b0808150032o20f69346jb4f573b78cd11f2b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 10:24:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTuc5-0007zT-D3
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 10:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbYHOIXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 04:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbYHOIXo
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 04:23:44 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:37486 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753422AbYHOIXm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Aug 2008 04:23:42 -0400
Received: from [192.168.1.101] (c-76-103-51-229.hsd1.ca.comcast.net [76.103.51.229])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 9A303EEFF6;
	Fri, 15 Aug 2008 01:23:46 -0700 (PDT)
In-Reply-To: <81b0412b0808150032o20f69346jb4f573b78cd11f2b@mail.gmail.com>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92465>

Wow, trying to use git-am to apply this patch bus errors. This isn't  
good. Specifically, git mailinfo bus errors when the email is piped to  
it. Curiously, the attached "patch" is actually another MIME-formatted  
message with an inline patch. And I can pipe this "patch" to git-am  
and that works. How did you generate this message?

In any case, the patch looks good to me.

Signed-off-by: Kevin Ballard <kevin@sb.org>

-Kevin Ballard

On Aug 15, 2008, at 12:32 AM, Alex Riesen wrote:

> Use square brackets instead.
>
> And the prominent example of the deficiency are, as usual, the  
> filesystems
> of Microsoft house.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> 2008/8/15 Junio C Hamano <gitster@pobox.com>:
>>>> And the prominent example of the deficiency are, as usual, the  
>>>> filesystems
>>>> of Microsoft house.
>>>
>>> Can other glob specials such as '*' or '[' be used instead of  
>>> skipping the
>>> test?
>>
>> Ah... The brackets are allowed.
>
> Sorry, should have thought of it.
>
> t/t3700-add.sh |    8 ++++----
> 1 files changed, 4 insertions(+), 4 deletions(-)
> <0001-Fix-t3700-on-filesystems-which-do-not-support-questi.patch>

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
