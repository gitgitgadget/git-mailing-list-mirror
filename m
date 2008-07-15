From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] t9600: allow testing with cvsps 2.2, including beta
	versions
Date: Mon, 14 Jul 2008 20:51:14 -0400
Message-ID: <20080714205114.cnwynr1q804wow4k-cebfxv@webmail.spamcop.net>
References: <20080715002019.5337.81984.stgit@dv.roinet.com>
	<7v1w1wdm37.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 02:52:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIYm9-0002cY-Vi
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 02:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760685AbYGOAvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 20:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760706AbYGOAvQ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 20:51:16 -0400
Received: from c60.cesmail.net ([216.154.195.49]:52455 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760510AbYGOAvP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2008 20:51:15 -0400
Received: from unknown (HELO delta2) ([192.168.1.50])
  by c60.cesmail.net with ESMTP; 14 Jul 2008 20:51:14 -0400
Received: from pool-71-185-134-138.phlapa.east.verizon.net
	(pool-71-185-134-138.phlapa.east.verizon.net [71.185.134.138]) by
	webmail.spamcop.net (Horde MIME library) with HTTP; Mon, 14 Jul 2008
	20:51:14 -0400
In-Reply-To: <7v1w1wdm37.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88490>

Quoting Junio C Hamano <gitster@pobox.com>:

> Pavel Roskin <proski@gnu.org> writes:
>
>> Don't assume that unsupported versions are too old, they may be too new.
>
> Excuse me, but we never assumed such.
>
> Neither too old nor too new ones are proven to work with us yet, so we
> cannot be call them supported.

The message was "skipping cvsimport tests, cvsps too old" so the  
assumption was there.

> Let's apply your patch and see how well version 2.2 fares.
>
> Thanks.
>
>> diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
>> index 655f882..f92b47a 100755
>> --- a/t/t9600-cvsimport.sh
>> +++ b/t/t9600-cvsimport.sh
>> @@ -20,13 +20,15 @@ cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps  
>>  version //p'`
>>  case "$cvsps_version" in
>>  2.1)
>>  	;;
>> +2.2*)
>> +	;;
>
> Hmm, I would have written:
>
> 	case "$..." in
>         2.1 | 2.2 )

Fine with me, but please allow for extra specifiers.

> Is the reason why you have the asterisk there because the beta one claims
> "2.2beta" or something (I am not suggesting to tighten the match, just
> asking for information)?

It's cvsps 2.2b1 from Fedora Development (cvsps-2.2-0.1.b1.fc10.x86_64)

$ cvsps -h 2>&1 | grep version
cvsps version 2.2b1

-- 
Regards,
Pavel Roskin
