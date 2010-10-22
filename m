From: Mathias Lafeldt <misfire@debugon.org>
Subject: [PATCH 0/3] GIT-VERSION-GEN improvements
Date: Fri, 22 Oct 2010 13:24:02 +0200
Message-ID: <4CC17452.8040606@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 13:24:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9FjK-0003hN-47
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 13:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab0JVLYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 07:24:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:56936 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab0JVLYG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 07:24:06 -0400
Received: from [192.168.2.102] (dslb-088-071-188-252.pools.arcor-ip.net [88.71.188.252])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LoMUn-1OgVgI3g8P-00fvwO; Fri, 22 Oct 2010 13:24:05 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
X-Provags-ID: V02:K0:bSRHrzEpLJyJmXGF4vgenxZEZVoBKyOTkdg6xitkbhO
 Cf4RdSI6Lp3sucjpCPuxxLkAJZT3LlJaoZgZvdG1NpuhVvTbz5
 cjAh9aZT9JowNyWLLQ2EkX3HgTsU7FAtxvpC6rGZwhbjIhBphi
 IZxOWa9ZqhOsuuX0WfR0O/4qIroYv0orqBsMU9H0TtgSh7twm8
 rVobcnJNqmk7khJ8tfX0l/qJZHcZ3S2p60UCMqfNRI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159677>

As the subject says, this patch series makes some improvements to the
GIT-VERSION-GEN script. In particular, it introduces the use of
"git describe --dirty", and fixes some minor style issues.

v3 adds two more patches to v2.

Mathias Lafeldt (3):
  GIT-VERSION-GEN: make use of git describe --dirty
  GIT-VERSION-GEN: tweak processing of version file
  GIT-VERSION-GEN: style nitpicks

 GIT-VERSION-GEN |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

-- 
1.7.3.2
