From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Fri, 08 May 2009 01:41:41 -0700
Message-ID: <7vprek0ywq.fsf@alter.siamese.dyndns.org>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
	<7v7i0scvcf.fsf@alter.siamese.dyndns.org>
	<op.utlq3vgx1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Matthias Andree" <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 08 10:41:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2LeQ-0008Vz-4k
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 10:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbZEHIlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 04:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbZEHIlm
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 04:41:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58406 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbZEHIll (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 04:41:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090508084141.KEZZ17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 May 2009 04:41:41 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id owhh1b0084aMwMQ04whhBE; Fri, 08 May 2009 04:41:41 -0400
X-Authority-Analysis: v=1.0 c=1 a=Sb75fb6s3KMA:10 a=5qu_ZHnkUusA:10
 a=RaOJZ6uzv1o2ujGCPZQA:9 a=oDte5ZuQESyj-LBf-TvZx9oWKHwA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <op.utlq3vgx1e62zd@merlin.emma.line.org> (Matthias Andree's message of "Fri\, 08 May 2009 10\:27\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118588>

"Matthias Andree" <matthias.andree@gmx.de> writes:

>> Interesting.  I wonder if you need the change to the Makefile.
>>
>> As long as GIT-VERSION-GEN notices that you have a freshly built git
>> available (test -x) and uses it, falling back to whatever on the PATH, it
>> would not have to touch GIT-VERSION-FILE, no?
>
> Hi Junio,
>
> ... Let's not introduce second-guessing into
> the script....

Fine then.  Or you could just append "." to the $PATH ;-)
