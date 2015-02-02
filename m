From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: RFD: should we do another 2.3-rc for t9001-noxmailer? I'd say
 not
Date: Mon, 2 Feb 2015 10:29:53 +0100
Message-ID: <54CF4391.9010301@statsbiblioteket.dk>
References: <xmqqr3u98d0f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 10:30:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIDKT-000550-Eh
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 10:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199AbbBBJ34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 04:29:56 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:35202 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753468AbbBBJ34 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 04:29:56 -0500
Received: from [172.18.234.199] (172.18.234.199) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.3.389.2; Mon, 2 Feb 2015 10:29:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.8.0
In-Reply-To: <xmqqr3u98d0f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263255>

On 01/02/15 23:48, Junio C Hamano wrote:
> I was reviewing the recent bugs and fixes for the last time, and was
> wondering if we want to do 2.3-rc3 with build fix for those with
> ancient cURL (tc/curl-vernum-output-broken-in-7.11) and workaround
> for those with Perl with older Getopt::Long (tc/t9001-noxmailer).
>
>   - The former is not a regression between 2.2 and 2.3 (i.e. 2.2
>     already had the same use of curl-config output).
>
>   - The latter, strictly speaking, is a regression in that tests used
>     to pass but tests in 2.3 no longer pass for those with older
>     Getopt::Long.
>
> So currently I am leaning to keep these two fixes where they are and
> tag 2.3 final without them in a few days.
>

Leaving them for a later release is fine by me.
These two patches cover only what broke from 2.2.2 to 2.3, there are 
further patches needed to actually complete a build atleast on RHEL3.

-tgc
