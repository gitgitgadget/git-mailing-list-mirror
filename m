From: Michael Olson <mwolson@gnu.org>
Subject: Re: [PATCH] Documentation/git-tag.txt: Document how to backdate tags
Date: Mon, 15 Oct 2007 18:53:43 -0400
Message-ID: <876418htvs.fsf@hariken.mwolson.org>
References: <87bqbklu5r.fsf@hariken.mwolson.org>
	<871wcglqrg.fsf@hariken.mwolson.org>
	<7vps00ivgh.fsf@gitster.siamese.dyndns.org>
	<87hclck6qy.fsf@hariken.mwolson.org>
	<7vd4w0iqd5.fsf@gitster.siamese.dyndns.org>
	<87lka4cllp.fsf@hariken.mwolson.org>
	<20071015203523.GA4428@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 01:38:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhYpV-0000IC-1I
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 00:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907AbXJOWyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 18:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755696AbXJOWyT
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 18:54:19 -0400
Received: from mailhub247.itcs.purdue.edu ([128.210.5.247]:44737 "EHLO
	mailhub247.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754000AbXJOWyP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 18:54:15 -0400
Received: from ip6-localhost (host-212-116.inlacol.clients.pavlovmedia.com [66.253.212.116])
	(authenticated bits=0)
	by mailhub247.itcs.purdue.edu (8.13.7/8.13.7/auth-smtp.purdue.edu) with ESMTP id l9FMri8V026627
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
	Mon, 15 Oct 2007 18:53:52 -0400
Received: from mwolson by ip6-localhost with local (Exim 4.67)
	(envelope-from <mwolson@hariken.mwolson.org>)
	id 1IhYoh-0000aq-Ky; Mon, 15 Oct 2007 18:53:43 -0400
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEU1QytIVTlZY0dqc1N6
 hGGJl3qZpZCtuKXsjxzFAAACW0lEQVR42l2UXXrqIBCGk67Aoe29Ac4CTPDcGwZ73wLdQDOuQLP9
 8wHG9hT1Mc6bb/5jp7Xed92TVrqeCYfKRVc+XdfDbqbJ8TixG1UDu2a3xkf2H+z+A6Qn7Xk71AA8
 kdJmZg4xpcTshgr2JQSurAswhwDFYQN9r4yxx1BIQqBTBbvqahw9hxRSLOBdFVA89TTOvgSoMaLf
 ABTWOg5Z8lLRNyD7x4WSVHU1DZurThn2HI9Oa561JhTSDUWxq64YqRlmrcdhA73y3rmJY1okotDT
 NzDO2XNGZPnS7A4b6NQ8foQFN2eJmEBR7Du1Q/DRh7R4O50BrGmu0F8i49Iya+ScvtDNqkADB8zD
 pwU9wTu9c8msdNYOO0JvYYyREd9xBOh7zSNc2WMZUYzIDHOpU0Kxe5o9o0eccsr5mNLcwHhC8DoM
 SQkJ5wbUxAdlbDELEpDbclc8sT2gV2HJIrj/si7hDgzPpY4sqxTV+pWkgt7EGesDIFWUnGuK7pkn
 erZoieCVZPGcG3jCJimLwS7IVZY4R3mvoNfzoCfOF0mIG1nna+TadAxzgF5u0b3JTaxcmZtCF1dn
 WSOv63oNl4U3BQCLXOQKWZIHUBWcUci6iuTL7eMOelVAKfp+NkA0kOElN3BbV26AiGZsXEqfa0EQ
 NtATvTAKCeHh7AEEi4knM6S3HwB2eo1zeZQ5fDbgNkCpbEwh8HUTqYDqwUhIG2NQ/k2WH+CVB9LK
 aINy0EeAvgF6KRK0wIaPiX8CioRNpQF7X/8EOnoAPpUvrX8DED7t8B/Bv8ErfnpSfxv4B9rx7BDd
 lxXRAAAAAElFTkSuQmCC
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEUdGhcLKBUZHDVUWkg5
 Z5SNmsK0mH1pvs6V0rju3cNH6LyDAAACAklEQVR42oWUwW7bMAyGKbkJ1psln3aTFV9yk+zOmI5p
 ctl5p946GDHmR9hbDA1igG87UorloMVQAjYcfvp/mgxhOP0n4HPwTNE0H4FN0bwDStdKKc3oHaBg
 pLImgYNKoaXW9gOoFShBds0dSOetkbYWtyoJaEoLT7dSq1qvwNfad1XlfeerqtJPGRyU31Xe+c51
 qqt1k4Hi08qICnwrtH5YwJErlyVw1AJWEF+WkoaJLKXNQMTzO5eYlNkqmsC3KJB0ZUXMm5FSjp+y
 1TEVPtPVggQZh5JqgALXzVRmkL1bwQnKMBTbaeyKtsef9k5R/undBnEeXDENkMFRAZ3eIuLF9dMr
 xPmmBsuALhCY3YSvIJu184DDhEwQf60KzyCHA5mtyvLrHZBSPiWgSvUl56mbrKCZbzO4UO/twwJU
 kcHfVXGkoQvOXflGbwt1E8GBtgnCAnjyegGqhCqXILIqSlC/EceJuwAjTAJeAf0fVRaArRdACiF6
 zvfsFNcXuD9WwNDj3J9jDb0AQb8er2PXjwPSotS3GrTPABu8jBQD8gIlK+qPnn8sgIZ+s0og4JXB
 GY3ZtklxUNCBDEkR0Mj9/JyAKMh4BfCI1wRossbs8dJRhDm6RuB3DJLC4ZUBbxYp5B7touCZhDf+
 DMCR7i/WbNbphjaCk322wbriJYE3EN8j+AdHTQpcw5C5IgAAAABJRU5ErkJggg==
X-Hashcash: 1:20:071015:git@vger.kernel.org::laH9kpam1TOWlZZg:00000000000000000000000000000000000000000023sG
X-Hashcash: 1:20:071015:peff@peff.net::KkvxWk5EMi1t4o2O:00003pOW
X-Hashcash: 1:20:071015:gitster@pobox.com::l5S50806nhWJ5HZJ:000000000000000000000000000000000000000000009LeC
In-Reply-To: <20071015203523.GA4428@sigill.intra.peff.net> (Jeff King's
	message of "Mon\, 15 Oct 2007 16\:35\:23 -0400")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.50 (gnu/linux)
X-PMX-Version: 5.2.1.279297
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61050>

Added a new section beneath "On Automatic following" called "On
Backdating Tags".  This includes an explanation of when to use this
method, a brief explanation of the kind of date that can be used in
GIT_AUTHOR_DATE, and an example invocation of git-tag using a custom
setting of GIT_AUTHOR_DATE.

Signed-off-by: Michael W. Olson <mwolson@gnu.org>
---

Jeff King <peff@peff.net> writes:

> On Mon, Oct 15, 2007 at 01:51:30PM -0400, Michael Olson wrote:
>
>> +On Backdating Tags
>> +~~~~~~~~~~~~~~~~~~
>> +
>> +If you have imported some changes from another VCS and would like
>> +to add tags for major releases of you work, it is useful to be able
>
> s/you/your/

Fixed; thanks.

 Documentation/git-tag.txt |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 990ae4f..5cc9da4 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -214,6 +214,27 @@ having tracking branches.  Again, the heuristic to automatically
 follow such tags is a good thing.
 
 
+On Backdating Tags
+~~~~~~~~~~~~~~~~~~
+
+If you have imported some changes from another VCS and would like
+to add tags for major releases of your work, it is useful to be
+able to specify the date to embed inside of the tag object.  The
+data in the tag object affects, for example, the ordering of tags
+in the gitweb interface.
+
+To set the date used in future tag objects, set the environment
+variable GIT_AUTHOR_DATE to one or more of the date and time.  The
+date and time can be specified in a number of ways; the most common
+is "YYYY-MM-DD HH:MM".
+
+An example follows.
+
+------------
+$ GIT_AUTHOR_DATE="2006-10-02 10:31" git tag -s v1.0.1
+------------
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>,
-- 
1.5.3.4
