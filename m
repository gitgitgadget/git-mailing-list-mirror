From: Antriksh Pany <antriksh.pany@gmail.com>
Subject: Re: Need to change old commit (and regenerate tree)
Date: Fri, 21 May 2010 19:18:17 +0100
Message-ID: <AANLkTin77rXsU28ikOZx8mxpQANHjaEET--RiR6lGd3a@mail.gmail.com>
References: <AANLkTilTAknKPFv5AZBrwsITPsRlVSnsuX8TDXlUTWmw@mail.gmail.com>
	 <m2sk5mtecw.fsf@igel.home>
	 <AANLkTim0M-PJC655bhfcQ6mBYTPt9TK9Ys8qJBJd1UPS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 20:18:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFWnh-0001nU-RK
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 20:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758593Ab0EUSSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 14:18:20 -0400
Received: from mail-yw0-f180.google.com ([209.85.211.180]:47936 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758486Ab0EUSST (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 14:18:19 -0400
Received: by ywh10 with SMTP id 10so744898ywh.1
        for <git@vger.kernel.org>; Fri, 21 May 2010 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=psIPNvu7YEued5n04OKdl2XWJoXBd5+ckdmDvQzMLSM=;
        b=K1QxemIw1v2LJyYWEFk+6rC+Icmd/RhmylrY7YxD/3FmNKKYRjHXmL9r5MdzI3+N2P
         w3Fu5tq1SExTvsqC3qWwc4g/kbt334ya2hoRzvow689PiNQu/WXv6e2e1sHsxyBPt1S0
         uFIV4jFGIXxLDImOVq95NRDj9gqKGe8m7WQbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FE+tbiUd4RrJMrh7IswKbXF0oa/3NslpZD+ES71+/5A/xi39cl1mzHcKzMnWHOPAsW
         oGAQO1MvhFF/YK+7t0VOo5xolzkFb22IxQkBfOsFyKwPmGYvWeEOK2fEEPn/vMui9Q+0
         edxn6vIxi7xmmWbOM77JK0JrQ1FURHKsJnUGo=
Received: by 10.150.170.9 with SMTP id s9mr3103998ybe.418.1274465897250; Fri, 
	21 May 2010 11:18:17 -0700 (PDT)
Received: by 10.151.111.3 with HTTP; Fri, 21 May 2010 11:18:17 -0700 (PDT)
In-Reply-To: <AANLkTim0M-PJC655bhfcQ6mBYTPt9TK9Ys8qJBJd1UPS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147492>

Hi Jon

I guess the parent of both B~3 as well as C~6 is A2. So if, as you
say, the time can be made
identical, they should yield the same SHA1 IMHO.

On Fri, May 21, 2010 at 12:05 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> On Fri, May 21, 2010 at 8:09 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> Antriksh Pany <antriksh.pany@gmail.com> writes:
>>
>>> Instead of (what I initially expected):
>>>
>>> A--------o--------o--------o--------o(old B)--------o--------o--------o(old C)
>>>
>>> A2--------o--------o--------o--------B--------o--------o--------C
>>>
>>>
>>> So what I am missing here? Aren't the new commits B~1, B~2, B~3
>>> identical to C~4, C~5, C~6 (respectively) in all ways so as to have
>>> gotten them the same SHA1 and hence appear as what I expected them to
>>> appear?
>>
>> No, they have a different commit time, which is also part of the hash.
>>
>
> Of course, even if the commit time was forged to be the same, the
> parent of B~3 is different to the parent of C~6 and since the parent
> is also contributes bits to the respective hashes, B~3 will
> necessarily (unlikely hash collisions excepted!) have a different hash
> to C~6
>
> jon.
>
