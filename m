From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Makefile: add commented out 's for Emacs here, too
Date: Sat, 30 May 2009 12:07:30 -0700
Message-ID: <7vr5y6z9xp.fsf@alter.siamese.dyndns.org>
References: <1243289231-32500-1-git-send-email-naesten@gmail.com>
	<1243289231-32500-2-git-send-email-naesten@gmail.com>
	<1243289231-32500-3-git-send-email-naesten@gmail.com>
	<200905301505.38016.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Bronson <naesten@gmail.com>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sat May 30 21:09:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MATvb-0007cy-Pz
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 21:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445AbZE3THb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 15:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbZE3THa
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 15:07:30 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42906 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbZE3TH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 15:07:29 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090530190731.ELGP2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Sat, 30 May 2009 15:07:31 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id xv7W1b00B4aMwMQ04v7W7B; Sat, 30 May 2009 15:07:30 -0400
X-Authority-Analysis: v=1.0 c=1 a=iMutr_JqIw0A:10 a=Axlyvr_QWucA:10
 a=ydqd3Hvr2R6zATG_w7MA:9 a=HmYMxQW4oI-ltCmBNb4A:7
 a=NWUTIIoFvE4yoaxnwkr5VNFFZjgA:4 a=5KVauyKsRKMA:10 a=ig5HIMzj6DG0FPxy:21
 a=mGpakk-R8Vmdwb5U:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120363>

Markus Heidelberg <markus.heidelberg@web.de> writes:

>> +# unconfuse Emacs: '
>> +
>> +# The above comment is in case there is an odd number of _SQ
>> +# definitions above, since they seem to confuse Emacs. If there is an
>> +# even number of such definitions, it does no harm, since emacs
>> +# doesn't recognize string delimiters inside recognized comments.
> ...
> I think this is way too much comment and would prefer none at all. I
> also would remove the global 4-line comment.

I personally do not like contaminating our source files with this kind of
magic crufts just to please broken tools, be they emacs or vim.  I would
hate them even more if they are not clearly commented why they exist for
two reasons.

 (1) without clear instructions ("odd number of ..." is not quite enough),
     people who do *not* use broken tools cannot keep them up-to-date when
     they make modifications;

 (2) when broken tools are finally fixed, nobody would remember why the
     magic crufts exist, and they will end up staying in the source for a
     long time.
