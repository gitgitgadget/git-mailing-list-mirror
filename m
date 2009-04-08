From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH v4 14/14] difftool/mergetool: refactor commands to use
	git-mergetool--lib
Date: Wed, 8 Apr 2009 07:40:38 +0100
Message-ID: <20090408064037.GA9372@hashpling.org>
References: <1239145213-76701-1-git-send-email-davvid@gmail.com> <200904080733.01030.markus.heidelberg@web.de> <7vtz4zr80v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: markus.heidelberg@web.de, David Aguilar <davvid@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 08:42:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrRUQ-0006RG-Kc
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 08:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761051AbZDHGkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 02:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760192AbZDHGkm
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 02:40:42 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:20574 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760819AbZDHGkl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2009 02:40:41 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEABfk20nUnw6U/2dsb2JhbADNO4N7Bg
Received: from fhw-relay07.plus.net ([212.159.14.148])
  by relay.pcl-ipout02.plus.net with ESMTP; 08 Apr 2009 07:40:39 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1LrRSg-00045b-2m; Wed, 08 Apr 2009 07:40:38 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n386edbH012430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 8 Apr 2009 07:40:39 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n386ec8m012429;
	Wed, 8 Apr 2009 07:40:38 +0100
Content-Disposition: inline
In-Reply-To: <7vtz4zr80v.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 8099986a695bd2cf6e9bb13310b00297
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116049>

On Tue, Apr 07, 2009 at 11:09:36PM -0700, Junio C Hamano wrote:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> > Looks good to me, after these last 2 issues are adjusted.
> > Maybe resend the whole series then, so that Junio can apply them easily?
> 
> Thanks.  I've replaced the series with the following applied on top of the
> 'master', but I won't be merging them to 'next' for tonight, I guess.

I feel I should be re-reviewing the mergetool patches, but while I
have sufficient time, it is usually at the weekend so I can't always
respond very rapidly.

I have been skimming this series, but most of the times that I thought
I could apply the series and have a thorough review, another comment
and re-roll has come through and I've decided to wait until it's
stable.

My slight concern is that this series has been changing very rapidly,
is everyone else happy that it is stable enough for merge into next?
Would you like my further input?

Charles.
