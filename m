From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: size_t vs "unsigned long"
Date: Fri, 5 Oct 2007 02:27:05 -0400
Message-ID: <620B5C1C-CFE8-401B-8BC7-D89C8740D63B@mac.com>
References: <7vabr0djqr.fsf@gitster.siamese.dyndns.org> <20071003204801.GC28188@artemis.corp> <877im3khj0.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Fri Oct 05 08:35:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idgm4-0000dB-Uo
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 08:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbXJEGeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 02:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbXJEGeE
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 02:34:04 -0400
Received: from smtpoutm.mac.com ([17.148.16.71]:54164 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbXJEGeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 02:34:03 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Oct 2007 02:34:03 EDT
Received: from mac.com (smtpin02-en2 [10.13.10.147])
	by smtpoutm.mac.com (Xserve/smtpout008/MantshX 4.0) with ESMTP id l956R9JR026613;
	Thu, 4 Oct 2007 23:27:09 -0700 (PDT)
Received: from [10.0.4.100] (n150s180.ntc.blacksburg.shentel.net [204.111.150.180])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin02/MantshX 4.0) with ESMTP id l956R6Ew022768
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 4 Oct 2007 23:27:07 -0700 (PDT)
In-Reply-To: <877im3khj0.fsf@mid.deneb.enyo.de>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60038>

On Oct 03, 2007, at 17:36:03, Florian Weimer wrote:
> * Pierre Habouzit:
>> Well, afaict, on every linux archs I know of, unsigned longs and  
>> size_t are the same.
>
> IIRC, 64-bit Windows uses 64-bit points (duh) and hence a 64-bit  
> size_t, but still has got 32-bit longs.  Documentation is a bit  
> sparse on this matter (because you are supposed to use LONG, DWORD  
> and friends anyway).

For reference, Linux is always an LP32 (long-and-pointer-are-32-bit)  
or LP64 (long-and-pointer-are-64-bit) platform.  On the other hand,  
for crappy backwards-compat reasons, Windows is either LP32 or LLP64  
(long-long-and-pointer-are-64-bit).  I think most of the remaining  
UNIXes fall into the LP32/LP64 category, the LLP64 platforms are  
fairly rare (thankfully).

Cheers,
Kyle Moffett
