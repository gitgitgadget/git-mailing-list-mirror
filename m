From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/4] Documentation: explain push.default option a bit
 more
Date: Sat, 21 Apr 2012 07:01:46 +0200
Message-ID: <4F923F3A.7050701@alum.mit.edu>
References: <vpqfwbye9re.fsf@bauges.imag.fr> <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr> <1334933944-13446-2-git-send-email-Matthieu.Moy@imag.fr> <20120420201357.GA13103@sigill.intra.peff.net> <xmqq62cum6tf.fsf@junio.mtv.corp.google.com> <4F922ECC.4040103@alum.mit.edu> <xmqqpqb1zpzz.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 07:02:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLSSc-0005nB-BD
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 07:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab2DUFCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 01:02:09 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50947 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab2DUFCH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 01:02:07 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.140] (p4FC0D9A1.dip.t-dialin.net [79.192.217.161])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3L51k8V026230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 21 Apr 2012 07:01:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <xmqqpqb1zpzz.fsf@junio.mtv.corp.google.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196040>

On 04/21/2012 06:08 AM, Junio C Hamano wrote:
> Michael Haggerty<mhagger@alum.mit.edu>  writes:
>> "Atomic" implies that either the whole push succeeds or the whole push
>> fails, and that readers will never see part of the push.
>
> Oh, I didn't mean "atomic" in that strict sense.  After all this was a
> description at the workflow level--what the human user perceives.

That's what I suspected.

Given that the word "atomic", for technical people, has a strict meaning 
that is not met here, and for non-technical people probably only means 
"nuclear", I suggest that the word be avoided in this explanation.  Perhaps

>      * `matching` - push all branches having the same name in both ends.
>        This is for those who prepare all the branches into a publishable
>        shape and push them out atomically, and suitable when pushing to a
>        non-shared repository. [...]

could be changed to

>      * `matching` - push all branches having the same name in both ends.
>        This allows those who prepare all the branches into a publishable
>        shape to push them out to a non-shared repository with a single
 >        command. [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
