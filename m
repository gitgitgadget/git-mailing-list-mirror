From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: sys/param.h
Date: Wed, 19 Dec 2012 21:49:42 -0500
Message-ID: <50D27CC6.3000203@gmail.com>
References: <20121217213730.GA17212@ftbfs.org> <50D02B9A.1040906@viscovery.net> <7vobhrgupr.fsf_-_@alter.siamese.dyndns.org> <CABPQNSZQk6hHm-dWqFFQf0HF34Mvbjc8-mgzCr=G0zbBKiYUvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 03:50:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlWD6-0003Bn-0U
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 03:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab2LTCty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 21:49:54 -0500
Received: from plane.gmane.org ([80.91.229.3]:54622 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975Ab2LTCtx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 21:49:53 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TlWCz-0003A5-EW
	for git@vger.kernel.org; Thu, 20 Dec 2012 03:50:05 +0100
Received: from pool-173-79-102-236.washdc.fios.verizon.net ([173.79.102.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 03:50:05 +0100
Received: from mlevedahl by pool-173-79-102-236.washdc.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 03:50:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-173-79-102-236.washdc.fios.verizon.net
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CABPQNSZQk6hHm-dWqFFQf0HF34Mvbjc8-mgzCr=G0zbBKiYUvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211871>

On 12/19/2012 02:59 AM, Erik Faye-Lund wrote:
> On Tue, Dec 18, 2012 at 6:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>>>> Junio C Hamano wrote:
>>>>> It could turn out that we may be able to get rid of sys/param.h
>>>>> altogether, but one step at a time.  Inputs from people on minority
>>>>> platforms are very much appreciated---does your platform build fine
>>>>> when the inclusion of the file is removed from git-compat-util.h?

cygwin is fine with that removed.

Mark
