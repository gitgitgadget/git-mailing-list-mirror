From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH RFC3 09/13] send-email: Remove horrible mix of tabs and
 spaces
Date: Tue, 14 Apr 2009 07:31:05 +0200
Message-ID: <49E41F99.6010409@op5.se>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>	 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>	 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>	 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>	 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>	 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>	 <1239647037-15381-8-git-send-email-mfwitten@gmail.com>	 <1239647037-15381-9-git-send-email-mfwitten@gmail.com>	 <1239647037-15381-10-git-send-email-mfwitten@gmail.com>	 <7vab6ke0ip.fsf@gitster.siamese.dyndns.org> <b4087cc50904131549sec5acc4m7201b1411245b95f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 07:32:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtbGG-0003FE-B2
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 07:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbZDNFbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 01:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbZDNFbK
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 01:31:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:9676 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbZDNFbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 01:31:09 -0400
Received: by fg-out-1718.google.com with SMTP id e12so729125fga.17
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 22:31:07 -0700 (PDT)
Received: by 10.86.89.20 with SMTP id m20mr5263575fgb.18.1239687067058;
        Mon, 13 Apr 2009 22:31:07 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id e11sm7970017fga.5.2009.04.13.22.31.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 22:31:06 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <b4087cc50904131549sec5acc4m7201b1411245b95f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116512>

Michael Witten wrote:
> On Mon, Apr 13, 2009 at 15:55, Junio C Hamano <gitster@pobox.com> wrote:
>> Michael Witten <mfwitten@gmail.com> writes:
>>
>>> Currently, no lines match the following:
>>>
>>>     [\t]+[ ]+
>>>     [ ]+[\t]+
>> I understand the latter but what's wrong with the former?  The width of a
>> HT is by definition 8 columns throughout the git codebase.
> 
> Ah, well, the width of a HT has been a free variable in my
> calculations; I was operating under the assumption that whitespace
> used for indentation can float freely according to the user's
> settings. A few of the lines were aligning function arguments via tabs
> and a few extra spaces, which is not reliable in my model.
> 
> Frankly, I don't like tabs and spaces sharing the same contiguous
> block. I don't like it all. ;-B


Using tabs to align stuff to indentation level and spaces to align
line continuation is the only possible way to let users choose
whichever indentation depth they want while preserving the continuation
alignment. What's not to like about that? Especially if you think a
horizontal tab can be any size at all, you should be all agog.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
