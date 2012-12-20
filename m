From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: Python version auditing followup
Date: Thu, 20 Dec 2012 22:30:30 +0100
Message-ID: <kb001v$vps$1@ger.gmane.org>
References: <20121220143411.BEA0744105@snark.thyrsus.com> <7vobho60fs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 22:31:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlni3-00039K-TG
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 22:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab2LTVbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 16:31:00 -0500
Received: from plane.gmane.org ([80.91.229.3]:40123 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab2LTVbA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 16:31:00 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Tlnhu-0002zk-Um
	for git@vger.kernel.org; Thu, 20 Dec 2012 22:31:10 +0100
Received: from dsdf-4db53d15.pool.mediaways.net ([77.181.61.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 22:31:10 +0100
Received: from jojo by dsdf-4db53d15.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 22:31:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db53d15.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211931>

Junio C Hamano wrote:
> esr@thyrsus.com (Eric S. Raymond) writes:
>
>> That was the first of three patches I have promised.  In order to do
>> the next one, which will be a development guidelines recommend
>> compatibility back to some specific version X, I need a policy
>> decision.  How do we set X?
>>
>> I don't think X can be < 2.4, nor does it need to be - 2.4 came out
>> in 2004 and eight years is plenty of deployment time.
>>
>> The later we set it, the more convenient for developers.  But of
>> course by setting it late we trade away some portability to
>> older systems.
>>
>> In previous discussion of this issue I recommended X = 2.6.
>> That is still my recommendation. Thoughts, comments, objections?
>
> I personally would think 2.6 is recent enough.  Which platforms that
> are long-term-maintained by their vendors still pin their Python at
> 2.4.X?  2.4.6 was in 2008 that was source only, 2.4.4 was in late
> 2006 that was the last 2.4 with binary release.
>
> Objections?  Comments?

We have a working 2.4.2 for HP-NonStop and some major problems getting 2.7.3 
to work.

Bye, Jojo 
