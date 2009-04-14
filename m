From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH RFC3 09/13] send-email: Remove horrible mix of tabs and
 spaces
Date: Tue, 14 Apr 2009 09:17:45 +0200
Message-ID: <49E43899.7070804@op5.se>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com> <1239647037-15381-3-git-send-email-mfwitten@gmail.com> <1239647037-15381-4-git-send-email-mfwitten@gmail.com> <1239647037-15381-5-git-send-email-mfwitten@gmail.com> <1239647037-15381-6-git-send-email-mfwitten@gmail.com> <1239647037-15381-7-git-send-email-mfwitten@gmail.com> <1239647037-15381-8-git-send-email-mfwitten@gmail.com> <1239647037-15381-9-git-send-email-mfwitten@gmail.com> <1239647037-15381-10-git-send-email-mfwitten@gmail.com> <7vab6ke0ip.fsf@gitster.siamese.dyndns.org> <b4087cc50904131549sec5acc4m7201b1411245b95f@mail.gmail.com> <49E41F99.6010409@op5.se> <7vws9n92q3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 09:20:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltcvy-0003II-Nc
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 09:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbZDNHRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 03:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbZDNHRu
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 03:17:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:24638 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbZDNHRt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 03:17:49 -0400
Received: by fg-out-1718.google.com with SMTP id e12so738397fga.17
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 00:17:48 -0700 (PDT)
Received: by 10.86.80.5 with SMTP id d5mr5389371fgb.6.1239693467891;
        Tue, 14 Apr 2009 00:17:47 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id e20sm8586414fga.9.2009.04.14.00.17.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Apr 2009 00:17:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7vws9n92q3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116526>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> Using tabs to align stuff to indentation level and spaces to align
>> line continuation is the only possible way to let users choose
>> whichever indentation depth they want while preserving the continuation
>> alignment.
> 
> Sure, it will look aligned with whatever width of HT ">":
> 
> 	>>if (this is a looong
>         >>....expression that is alighed) {
>         >>>statement1;
>         >>>statement2;
>         >>}
> 
> but it is *only true* if your SP "." and everything else is of the same
> width.
> 
> People seem to repeat that without realizing what they are saying, but I
> find the assumption the argument is based on quite bogus.  Why do people
> think it is only sane to assume flexible HT width but still monospaced
> font whose SP, l and w are all of the same width?
> 

Because 99% of all editors designed for programming use a fixed-width font
by default for precisely that reason, and all others can be set to display
fixed-width fonts without losing much (if any) readability, but indentation
comes in 2*$number_of_programmers variations.


> You either forget about the alignment (there is no such thing---suck it
> up), or use time honored HT=8 and monospace convention.
> 

Or you use "indent with tabs, align with spaces" and let those who use a
word processor for programming go hang. It's quite common actually. Or
you use some own homecooked style of indentation that's quite obvious
*to you* Either way, a project's founding father always sets the style,
and those who contribute get to either follow it or provide some pretty
strong argument to change it (a lot better than:

"A few of the lines were aligning function arguments via tabs
and a few extra spaces, which is not reliable in my model.

Frankly, I don't like tabs and spaces sharing the same contiguous
block. I don't like it all."

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
