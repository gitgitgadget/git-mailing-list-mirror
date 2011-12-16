From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [BUG] attribute "eol" with "crlf"
Date: Fri, 16 Dec 2011 21:09:55 +0100
Message-ID: <20111216200955.GA8499@angband.pl>
References: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
 <vpqr504wf70.fsf@bauges.imag.fr>
 <CAN0XMOJFCwORt_VaddgeeCNp3S-nm8DxYDPDyPCsVngRhuEP6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 21:10:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbe6j-0005pq-9D
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 21:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760673Ab1LPUKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 15:10:05 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:34236 "EHLO
	tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760447Ab1LPUJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 15:09:59 -0500
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.72)
	(envelope-from <kilobyte@tartarus.angband.pl>)
	id 1Rbe6N-0002h3-CF; Fri, 16 Dec 2011 21:09:55 +0100
Content-Disposition: inline
In-Reply-To: <CAN0XMOJFCwORt_VaddgeeCNp3S-nm8DxYDPDyPCsVngRhuEP6A@mail.gmail.com>
X-Junkbait: adolf@angband.pl, zareba@angband.pl
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@tartarus.angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187313>

On Fri, Dec 16, 2011 at 07:28:22PM +0100, Ralf Thielow wrote:
> > What behavior would you have expected?
> 
> I've expected that git doesn't change the line endings
> because it's already CRLF.

And how exactly can it change the file back the way it was?
s/\n/\r\n/g is roundtrippable, s/\r?\n/\r\n/g is not.

-- 
1KB		// Yo momma uses IPv4!
