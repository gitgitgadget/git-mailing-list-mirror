From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 27 Feb 2011 10:34:00 -0500
Message-ID: <1298820840.19827.69.camel@drew-northup.unet.maine.edu>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	 <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
	 <20110214231920.GA24814@elie>
	 <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
	 <20110227084317.GB3356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 27 16:34:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtidY-0005Kr-D1
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 16:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab1B0PeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 10:34:16 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:46069 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab1B0PeP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 10:34:15 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p1RFY3fp027081
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 27 Feb 2011 10:34:08 -0500
In-Reply-To: <20110227084317.GB3356@sigill.intra.peff.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=6
	Fuz1=6 Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p1RFY3fp027081
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1299425649.20039@DcWlYhP+BBh7hLdo8cJzGw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168037>


On Sun, 2011-02-27 at 03:43 -0500, Jeff King wrote:
> On Sat, Feb 26, 2011 at 11:09:14PM +0200, Felipe Contreras wrote:
> 
> > On Tue, Feb 15, 2011 at 1:19 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > > When people talk about the staging area I tend to get confused.  I
> > > think there's an idea that because it sounds more concrete, there is
> > > less to explain --- or maybe I am just wired the wrong way.
> > 
> > I don't like the phrase "staging area". A "stage" already has an area.
> > You put things on the stage. Sometimes there are multiple stages.
> 
> As a native English speaker, this makes no sense to me. A stage as a
> noun is either:
> 
>   1. a raised platform where you give performances
> 
>   2. a phase that some process goes through (e.g., "the early stages of
>      Alzheimer's disease")

I definitely appreciate this notion. The equivalence of "stage ===
status of something, given place and or time" is itself metaphorical in
nature. I don't know how translatable the idiom is.

> Whereas the term "staging area" is a stopping point on a journey for
> collecting and organizing items. I couldn't find a definite etymology
> online, but it seems to be military in origin (e.g., you would send all
> your tanks to a staging area, then once assembled and organized, begin
> your attack). You can't just call it "staging", which is not a noun, and
> the term "stage" is not a synonym. "Staging area" has a very particular
> meaning.

I would have to check, but I believe you would find it linked to
metaphorical language about the "stage on which a battle is
fought" (battleground) and the fact that forces are sometimes organized
into formation--as they would appear upon a stage--in such an area
(before a parade or a march, for instance).

> So the term "staging area" makes perfect sense to me; it is where we
> collect changes to make a commit. I am willing to accept that does not
> to others (native English speakers or no), and that we may need to come
> up with a better term. But I think just calling it "the stage" is even
> worse; it loses the concept that it is a place for collecting and
> organizing.
> 
> -Peff

The concept of a "staging area" is definitely of limited use for many of
us attempting to learn how git works. The very fact that the object
cache and the Index (or multiple, as is useful at times) are distinct
elements is useful and should be mentioned somewhere. Alas, creating in
the user's mind that there is a distinct unified "staging area" acts
against this dissemination of knowledge. It definitely didn't help me.

If we use "staging area made up of the object store and information kept
in the Index" then we tie a knot on everything, make it clear that it
may be more complex than that--and you don't have to care, and we do not
foreclose on the possibility of more complete explanation later. That
does not bother me. We do however need to recognize that "staging area"
is an idiom of limited portability and deal with that appropriately. 

A particular Three Stooges episode comes to mind here for me. The Three,
in one scene, are getting dressed up to go to an estate (a relative of
one of them has died) to collect an inheritance. They are jumping up and
down yelling "We're gonna get rich!" in the English original. However,
the only thing the only timing appropriate thing the translator could
think of when producing the Spanish voice-over was "Vamos a
vestirse" (we're going to get dressed). Obviously this made them seem
like more utter fools than the were, but equally obviously the meaning
of the idiom "gonna get rich" was lost on the translator. This is what
has been replaying in my mind since Junio brought up the limited
portability of the notion of a "staging area" a little while back. He's
right--many idioms do not not survive translation. This is why we need
to make the documentation robust and technically correct while also
attempting to be nice to new users.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
