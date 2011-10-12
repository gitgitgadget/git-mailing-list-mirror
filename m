From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Re* [PATCH v3 19/22] resolve_ref(): emit warnings for improperly-formatted
 references
Date: Wed, 12 Oct 2011 04:56:42 +0200
Message-ID: <4E9501EA.8060409@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu> <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu> <20111011161652.GA15629@sigill.intra.peff.net> <7vr52jfm8i.fsf@alter.siamese.dyndns.org> <7vmxd7flkw.fsf@alter.siamese.dyndns.org> <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org> <20111011230749.GA29785@sigill.intra.peff.net> <7vehyjcckp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 04:57:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDp0L-0004fy-Tg
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 04:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716Ab1JLC5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 22:57:08 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45875 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab1JLC5H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 22:57:07 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEC4A3.dip.t-dialin.net [84.190.196.163])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9C2ugA1028614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Oct 2011 04:56:42 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vehyjcckp.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183351>

On 10/12/2011 01:50 AM, Junio C Hamano wrote:
> It starts sounding like that the ill-thought-out warning should be ripped
> out regardless of what other things we do.

ISTM that the warning is proving its worth already by illuminating some
questionable practices (treating any file in $GIT_DIR as a potential
reference) :-)

However, it might be that fixing 100% of the questionable practices is
too much work.  In that case, I suggest that the warning not be ripped
out altogether, but rather that the warning only be emitted for invalid
references whose names start with "refs/".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
