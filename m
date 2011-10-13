From: Gioele Barabucci <gioele@svario.it>
Subject: Re: Git attributes ignored for root directory
Date: Thu, 13 Oct 2011 11:49:04 +0100
Message-ID: <4E96C220.5050601@svario.it>
References: <4E8B55FB.1050203@svario.it> <4E8C481A.1070808@alum.mit.edu> <7vd3eb8hkb.fsf@alter.siamese.dyndns.org> <4E961626.4030201@alum.mit.edu> <7vfwix7qk2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 12:49:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REIqg-0008P7-51
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 12:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685Ab1JMKtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 06:49:09 -0400
Received: from begonia.svario.it ([91.213.195.127]:41934 "EHLO
	begonia.svario.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab1JMKtI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 06:49:08 -0400
Received: from [192.168.0.12] (5ad45630.bb.sky.com [90.212.86.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: gioele@svario.it)
	by begonia.svario.it (Postfix) with ESMTPSA id 8C72F2CF3C;
	Thu, 13 Oct 2011 10:49:03 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110923 Thunderbird/7.0
In-Reply-To: <7vfwix7qk2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183467>

On 13/10/2011 00:12, Junio C Hamano wrote:
> Suppose you have a directory "foo" and want to say "I want to ignore
> everything in that directory". You would say "foo/" in .gitignore in the
> higher level and you are happy.
>
> How would you say the same thing if the directory to be ignored weren't
> "foo" but at the top-level of the working tree? There is no such level
> higher than the top-level where you can say "<the name of your project>/"
> in its .gitignore file.

Shouldn't `/.` or `/./` work?

I see that `/*/` in `.gitignores` successfully ignores all the 
non-hidden directories in the root project directory. Another accidental 
success? :)

-- 
Gioele Barabucci <gioele@svario.it>
