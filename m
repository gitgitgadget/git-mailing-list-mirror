From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] http*: refactor (v3)
Date: Sun, 24 May 2009 14:28:16 -0700
Message-ID: <7vk546ry1b.fsf@alter.siamese.dyndns.org>
References: <20090524222101.3e6f0496.rctay89@gmail.com>
	<7veiueut97.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 24 23:28:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8LF2-0002Xb-BW
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 23:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbZEXV2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 17:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbZEXV2Q
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 17:28:16 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:49986 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbZEXV2P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 17:28:15 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090524212817.LRGT25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Sun, 24 May 2009 17:28:17 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id vZUG1b0084aMwMQ04ZUGWX; Sun, 24 May 2009 17:28:17 -0400
X-Authority-Analysis: v=1.0 c=1 a=qwdnp4Nz6bEA:10 a=7Sgdii_ML3EA:10
 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8 a=yOnJQWZ2N-3N1RGKUzQA:9
 a=ULg7L0ldB7cLrLDgIUgA:7 a=iZXgK1okKxx070v_ySLR1dBc444A:4 a=qIVjreYYsbEA:10
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <7veiueut97.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 24 May 2009 13\:43\:16 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119863>

Junio C Hamano <gitster@pobox.com> writes:

> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> Junio, I've reworked the patches after "http-push: fix missing "#ifdef
>> USE_CURL_MULTI" around "is_running_queue" in rc/http-push. (I thought
>> resending everything would clutter things up, but I could for your
>> convenience if you want me to.)
>
> Sending replacements like this while the series is only in 'pu' is
> perfectly fine as long as what patch I have in 'pu' are being replaced.  I

"... as long as it is clear what patches I have ..."; sorry for not
re-reading what I wrote before sending it out.

> can just drop everything between rc/http-push~11 to its tip and apply the
> new series.
>
> Thanks.
