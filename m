From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 3/5] t/t1304: use 'test -r' to test readability rather
 than looking at mode bits
Date: Mon, 15 Mar 2010 12:51:24 -0500
Message-ID: <8fqqfdxYYa4RPD7FGUikyKCKHtfa5A5dhaSpyecsKHixseAVhiHOyw@cipher.nrlssc.navy.mil>
References: <YowxgPZqaOkg2MZzY1CxL1fbmUZ7CMUf5DgqI3S0X83DgqLNI9AGfI83JRNT8LWYHqXBB-PGS1Q@cipher.nrlssc.navy.mil> <YowxgPZqaOkg2MZzY1CxL61O63C5ULimj64t69Bc-wsW3IlWf4Zc9WmA3ihonAb8UtR5thcko00@cipher.nrlssc.navy.mil> <vpq3a017am6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 15 18:51:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrES2-0006aE-Si
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 18:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965468Ab0CORvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 13:51:32 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43433 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965385Ab0CORvb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 13:51:31 -0400
Received: by mail.nrlssc.navy.mil id o2FHpPaD006884; Mon, 15 Mar 2010 12:51:25 -0500
In-Reply-To: <vpq3a017am6.fsf@bauges.imag.fr>
X-OriginalArrivalTime: 15 Mar 2010 17:51:25.0104 (UTC) FILETIME=[217E2B00:01CAC468]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142236>

On 03/15/2010 12:33 PM, Matthieu Moy wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> -	-r--r-----*)
>> -		: happy
>> -		;;
> 
>> +	test -r "$1" &&
> 
> Maybe it makes sense to ask for -r--?-----* instead, to make sure we
> don't give the read bit to anyone. But that's not really important
> since we're protected by the directory's permission anyway.

I'm a little hesitant to add a test on the output from 'ls', since
Solaris and Linux produce different output in the presence of ACL's.

-brandon
