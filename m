From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: What's cooking in git.git (Sep 2012, #05; Fri, 14)
Date: Sat, 15 Sep 2012 19:15:25 +0200
Message-ID: <001101cd9365$b2d8e030$188aa090$@schmitz-digital.de>
References: <7vboh82t7p.fsf@alter.siamese.dyndns.org> <k31k35$pc$1@ger.gmane.org> <7v4nmz1aqi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 19:15:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCvyG-0002FV-55
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 19:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab2IORPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 13:15:45 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:53112 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab2IORPn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 13:15:43 -0400
Received: from DualCore (dsdf-4db519b7.pool.mediaWays.net [77.181.25.183])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MAulY-1TKavk1DSm-009xXN; Sat, 15 Sep 2012 19:15:36 +0200
In-Reply-To: <7v4nmz1aqi.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQFSM/QZ0Uszb/mjAZasqQgOWx1JcQGOwwCVAMV3/MOYb79sgA==
Content-Language: de
X-Provags-ID: V02:K0:C2aXaTcBR1ysK7jsB59v9jIRltsZVNKLZmf1fGJWUx/
 ZMSYzTioVZItQcDXsjQk/AmiCkMVnzCPLj7Xc2zWkh8Aq85zA0
 2Pl27njrMzb432sgbwDtn6uuPjmWFm4bZXhWeHVQmwDUwAvKZ6
 7C7FmsZ78uVG6+EFinL+JPA+uve6w2PmSpKN0g7hj8seoEg9MY
 rwcQ4uIjzGO2MSk0KO35eI/5n8+MvPr5Fpq4fbhbBtBDJqNwM9
 Ps4nmltOQco33JtI0M7Cw3OOHOcEt3rJl1mAZNI7nRUuslJiwG
 9fmLmI3JV04PBLLXfR2z49NaMR/PkYeHonqh5zeTW7Q8+TjqX7
 h0Ad+pwnnyb9CyQOcptYE7SORGTPLO9nNNt/WDKWsRJtdP1ux+
 rAABQ4/W27ZFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205564>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Saturday, September 15, 2012 7:01 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: What's cooking in git.git (Sep 2012, #05; Fri, 14)
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Junio C Hamano wrote:
> >> I think we can start thinking about feature freeze once the topics
> >> in 'next' that are scheduled to graduate to 'master' already are
> >> fully cooked.  For any late-coming topic, there always is the next
> >> cycle ;-)
> >
> > I've not hear anything about my poll patches and I'd really like them
> > to into 1.8.x.
> 
> I've seen some patches on "poll" posted, were discussed and had
> threads titled "Re: [PATCH] ...".  But I didn't see a rerolled
> "[PATCH v2 n/m] ..." series that states that it is a rerolled
> "hopefully final version" that addresses all the points that were
> brought up during the discussion that need to be addressed.
> 
> I do not necessarily follow all the minute details of all discussion
> threads.  For this particular series, I not know which ones of your
> "poll patches" turned out to be unneeded, which ones turned out to
> be fine as posted originally and which ones needed updating.

There were several iterations up to [PATCH v4 n/4] and only one foreign comment to it (and to some commented code) and one
self-comment about the order of patches, but none about technical correctness, none that I remember at least.

I can post a v5 series which will
- move compat/win32/poll.[ch] to compat/poll/ and adjust Makefile
- #ifdef some WIN32 specific #include (should this be done in one step with the above?)
- fix the 2 bugs in poll.c just like they got fixed in gnulib's version (would you want this in one or two steps?)

Bye, Jojo
