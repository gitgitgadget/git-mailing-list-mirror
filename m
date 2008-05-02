From: Kevin Ballard <kevin@sb.org>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 02:04:01 -0400
Message-ID: <8C3474E2-3A4F-44E8-B301-C36939C7BA11@sb.org>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <7vlk2txn8n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 08:04:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JroO5-0006aG-D5
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 08:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbYEBGEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 02:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbYEBGEF
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 02:04:05 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:37527 "EHLO
	randymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753891AbYEBGEE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2008 02:04:04 -0400
Received: from [192.168.0.215] (c-24-91-11-245.hsd1.nh.comcast.net [24.91.11.245])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a12.g.dreamhost.com (Postfix) with ESMTP id 9AC54A886A;
	Thu,  1 May 2008 23:04:02 -0700 (PDT)
In-Reply-To: <7vlk2txn8n.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80960>

On May 2, 2008, at 1:56 AM, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> On Fri, May 02, 2008 at 01:41:05AM -0400, Kevin Ballard wrote:
>>
>>> Does anybody have any comments or opinions about this either way?
>>
>> I agree with you; I don't like it at all.
>
> I do not care either way.  As I do not have LESS defined in my  
> environment
> (which makes git use its built-in that contains FX), I actually never
> noticed the difference before or after that patch.

Even if I put FX into LESS (I have it set normally so it contains R),  
it still doesn't behave correctly. I compulsively clear my terminal  
screen whenever I don't need the current contents, but with FX in  
LESS, `git status` throws the output at the bottom of my terminal,  
leaving a lot of blank space at the top. This is extremely irritating  
to me.

Is there any good reason to make git-status use the pager? The output  
is very rarely long enough to warrant it, and if I need a pager I can  
always just pipe it to less myself.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
