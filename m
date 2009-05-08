From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tests in Cygwin
Date: Thu, 07 May 2009 17:00:11 -0700
Message-ID: <7vmy9ocvlg.fsf@alter.siamese.dyndns.org>
References: <83prfbhasp.fsf@kalahari.s2.org>
	<4A01E64C.7050703@SierraAtlantic.com>
	<7vvdoet13g.fsf@alter.siamese.dyndns.org>
	<4A028A0A.5070003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Don Slutz <Don.Slutz@SierraAtlantic.com>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 08 02:00:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2DVl-0006Fa-EY
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 02:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbZEHAAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 20:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbZEHAAN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 20:00:13 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54401 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbZEHAAM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 20:00:12 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090508000011.TRGU18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Thu, 7 May 2009 20:00:11 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id oo0B1b0084aMwMQ04o0BkE; Thu, 07 May 2009 20:00:11 -0400
X-Authority-Analysis: v=1.0 c=1 a=fv-XvKvnAAAA:8 a=gVtDIN_BvJ0EU6sgJhwA:9
 a=b9bcgeQIbnSO_IiZL4jqlgDTnCwA:4 a=l9rlz7MJbUIA:10
X-CM-Score: 0.00
In-Reply-To: <4A028A0A.5070003@viscovery.net> (Johannes Sixt's message of "Thu\, 07 May 2009 09\:13\:14 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118544>

Johannes Sixt <j.sixt@viscovery.net> writes:

> You could squash in the patch below, where I chose to concatenate
> tokens with '+' because I dislike the extra quoting that is otherwise
> necessary at the call site. The downside is that it plays games with
> IFS, which you might find too ugly and not worth it. It's your call.
>
> BTW, I didn't dare test this as root on my production system; I'll do
> that later today elsewhere.

Heh, thanks.

I think my "how about this" weather-balloon patch with your updates should
be split into a three-patch series:

 (1) t/README update to cover the Prerequisite system; we should have done
     this when we applied the feature;

 (2) Addition of multiple-prerequisite feature (and documentation updates
     to t/README);

 (3) Addition of SANITY prerequisite that uses (2).

I personally do not think "SANITY" is such a good thing to look for (I'd
rather make the test fail saying "do not run me as root"), but that is a
separate issue.
