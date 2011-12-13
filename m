From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Tue, 13 Dec 2011 20:05:50 +0100
Message-ID: <hbf.20111213g43t@bombur.uio.no>
References: <hbf.20111211x512@bombur.uio.no>
	<1kc5m38.m71ik21ytxkhbM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gelonida@gmail.com (Gelonida N), git@vger.kernel.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Tue Dec 13 20:06:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaXfr-0003ZS-Fb
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 20:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab1LMTFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 14:05:54 -0500
Received: from mail-out1.uio.no ([129.240.10.57]:55288 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750Ab1LMTFy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 14:05:54 -0500
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RaXfj-0001yV-5I; Tue, 13 Dec 2011 20:05:51 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx1.uio.no with esmtp  (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RaXfi-0005Pl-PV; Tue, 13 Dec 2011 20:05:51 +0100
Received: by bombur.uio.no (Postfix, from userid 2112)
	id 5FB241158; Tue, 13 Dec 2011 20:05:50 +0100 (CET)
In-Reply-To: <1kc5m38.m71ik21ytxkhbM%lists@haller-berlin.de>
X-Mailer: VM 7.19 under Emacs 23.1.1
X-UiO-Ratelimit-Test: rcpts/h 3 msgs/h 1 sum rcpts/h 3 sum msgs/h 1 total rcpts 2020 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RP_MATCHES_RCVD=-2.023,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 0B6ADBA98B23D726FE227E4E10F40D1D3DF2017E
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 1 total 868 max/h 5 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187046>

Stefan Haller writes:
>Hallvard B Furuseth <h.b.furuseth@usit.uio.no> wrote:
>> Local branches can track each other.  So the script needs to toposort
>> the branches, or to loop until either nothing was done or an error
>> happened.  (The latter to prevent an eternal loop on error.)
> 
> Is this just theoretical, or are there real use cases for this? What
> would be a workflow with such a local tracking branch?

Personally I don't care much, I just noted that the script did not
match the question in the subject line.

-- 
Hallvard
