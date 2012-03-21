From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [GSoC] Designing a faster index format
Date: Wed, 21 Mar 2012 13:51:10 +0100
Message-ID: <871uomrubl.fsf@thomas.inf.ethz.ch>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
	<CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
	<8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com>
	<CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, <git@vger.kernel.org>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 13:51:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAL0Y-0001Lw-Dm
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 13:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758582Ab2CUMvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 08:51:13 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:32147 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758538Ab2CUMvM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 08:51:12 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Mar
 2012 13:51:09 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Mar
 2012 13:51:11 +0100
In-Reply-To: <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Wed, 21 Mar 2012 17:34:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193576>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Mar 21, 2012 at 4:22 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>
>> On Mar 21, 2012, at 2:29 AM, Nguyen Thai Ngoc Duy wrote:
>>
>> However I got one more question, since I'm not yet really familiar with the
>> code and internal structure of git, what exactly does the SHA1 over the
>> index exactly achieve? Is it only for checking if the index is still correct
>> for the next time it is used and has not been changed or is there a more
>> important function of it?
>
> It makes sure the index is not corrupt (by disk faults for example). I
> don't think it is used for anything else. Cheaper checksum can be used
> if good enough for the index. See
> http://thread.gmane.org/gmane.comp.version-control.git/190016 and the
> following reply.

Note that switching the checksum used already requires a
backwards-incompatible change of the index format.  If we are going to
do that, I'm somewhat opposed to not also revising it along the lines
sketched by Shawn (at least).

See my reply to Elton Sky

  http://thread.gmane.org/gmane.comp.version-control.git/193550/focus=193571

for links to some threads you may want to look at.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
