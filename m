From: david@lang.hm
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 04:45:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4BA338C1.7030803@alum.mit.edu> <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-498612497-1268999139=:3821"
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 12:45:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsaeD-0006CT-BV
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 12:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492Ab0CSLpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 07:45:43 -0400
Received: from mail.lang.hm ([64.81.33.126]:52915 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab0CSLpm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 07:45:42 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id o2JBjcWx018099;
	Fri, 19 Mar 2010 03:45:39 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142576>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-498612497-1268999139=:3821
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 19 Mar 2010, Michael Witten wrote:

> On Fri, Mar 19, 2010 at 02:41, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Michael Witten wrote:
>>> Rather than use a (name,email) pair to identify people, let's use
>>> a (uuid,name,email) triplet.
>>> [...]
>>
>> A UUID doesn't need to be a big hex number.  All it has to be is a
>> "Universally Unique Identifier".  Like, oh, for example, your
>>
>>                   *** EMAIL ADDRESS ***
>>
>> [1].  There is even already a way to fix up mistakes or unavoidable
>> email address changes, namely the .mailmap file.
>
> *facepalm*
>
> You've just repeated everything that I've said; go look at the rest of
> the thread, where I spend plenty of time correcting the same hangups
> about my choice of the word UUID and my use of hex digits.
>
> I'm only observing that the current name/email system pair conflates
> an individual with his current email system and that it would be
> worthwhile to ALLOW an individual to FURTHER describe himself by
> including another piece of information that is solely meant as
> identification within git. That piece of information could be whatever
> a user deems to be uniquely identifying for himself. You could use
> "Michael Haggerty <mhagger@alum.mit.edu>" as your uuid, and you could
> still use it after you change the `email' config variable to something
> else.
>
> There is MUCH LESS CHANCE of such a uuid getting trashed by typos,
> changing names, and changing email addresses; of course it can still
> get messed up, but the rate at which something like .mailmap would
> need to be updated would likely be greatly decreased and it would make
> gathering statistics easier (especially for the individuals who take
> advantage of such a uuid for describing themselves---and it only
> requires setting one config variable to something easily remembered by
> that person).

here is where you are missing the point.

no, there is not 'much less chance' of it getting messed up.

you seem to assume that people would never need to set the UUID on 
multiple machines.

if they don't need to set it on multiple machines, then the e-mail/userid 
is going to be reliable anyway

if they do need to set it on multiple machines and can't be bothered to 
keep their e-mail consistant, why would they bother keeping this 
additional thing considtant? Linus is pointing out that people don't care 
now about their e-mail and name, and will care even less about some 
abstract UUID

people who care will already make their e-mail consistant.

David Lang


> I cover all of this numerous times in numerous rebuttals; don't
> contribute to a thread with more than 60 emails without having read at
> least some of them. If you don't care to read so much, then perhaps
> jump here:
>
>    http://marc.info/?l=git&m=126894679711600&w=2
>
> In the end, there is probably only one legitimate problem with my
> proposal: It might break compatibility with older repo formats/tools.
> I'm not sure about that.
>
> Sincerely,
> Michael Witten
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--680960-498612497-1268999139=:3821--
