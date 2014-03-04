From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/3] rebase: new convenient option to edit a single commit
Date: Tue, 04 Mar 2014 14:11:05 +0100
Message-ID: <5315D0E9.4070408@alum.mit.edu>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com> <1393728794-29566-1-git-send-email-pclouds@gmail.com> <1393728794-29566-4-git-send-email-pclouds@gmail.com> <CAPig+cTn-YcWHsGRKUZWqACJ5ZspWoB+f4i7hNj09_4Ci6odiw@mail.gmail.com> <CACsJy8Ct41PRb=_Ez7FLXbdiZkTU-tFYqtAxow9mCw7wYAfOhg@mail.gmail.com> <53159601.8020702@alum.mit.edu> <CACsJy8CSaAnVrFnhxRd=jPmXCat5AObNRLKzCesbdx3JS83PnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 14:11:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKp7r-0007nh-TE
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 14:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121AbaCDNLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 08:11:11 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:47224 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757065AbaCDNLK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 08:11:10 -0500
X-AuditID: 12074413-f79076d000002d17-90-5315d0ede45b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 3E.6C.11543.DE0D5135; Tue,  4 Mar 2014 08:11:09 -0500 (EST)
Received: from [192.168.69.148] (p57A2482C.dip0.t-ipconnect.de [87.162.72.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s24DB54j010929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 4 Mar 2014 08:11:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CACsJy8CSaAnVrFnhxRd=jPmXCat5AObNRLKzCesbdx3JS83PnA@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqPv2gmiwwelzvBZdV7qZLC59Xs9q
	0T3lLaPFj5YeZovOqbIWZ940MjqweeycdZfdY+KX46wey5euY/R41ruH0WPxAy+Pz5vkAtii
	uG2SEkvKgjPT8/TtErgzNi7by1qwmbPi4q67rA2MO9m7GDk5JARMJHpeX2CFsMUkLtxbz9bF
	yMUhJHCZUWLDgt2MEM5ZJon3vX/AOngFtCWWv5zDCGKzCKhK3Np6CcxmE9CVWNTTzARiiwoE
	S6y+/IAFol5Q4uTMJ2C2iICSxJuObcwgQ5kFTjNKLOjYDZTg4BAW8JNY26QHsWw2s8Syrn6w
	Bk6BQImp036wgdRICIhL9DQGgZjMAuoS6+cJgVQwC8hLbH87h3kCo+AsJNtmIVTNQlK1gJF5
	FaNcYk5prm5uYmZOcWqybnFyYl5eapGuuV5uZoleakrpJkZILAjvYNx1Uu4QowAHoxIPr+MU
	kWAh1sSy4srcQ4ySHExKorxZ50WDhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwKi4EyvGmJFZW
	pRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHh/gQwVLEpNT61Iy8wpQUgzcXCC
	DOeSEilOzUtJLUosLcmIB8VvfDEwgkFSPEB7/S+A7C0uSMwFikK0nmLU5bjd9usToxBLXn5e
	qpQ4rwXIDgGQoozSPLgVsMT3ilEc6GNhXmGQUTzApAk36RXQEiagJdyTwZaUJCKkpBoY7VR4
	t8dKbra5fuLP+3sua75FVU3deXLlbxOTo4v95VmWHLnHVXf0Wsp554KHj5a2zS1b 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243340>

On 03/04/2014 11:24 AM, Duy Nguyen wrote:
> On Tue, Mar 4, 2014 at 3:59 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>     git rebase --fixup COMMIT
>>     git rebase --squash COMMIT
> 
> This is not interactive (except when merge conflicts occur), is it?

--fixup would not be interactive (is that a problem?), but --squash does
open an editor to allow you to merge the commit messages.

> A bit off topic. I sometimes want to fix up a commit and make it stop
> there for me to test it again but there is no such command, is there?
> Maybe we could add support for "fixup/edit" (or "fe" for short) and
> "squash/edit" ("se"). Not really familiar with the code base to do
> that myself quickly though.

Maybe we should allow "edit" to appear on a line by itself, without a
SHA-1, in which case it would stop after all previous lines had been
processed.  Then you could change one line to "fixup" or "squash", and
then add a blank "edit" line after it.  Though there is no really
obvious way to do this using the hypothetical new command line options
that we have been discussing.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
