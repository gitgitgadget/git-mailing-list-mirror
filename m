From: Illia Bobyr <ibobyr@blizzard.com>
Subject: Re: Newbie grief
Date: Fri, 4 May 2012 01:01:30 +0000
Message-ID: <4FA32A6A.4070007@blizzard.com>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F28F5.2020403@palm.com>
 <201205010137.q411bxaU002449@no.baka.org> <4F9F52B9.9060508@palm.com>
 <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
 <4FA2D8EA.7030809@palm.com> <87obq5ggpu.fsf@an-dro.info.enstb.org>
 <7vehr1dl2z.fsf@alter.siamese.dyndns.org> <4FA307C5.102@palm.com>
 <4FA3090D.5080406@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Fri May 04 03:02:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ6uP-0007bK-FJ
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 03:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731Ab2EDBBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 21:01:31 -0400
Received: from mx11.blizzard.com ([12.130.201.13]:41356 "EHLO
	mx11.blizzard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237Ab2EDBBb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 21:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=blizzard.com; i=ibobyr@blizzard.com; q=dns/txt;
  s=mail; t=1336093291; x=1367629291;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ujo1VhnnMwqipTtoAcsB0eZ7nDuQLcHeglelG8oQZJE=;
  b=rkX2AZ8yd1uDFybrnRl9I5ne1rpeMp43tnWxQwj6TlHNWHD6TJOPoPZA
   kS3nY8WxU42Fa6esOCS7r1tkrxlGG9+Mp8JjH/wK1dsXuV+2lAWcAmx6X
   bCyPy/F24dUyAE8GXyGqDoCVPFXn7HCUeIz8d1hRBP4X6yU8Oryxdukrs
   8=;
X-IronPort-AV: E=Sophos;i="4.75,528,1330934400"; 
   d="scan'208";a="3156089"
Received: from irvex205.corp.blizzard.net ([10.130.14.26])
  by mx11.blizzard.com with ESMTP; 03 May 2012 18:01:30 -0700
Received: from IRVEX016.corp.blizzard.net (10.130.2.71) by
 IRVEX205.corp.blizzard.net (10.130.14.26) with Microsoft SMTP Server (TLS) id
 14.1.289.1; Thu, 3 May 2012 18:01:30 -0700
Received: from IRVEX008.corp.blizzard.net ([fe80::c5f9:f4ad:53fc:4d4b]) by
 IRVEX016.corp.blizzard.net ([::1]) with mapi id 14.01.0289.001; Thu, 3 May
 2012 18:01:29 -0700
Thread-Topic: Newbie grief
Thread-Index: AQHNKWoSOzhARVRq9kmPhVkDfom0zpa4kKFRgACLeICAAAGHgIAAJ8UA
In-Reply-To: <4FA3090D.5080406@palm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.129.238.124]
Content-ID: <4FF06470A69A4743836F573F41133B20@blizzard.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196980>

On 5/3/2012 3:39 PM, Rich Pixley wrote:
> On 5/3/12 15:33 , Rich Pixley wrote:
>> On 5/3/12 14:13 , Junio C Hamano wrote:
>>> Ronan Keryell<Ronan.Keryell@hpc-project.com>   writes:
>>>>>>>>> On Thu, 03 May 2012 12:13:46 -0700, Rich 
>>>>>>>>> Pixley<rich.pixley@palm.com>   said:
>>>>       Rich>   * the hg error messages are straightforward, clear, 
>>>> and don't
>>>>       Rich>   require any deep knowledge of the source code control 
>>>> system
>>>>       Rich>   or it's limitations.  (I still don't understand what 
>>>> the git
>>>>       Rich>   message on collision is saying.)
>>>>
>>>> This is a very good suggestion.
>>>> ...
>>>> At least, print a simpler message with some typical use case causing
>>>> this and some workflow ideas before the detailed explanation.
>>> It indeed is a good starting point to make a suggestion, but there is
>>> nothing actionable in the above by itself, especially since "typical 
>>> use
>>> case" is quite different for different Git users.
>> How about, "Your push can't be made because it would cause an
>> irreconcilable collision.  You probably want to pull and merge before
>> attempting to push again."
>
> Er... "Your push can't be made because it would cause an 
> irreconcilable collision.  You probably want to fetch and merge before 
> attempting to push again."

While this error message makes more sense to you at this point it is not 
entirely true.
The collision is not irreconcilable and may not even be a collision.  
For example, if you just rebased, it is not a collision from a more 
abstract point of view.

It is just a "non-fast forward" move of a branch tip.  This term 
describes what happens precisely :)

It is true, that the term is non obvious to the new comers.
One may google and get an explanation of the error pretty quickly.  
First hit for "git non fast forward error" gives an explanation from a 
new comer point of view for the simplest case.

Another option is to change the way git "talks".  AFAIR there were a 
number of attempts to come up with a new dictionary for git.
I am not sure if any of the attempts were complete as it is not that easy.
Changing just one error message at a time would make it less consistent 
as a concept of "fast forward" moves is used in other places.
For example, git merge has --ff and --no-ff options that stand for "fast 
forwrad" and "no fast forward" respectively.

Illia Bobyr