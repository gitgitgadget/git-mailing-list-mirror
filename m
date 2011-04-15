From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2011, #04; Tue, 12)
Date: Fri, 15 Apr 2011 08:24:09 +0200
Message-ID: <BANLkTimeiH_ohJ6yGTU0Ei3t2xvUz0zCUA@mail.gmail.com>
References: <7vaafvnl9t.fsf@alter.siamese.dyndns.org>
	<BANLkTi=7YSfKe=Pc5n-BNr30=ADM-jRXrg@mail.gmail.com>
	<4DA710FB.7060808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 15 08:24:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAcS1-0008VL-Dx
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 08:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab1DOGYM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2011 02:24:12 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56158 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab1DOGYK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2011 02:24:10 -0400
Received: by vws1 with SMTP id 1so1870523vws.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 23:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rzwYpSwDE730YBpuCzFi2MDuNqleCFl0JxOv2CFvYcc=;
        b=Qg+iDCEHbo5Xpl533yarOjAAppydL+kv8QzheCAWeS0d83szHd8I05YqGDUVDv4SJ/
         kJM4fGFhBHpp4W1LJza9yJrTWiSI64z4RIuD3zQjI/vefUgPjsGXiqyK/Xxn5tSN9gOq
         BzW9MgUlyJm0t28Oi0pgzu6vnsGI4M8JhYtE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VJLZ/HN/yCBZw8pMqOH/OH2aRR4+SvuMfOpS7nTKRn0b78c6St3vQPvXQVJoKiE7+K
         W23YvZp02skz6yqMykNcJX/LhSPUAftkGYvtjQL7cyq95lnmJtBCWcRP8g9QDJKrdwxB
         h+PcIgtRGGNiRHzUFb9u0ymC734PDHg404vtw=
Received: by 10.220.117.148 with SMTP id r20mr514092vcq.16.1302848649593; Thu,
 14 Apr 2011 23:24:09 -0700 (PDT)
Received: by 10.220.180.202 with HTTP; Thu, 14 Apr 2011 23:24:09 -0700 (PDT)
In-Reply-To: <4DA710FB.7060808@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171589>

On Thu, Apr 14, 2011 at 5:21 PM, Michael Haggerty <mhagger@alum.mit.edu=
> wrote:
> On 04/14/2011 03:38 PM, Piotr Krukowiecki wrote:
>> On Wed, Apr 13, 2011 at 12:43 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>> * mh/git-svn-automkdirs (2011-04-01) 1 commit
>>> =A0(merged to 'next' on 2011-04-03 at 7fa4978)
>>> =A0+ git-svn: add an option to skip the creation of empty directori=
es
>>>
>>> Should be safe, but I'd like an Ack from git-svn folks.
>>
>> I wanted to test performance of this change - what's the best way to=
 do it?
>>
>> I tried some ideas, but rebase was too fast for performance measurem=
ents.
>> I did not have new commits, but just some old, already in trunk chan=
ges, which
>> I tried to rebase - probably it was just fast forward?
>
> The unhandled.log.gz file for trunk of our main project is 14 Mb and
> uncompresses to 233 Mb. =A0About 90% of it consists of svn:mergeinfo
> properties for file that were copied or renamed within the repository=
;
> most of the rest is other random SVN file properties.
>
> With such a huge unhandled.log file, "git svn mkdirs" took about 10s =
for
> me. =A0I believe that "git svn rebase" should take at least as long, =
even
> if it is a fast-forward.

That might be the reason - my unhandled.log is 17MB (unpacked) and mkdi=
rs
takes 0.5s


--=20
Piotr Krukowiecki
