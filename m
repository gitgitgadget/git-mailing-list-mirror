From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 15:08:26 +0100
Message-ID: <4BA3855A.1070005@alum.mit.edu>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4BA338C1.7030803@alum.mit.edu> <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 15:08:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NscsM-0007Or-7n
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 15:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485Ab0CSOI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 10:08:29 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41990 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab0CSOI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 10:08:29 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o2JE8QoB020411
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 19 Mar 2010 15:08:26 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.24) Gecko/20100317 Thunderbird/2.0.0.24 Mnenhy/0.7.6.666
In-Reply-To: <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142597>

Michael Witten wrote:
> On Fri, Mar 19, 2010 at 02:41, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Michael Witten wrote:
>>> Rather than use a (name,email) pair to identify people, let's use
>>> a (uuid,name,email) triplet.
>>> [...]
>> A UUID doesn't need to be a big hex number.  All it has to be is a
>> "Universally Unique Identifier".  Like, oh, for example, your
>>
>>                   *** EMAIL ADDRESS ***
>>
>> [1].  There is even already a way to fix up mistakes or unavoidable
>> email address changes, namely the .mailmap file.
> 
> *facepalm*
> 
> You've just repeated everything that I've said; go look at the rest of
> the thread, where I spend plenty of time correcting the same hangups
> about my choice of the word UUID and my use of hex digits.

No, my point is to use the *existing* email address as the UUID
*without* adding another field.  Nothing needs to be changed!

> [...] You could use
> "Michael Haggerty <mhagger@alum.mit.edu>" as your uuid, and you could
> still use it after you change the `email' config variable to something
> else.

Give me a break.  It's not so damn hard to keep an email address over
time.  And if it changes, I can update the .mailcap file to map my old
email address to the new one and *presto* I have a new, equally valid
UUID that I can continue to commit under.

> I cover all of this numerous times in numerous rebuttals; don't
> contribute to a thread with more than 60 emails without having read at
> least some of them.

Wrong.  I've read the whole idiotic thread.  To prove it I'll summarize
it for you: you argue the same point over and over again while ignoring
the legitimate objections of just about every other participant.

Adding a new UUID field is obviously a non-starter, so I suggested a way
to get the same (very marginal) benefit from the fields that are already
present in every git repository.

Michael
