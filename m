From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.6.1
Date: Fri, 26 Dec 2008 01:38:16 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngl8dc8.klo.sitaramc@sitaramc.homelinux.net>
References: <7v7i5odams.fsf@gitster.siamese.dyndns.org>
 <20081225114443.GD6115@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 02:41:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG1ht-0001d5-Vd
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 02:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbYLZBiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 20:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbYLZBiZ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 20:38:25 -0500
Received: from main.gmane.org ([80.91.229.2]:53599 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbYLZBiY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 20:38:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LG1eh-00043N-2I
	for git@vger.kernel.org; Fri, 26 Dec 2008 01:38:23 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 01:38:23 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 01:38:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103917>

["Followup-To:" header set to gmane.comp.version-control.git.]
On 2008-12-25, Heikki Orsila <shdl@zakalwe.fi> wrote:
> * What would be the probability for a single bit flip to corrupt the 
> repository?

> * And what is the situation where a single bit flip can not corrupt the 
> database?

These two questions are not specific to git; whatever
answers apply to sha1 also apply here.  Sha1 will always be
strong enough to detect any combination of random errors.
As for deliberate attacks, it is considered strong enough to
resist all but the most computationally intensive attacks
(the kind that require a worldwide effort or maybe NSA type
facilities).

> * When (which commands/functions) is error detection done?

"git fsck --full" will do it of course, but I'm not sure
what other operations also start off or end up doing a
check.
