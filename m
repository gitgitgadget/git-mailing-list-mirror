From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC Redux] strbuf: Add method to convert byte-size to human
 readable form
Date: Fri, 19 Sep 2008 13:32:43 -0700
Message-ID: <7vzlm3ri50.fsf@gitster.siamese.dyndns.org>
References: <1221279997-9336-1-git-send-email-marcus@griep.us>
 <48D3CBBA.8060507@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Fri Sep 19 22:34:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgmfv-0007eT-6r
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 22:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbYISUcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 16:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbYISUcv
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 16:32:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329AbYISUcv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 16:32:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EDDC3637E3;
	Fri, 19 Sep 2008 16:32:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 03D5A637DD; Fri, 19 Sep 2008 16:32:46 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 207C7AD0-868A-11DD-8F23-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96314>

Marcus Griep <marcus@griep.us> writes:

> If there is no comment on this, Junio, would you be ok accepting this as
> a patch, even as a feature-branch on pu or next?

We (collectively as the development community) should be doing better than
that.  "No comment" should not mean "no objection with huge silent
support".  "No comment" simply means "no support".

If I recall correctly (I did read the patch myself when it was posted), I
did not spot anything glaringly wrong in it, but I have to go back to make
sure if we are going to queue this in 'next'.

I have deliberately been trying to keep myself from commenting on series
that I have read.  The thing is, it seems to me that that seeing my
comments on the list somehow discourages others from reviewing and
commenting, and I would really like to see people on the list to review
and help improve more patches from others.
