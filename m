From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: git-repack & big files
Date: Tue, 11 Jan 2011 14:48:05 -0500
Message-ID: <4D2CB3F5.106@cfl.rr.com>
References: <1294731438.3300.973.camel@voubian.casa>	 <4D2C7AA9.1020506@cfl.rr.com> <1294772603.3435.67.camel@voubian.casa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pietro Battiston <me@pietrobattiston.it>
X-From: git-owner@vger.kernel.org Tue Jan 11 20:47:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PckBm-0007fm-6r
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 20:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637Ab1AKTrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 14:47:25 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:55288 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378Ab1AKTrY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 14:47:24 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=pepdxKapwHuwCZNFD5uob2wvham6E+RljB0uXw08FdQ= c=1 sm=0 a=IkcTkHD0fZMA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=Dz5xeKug-8cZugKJxd8A:9 a=pRp3DInPaRQOGySiC_IKkfNFV-gA:4 a=QEXdDO2ut3YA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:2603] helo=[10.1.1.235])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id 66/48-19545-AC3BC2D4; Tue, 11 Jan 2011 19:47:22 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <1294772603.3435.67.camel@voubian.casa>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164981>

On 1/11/2011 2:03 PM, Pietro Battiston wrote:
> That's unfortunate - I think I prefer to split my mailboxes than to
> loose many of the nice features git provides. But thanks a lot for the
> suggestion.

I'm curious what features of git you find helpful for this purpose.  The
history log doesn't seem useful at all.  Generally mail is only added,
and sometimes deleted, never changed, so it also does not seem useful to
keep multiple revisions.  If you really want that though, rdiff-backup
will do that and keep the old revisions delta compressed.

I use Maildir instead of mbox and do a nightly incremental backup of the
whole system with dump, so any mail I might loose by accident I can pull
from the backup if it is older than a day, and I never delete mail.
