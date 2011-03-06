From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 06 Mar 2011 07:44:43 -0500
Message-ID: <1299415483.5468.18.camel@drew-northup.unet.maine.edu>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	 <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
	 <20110214231920.GA24814@elie>
	 <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
	 <20110227084317.GB3356@sigill.intra.peff.net>
	 <1298820840.19827.69.camel@drew-northup.unet.maine.edu>
	 <20110228230311.GA7533@sigill.intra.peff.net>
	 <AANLkTi=LPqu9zDiAJpxqC=ZCLig+aCv5ztXw668ERtH7@mail.gmail.com>
	 <op.vrnq8gk856e9f9@xman.eng.oslo.osa>
	 <1298997963.5247.30.camel@drew-northup.unet.maine.edu>
	 <AANLkTinAUsY-d3Ec6HpKbjzC+eUjGcq1LK5ODjxRC-yz@mail.gmail.com>
	 <AANLkTimX3n5PNdK9YpA92SQM7G-WAiC1aPP7qJ-UEudq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Alexey Feldgendler <alexeyf@opera.com>, git@vger.kernel.org,
	David <bouncingcats@gmail.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Mar 06 13:46:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwDLh-00014I-5N
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 13:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab1CFMqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 07:46:00 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:47203 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab1CFMp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 07:45:58 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p26CimeJ002473
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 6 Mar 2011 07:44:48 -0500
In-Reply-To: <AANLkTimX3n5PNdK9YpA92SQM7G-WAiC1aPP7qJ-UEudq@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=11
	Fuz1=11 Fuz2=11
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p26CimeJ002473
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1300020302.47652@BIfumy4GlAu1U1sS/nxijw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168517>


On Sat, 2011-03-05 at 13:53 +0900, Miles Bader wrote:
> 2011/3/5 Felipe Contreras <felipe.contreras@gmail.com>:
> > First I liked this proposal, but then I thought about 'git diff
> > --preped' (doesn't really sound right). I think the term should:
> >
> >  1) Have a nice noun version; staging area, preparation area
> >  2) Have a nice verb version; to stage, to prep
> >  3) Have a nice past-participle; staged, cached
> >
> > Casting? Forging? I don't know, staging always seems right.
> 
> I agree.
> 
> I don't why so many people seem to be trying so hard to come with
> alternatives to "staged" and "staging area", when the latter are
> actually quite good; so far all the suggestions have been much more
> awkward and less intuitive.
> 
> It's true that "staging area" and "stage" as a verb are most intuitive
> for native english speakers, but so far none of the alternatives
> really seem any better for non-native speakers.  _All_ of these terms
> are "learned" to some degree, and in that sense are arbitrary, but the
> smoothness and intuitiveness of "staging area"/"stage" for english
> speakers is a real plus I think.

It has already been pointed out that this isn't always quite as
intuitive as it sounds to many. I think we'd be flogging a dead horse to
continue discussing that.

> As for translations, is it even an issue?  If term "XXX" is the
> optimum term in some other language, then that should be the
> translation for that langage, _regardless_ of what the english term
> used is.
> 
> -miles

Having translated stuff before, and having helped clean-up / finish
translations from other languages to English, I can say that it most
certainly DOES MATTER what the idiom used in the source language is.
Unless I the translator know more about how something works than the
core developers that wrote it I am highly dependent on the explanations
they have used. That is why it is important to have a complete and
portable metaphor. In fact, that's exactly what I was thinking about
when I suggested "commit preparation area" earlier in this thread--the
translation to Spanish is a tad verbose but it is entirely clear without
further jiggering or expectation of specific cultural knowledge. 

I'm not sure why that "fails" the equally arbitrary participle-mapping
test... It sure has one, but as a native English speaker and a brutal
editor I am perfectly comfortable with the notion that not all verbs
have natural noun forms and vice-versa.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
