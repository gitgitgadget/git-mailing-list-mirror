From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2013, #09; Mon, 29)
Date: Sat, 03 Aug 2013 09:37:42 -0400
Message-ID: <51FD07A6.9040902@gmail.com>
References: <7vk3k9yol3.fsf@alter.siamese.dyndns.org> <51F94DFD.5020101@ramsay1.demon.co.uk> <7v4nbav9ys.fsf@alter.siamese.dyndns.org> <51FACA67.8090207@ramsay1.demon.co.uk> <7vtxj9qfnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	tboegi@web.de, mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 15:38:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5c24-0008PP-MM
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 15:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab3HCNhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 09:37:46 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:57822 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab3HCNhp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 09:37:45 -0400
Received: by mail-qc0-f180.google.com with SMTP id j10so860611qcx.25
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 06:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=/C9Ej6D8wM5t1OnmXegnovrRRVNJZ74zrEmGNJl72fY=;
        b=Qd5xaVnwc482zEnT8z/WFomwqT3b6HPKqRkwpTVfTC58CzuMMiIVJL0NptQzc/69GU
         kjskYsEjln/32wTv+BAMqE0vh8Goy6aboR4xEoBflqsZZ/IoEsxq5nhWtGSPUkTppFKi
         ZlhfpMcJlsFX5Bs5szpiRvLJTNu4I1XRfgAq2hOjGbocX4HahY9VwPRoEvh1BrIo0ls1
         Owdz9iXV14bsbPGWYHSZRSOt7P50tQ6XOEkaufTK+aapAx+zwxqKPmkpdQ8aeaORNhYD
         +k/bCklWox1wA9IEHVfhpmjfQ7hr3zo3OhkfVfQF4mqbe16eBb2r7OKzjMC7JZHIrgfA
         dEKw==
X-Received: by 10.224.11.194 with SMTP id u2mr17374296qau.18.1375537064786;
        Sat, 03 Aug 2013 06:37:44 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id j11sm236664qaa.7.2013.08.03.06.37.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 06:37:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <7vtxj9qfnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231595>

On 08/01/2013 05:12 PM, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>
>> Junio C Hamano wrote:
>>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>>
>>>>>   I am personally in favor of this simpler solution.  Comments?
>>>> I had expected this to me marked for 'master'.
>>>>
>>>> Has this simply been overlooked, or do you have reservations about
>>>> applying this patch?
>>> I am just being careful and do want to keep it cooking in 'next'
>>> during the feature freeze.  The more users work with 'next' (not
>>> "work *on* 'next'"), the more confidence we would be with, and
>>> hopefully this can be one of the topis that graduate early after
>>> the 1.8.4 release.
>> Hmm, this patch is a bug-fix for a bug that (currently) will be
>> _introduced_ by v1.8.4.
> OK, let's merge it then.  Thanks for being patient with me.
>
>> Do you want me to try and find a different bug-fix for v1.8.4?
>> (Although that would most likely be more risky than simply taking
>> this patch! ;-) ).
> Absolutely not, and I 100% agree with you.
>
I have been using this patch since Ramsey first sent it, have noticed no 
trouble over that time but all of my work is with filemode=true (has 
been since I started using git as Cygwin is a secondary platform for me 
and interoperability with repos on Linux is an absolute requirement).

Mark
