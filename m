From: David Lang <david@lang.hm>
Subject: Re: Git chokes on large file
Date: Wed, 28 May 2014 12:09:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1405281205410.32611@nftneq.ynat.uz>
References: <201405271647.s4RGlDJc024596@hobgoblin.ariadne.com> <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com> <201405281815.s4SIF5hF025886@hobgoblin.ariadne.com> <alpine.DEB.2.02.1405281121200.32611@nftneq.ynat.uz>
 <xmqqmwe1d991.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Dale R. Worley" <worley@alum.mit.edu>,
	Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 21:09:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpjEH-0008Hk-Al
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 21:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbaE1TJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 15:09:33 -0400
Received: from mail.lang.hm ([64.81.33.126]:44201 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbaE1TJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 15:09:33 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s4SJ9SCr014116;
	Wed, 28 May 2014 12:09:28 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <xmqqmwe1d991.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250318>

On Wed, 28 May 2014, Junio C Hamano wrote:

> David Lang <david@lang.hm> writes:
>
>> On Wed, 28 May 2014, Dale R. Worley wrote:
>>
>>> It seems that much of Git was coded under the assumption that any file
>>> could always be held entirely in RAM.  Who made that mistake?  Are
>>> people so out of touch with reality?
>>
>> Git was designed to track source code, there are warts that show up in
>> the implementation when you use individual files >4GB
>>
>> such files tend to also not diff well. git-annex and other offshoots
>> hae methods boled on that handle such large files better than core git
>> does.
>
> Very well explained, but perhaps you went a bit too far, I am
> afraid.
>
> The fact that our primary focus being the source code does not at
> all mean that we are not interested to enhance the system to also
> cater to those who want to put materials that are traditionally
> considered non-source to it, now that we have become fairly good at
> doing the source code.

Correct, I didn't mean to imply that git is only for source files, just noting 
it's origional purpose.

now that there are multiple different add-ons for git to handle large files in 
different ways, I'm watching to see what can get folded back into the core.

David Lang
