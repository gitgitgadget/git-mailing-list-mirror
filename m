From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: Git setup for kernel in-house development + mainstream
 submissions?
Date: Mon, 2 Feb 2009 07:26:40 +0000 (UTC)
Message-ID: <gm677g$3io$2@ger.gmane.org>
References: <49861363.1000104@aster.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 08:31:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTtHH-0000Nu-Dt
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 08:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbZBBHaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 02:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbZBBHaG
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 02:30:06 -0500
Received: from main.gmane.org ([80.91.229.2]:34654 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbZBBHaF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 02:30:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LTtFq-0000vN-Lj
	for git@vger.kernel.org; Mon, 02 Feb 2009 07:30:02 +0000
Received: from u-6-153.vpn.rwth-aachen.de ([137.226.102.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 07:30:02 +0000
Received: from heipei by u-6-153.vpn.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 07:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: u-6-153.vpn.rwth-aachen.de
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108059>

On 2009-02-01, PaV <pav@aster.pl> wrote:
> I would like to kindly ask for suggestions how to setup and use git in a
> company that performs in-house kernel development (drivers mostly) for
> its own devices and would like to occasionaly submit patches for mainstream.
> [...]
> So the proposed setup might be:
> (1) - in-house devel could be done on separate branches for each driver

Do you really want to have separate drivers in the same git repository? 
Do these drivers share so much code and depend on each other that this 
would be necessary? If not I'd suggest you think about separate git 
projects for each driver, unless there is a compelling reason against 
it.

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
