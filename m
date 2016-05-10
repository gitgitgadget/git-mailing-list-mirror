From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] Work on t3404 in preparation for rebase--helper
Date: Tue, 10 May 2016 15:59:59 +0200 (CEST)
Message-ID: <cover.1462888768.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 16:00:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08Ct-0007Rt-12
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbcEJOAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 10:00:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:53651 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbcEJOAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:00:07 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MLi1v-1b0PJk3U2d-000qOW; Tue, 10 May 2016 15:59:59
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ntD5MGLlfiD6ssZ/IRs6Q54NBzmnhsWUwWSGrzEeTP7UT6IgTmE
 jcl6RvkdmPzesCPDSuhwKkxuM/k8zyidX7OZxj+We+WNHPVVaHJZ5QzQ6GruFCtHuwJd6av
 S36BdjljyU3sD+1xqPJ3xR3JHhYCz5rRWVgBVuKeBgHMs3kAmL6lwTOgNL6nvrV5EPhfilN
 ZY82DxH4t1tOObQrNPqDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JWsZ4IvRBfc=:onjhGk/6IxLddSdRjRHtE2
 df84Lk9AueVCuWUgAgAf3hUy50yHvfbz+FHi6XahRCcqBuG7GOKF9S6empuH5SvYs0G4s9qLB
 xE1WdLMPFPUiQ46pTp3wnefNclyhpffQ9amMpEaYsjkUUDjNDTAUD1YgZI2Y/ha9d3ID/D8nL
 BF4Vix1TuK8r7MchHjzunN+5Hu7qQlWqCIEyKYk3K9pdhCnsptRMkpKObP3DIRQlbD8iyp9rF
 8hwlm5fCzsvdAVtINpezXIeLWHg4jKIvDedOAD0NXCHJbH2G8WeCyzFbpzKzqWLB+ql+IXZAQ
 aFi9wuCIcOF+QJsZlQmu0Q68I6yXJTpqXH2iBqv6kPJNMS6bZgP6YShoAUXve5tpGkdAX3+CZ
 oN9JlQFtbmps0bSbqQcnWnQf10lQMl8r4jbRV3Lezw66WiIU08101s86leFvBVUfg92aIDpCS
 WYDeeABgjMkIYK8iGFixDpoOXtcDbvThItE7LxVT0P7GwmLQnszlysFe7eocWwQLUqZV0TKZ/
 gMZ7Z45gwJVXoi/QGBZwIxym5Qz74H56UabKCACZk9fjyPkt07KzygjUqQxtbOWrMQ4K/Tt6S
 E+5llw+xyv0m2bAEDYrp1DsB3L8z19G6lRbzTWfnSrDLop+nLpBPLAWBi5NEjyEQZr3Kd0sJI
 0Ns/XlEl+iciJx/EiFNe7GXVfo2Rsm1TDwLNDWbyBH3aiRLn0LmR92o2jUZ6tAeQII3ns7Giw
 cW0B1hrvGE5HY97puCHyFgydnZE58NzrQmDwHLo4QlrY7J6HeocLAUIYNYvJgJiSj9DA0n3B 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294132>

This is the first patch series in preparation for a faster interactive
rebase.

It actually only prepares the test script that I mainly used to develop
the rebase--helper, and the resilience against running with -x proved to
be invaluable in keeping my sanity.


Johannes Schindelin (2):
  t3404: fix typo
  t3404: be resilient against running with the -x flag

 t/t3404-rebase-interactive.sh | 69 ++++++++++---------------------------------
 1 file changed, 16 insertions(+), 53 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/t3404-fixes-v1
-- 
2.8.2.463.g99156ee
