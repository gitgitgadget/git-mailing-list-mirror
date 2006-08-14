From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 13:50:31 -0400
Message-ID: <44E0B7E7.6020207@garzik.org>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com>  <Pine.LNX.4.63.0608141415560.10541@wbgn013.biozentrum.uni-wuerzburg.de>  <9e4733910608140708i45e3d6day6b87676783fd6511@mail.gmail.com>  <Pine.LNX.4.63.0608141641330.28360@wbgn013.biozentrum.uni-wuerzburg.de>  <9e4733910608140915i728004c1p216bf3d74fcc6ab7@mail.gmail.com>  <Pine.LNX.4.63.0608140930380.14796@qynat.qvtvafvgr.pbz>  <ebq9tc$3gl$1@sea.gmane.org> <44E0AFCB.10908@garzik.org> <Pine.LNX.4.63.0608141033080.14796@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 19:50:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCgaF-00065X-59
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 19:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWHNRug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 13:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWHNRug
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 13:50:36 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:34204 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932493AbWHNRuf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 13:50:35 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GCga9-0002Zu-CW; Mon, 14 Aug 2006 17:50:33 +0000
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: David Lang <dlang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.63.0608141033080.14796@qynat.qvtvafvgr.pbz>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25371>

David Lang wrote:
> that would only tell you that what you have is garbage (and you need to 
> restore from backup(, useing a ECC costs some space, but lets you 
> recover from some errors without having to resort to backups.

ECC permits you to recover from very specific, very-limited-damage 
scenarios like bit errors.

On modern hard drives, single-bit data corruption is very very very rare 
(particularly since ECC is already employed on the platter).

	Jeff
