From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [PATCH] git-cvsimport: fix initial checkout
Date: Fri, 14 Mar 2008 12:27:49 +1300
Message-ID: <47D9B875.50305@catalyst.net.nz>
References: <1205435378-10411-1-git-send-email-marcandre.lureau@gmail.com> <47D9A836.9010601@catalyst.net.nz> <7vr6eew70a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc-Andre Lureau <marcandre.lureau@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 00:28:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZwqi-0008RR-Jc
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 00:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbYCMX15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 19:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbYCMX15
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 19:27:57 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:34658 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbYCMX14 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 19:27:56 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.113])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <martin@catalyst.net.nz>)
	id 1JZwpx-0002Su-Sy; Fri, 14 Mar 2008 12:27:49 +1300
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <7vr6eew70a.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77148>

Junio C Hamano wrote:
> Martin, it may not even be in $git_dir/refs/heads/$last_branch ;-)  The
> refs can be packed.

Yes. I was suggesting git-ref-parse to support packed refs, but this
slipped ;-)

> By the way, doesn't cvsimport fail when your HEAD is detached with this
> code?

Perhaps. Importing on a working repo with -i is a bit messy, and
detached heads may well break it. I'm not that conversant on how
detached heads look ;-)

> I always have cvsimport update the pristine upstream branch and rebase my
> work against it, so I never have the branch cvsimport updates checked
> out, and  for meit seems to work wonderfully (well, at least as wonderful
> as a workflow that involves any CVS in it could be).  I do not see a
> reason why it should not to work similarly well when my HEAD is detached..

sounds reasonable.



m

-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
NZ: +64(4)916-7224    MOB: +64(21)364-017    UK: 0845 868 5733 ext 7224
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
