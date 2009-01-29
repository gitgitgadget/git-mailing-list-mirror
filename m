From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: "git gc" removes ".git/refs/heads/master".
Date: Thu, 29 Jan 2009 19:51:17 +0000 (UTC)
Message-ID: <glt1bl$mal$1@ger.gmane.org>
References: <83c97f59a5a5e59f908f3fc125d26adb@lunox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 20:52:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LScwa-0002fR-Vx
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 20:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbZA2Tvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 14:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbZA2Tva
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 14:51:30 -0500
Received: from main.gmane.org ([80.91.229.2]:55921 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441AbZA2Tva (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 14:51:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LScv9-0006SW-AF
	for git@vger.kernel.org; Thu, 29 Jan 2009 19:51:27 +0000
Received: from u-4-224.vpn.rwth-aachen.de ([137.226.100.224])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 19:51:27 +0000
Received: from heipei by u-4-224.vpn.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 19:51:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: u-4-224.vpn.rwth-aachen.de
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107723>

On 2009-01-29, Bernd Lommerzheim <bernd@lommerzheim.com> wrote:
> maybe I found a bug in git. When I execute "git gc" in my local repository,
> git removes the file ".git/refs/heads/master". Is this an intended behavior
> (but why?) or is that a bug?

Good question, and I just found that one out myself. The ref has been 
"packed" (git help pack-refs) and can be found in .git/packed-refs. Hope 
that answers your question.

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
