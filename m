From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2b 00/16, 2 updates] Make the msvc-build scripts work
 again
Date: Wed, 22 Jul 2015 23:57:35 +0100
Message-ID: <55B01FDF.7030004@ramsay1.demon.co.uk>
References: <1437432846-5796-1-git-send-email-philipoakley@iee.org>	<xmqq1tg2xwbd.fsf@gitster.dls.corp.google.com>	<73004CECB3514744A5916831B4501689@PhilipOakley> <xmqqvbdduxd5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 01:03:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZI32c-0005wq-Nz
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 01:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbbGVXDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 19:03:05 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:37286 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752556AbbGVXDE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 19:03:04 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2015 19:03:03 EDT
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 120776F8F34;
	Wed, 22 Jul 2015 23:56:27 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id C50F56F8E95;
	Wed, 22 Jul 2015 23:56:26 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Wed, 22 Jul 2015 23:56:26 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
In-Reply-To: <xmqqvbdduxd5.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274473>

On 21/07/15 20:25, Junio C Hamano wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
> 
>> ... Ideally, if part of this
>> mainstream Git, it would get picked up automatically by them
>> (rather than being local 'fixes' endlessly carried forward).
> 
> Actually, that is not "ideal", but what I want to avoid.
> 
> As I do not do Windows, it simply is wrong for me to apply changes
> that are very likely to affect Windows folks without seeing their
> support first, which they may end up having to revert on their end
> and endlessly carry that revert forward.  That is why I very much
> prefer to see changes get there first and then forwarded in my
> direction once they are happy with them.
> 
>> There has been no activity here on the 'create a visual studio project'
>> aspects in the last few years. Any changes listed in the logs relate to
>> ensuring that the MSVC compiler will run as part of a regular Makefile
>> run (IIUC). The last significant commit was 74cf9bd (engine.pl: Fix a
>> recent breakage of the buildsystem generator, 2010-01-22) Ramsay Jones,
>> so that's five and a half years.
> 
> I think Ramsay is still around on the list; I do not know if he
> still does Windows, though.

[Sorry for not noticing this sooner, but I'm currently moving home
(among other things) and, as a result, I have not been able to
devote much time to the list ... (or anything else ;-) ]

I don't do much with MinGW or MSVC these days (I do still try to
keep cygwin running - it's currently not in good shape). My MSVC
installation is somewhat old (2008 I believe) and confined to my
old 32-bit laptop (which doesn't get booted up too often now).

I had a quick squint at the patches and, at first glance, they
looked quite reasonable to me, but I have not tested them. I can't
promise to test them anytime soon (and my MSVC may be too old for
these patches?). Sorry! :(

[If I find some time soon, I will give them a try and let you know.]

ATB,
Ramsay Jones
