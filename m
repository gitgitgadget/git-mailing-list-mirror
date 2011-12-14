From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] test: errors preparing for a test are not special
Date: Wed, 14 Dec 2011 09:51:59 +0100
Message-ID: <4EE863AF.2070606@viscovery.net>
References: <1323815706-10560-1-git-send-email-jratt0@gmail.com> <1323815706-10560-2-git-send-email-jratt0@gmail.com> <4EE853C0.20505@viscovery.net> <20111214082203.GB13166@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joe Ratterman <jratt0@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 09:52:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RakZP-0006Wa-Gw
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 09:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685Ab1LNIwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 03:52:07 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:32659 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab1LNIwF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 03:52:05 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RakZE-0007tu-9C; Wed, 14 Dec 2011 09:52:00 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 048181660F;
	Wed, 14 Dec 2011 09:51:59 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111214082203.GB13166@elie.hsd1.il.comcast.net>
X-Enigmail-Version: 1.3.3
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187102>

Am 12/14/2011 9:22, schrieb Jonathan Nieder:
> Johannes Sixt wrote:
>> Am 12/13/2011 23:35, schrieb Joe Ratterman:
> 
>>>  test_expect_success TTY 'no pager with --no-pager' '
>>>  	rm -f paginated.out ||
>>>  	cleanup_fail &&
>>
>> What kind of bogosity do I see in the context of this hunk
> [...]
>> Wouldn't rm -f always succeed under normal circumstances, and then the
>> rest of the test would be skipped?
> 
> No, && and || are left-associative.

<Facepalm/> You are right, of course, and I should have known better. (I
need more caffein.)

At any rate, your patch makes the code much more comprehensible.

-- Hannes
