From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: t9155 fails since "git-svn: fix fetch with deleted tag" with svn
 < 1.5
Date: Thu, 19 Aug 2010 18:57:24 +0200
Message-ID: <4C6D6274.90009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Thu Aug 19 18:57:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om8Qq-0006uH-Se
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 18:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795Ab0HSQ51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 12:57:27 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:50468 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701Ab0HSQ50 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 12:57:26 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id 1F89C15DD52BE;
	Thu, 19 Aug 2010 18:57:25 +0200 (CEST)
Received: from [93.246.46.190] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Om8Qf-0001Kl-00; Thu, 19 Aug 2010 18:57:25 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/L0E7+ftoFLKDl9sCmb5iZwsJzGErE2MNka6h3
	dWYXt/k01XfGW6+KrLrtVKlA73fUKhv5X7K8H2P1f+im8DqgkO
	ARe6IrgyDzKuf1B2H3Ow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153943>

t9155 fails on current next when running the testsuite on a Fedora
Core 7 system. The reason is that FC7 comes with svn 1.4.4, while
in commit 3235b70 the --parents option was introduced into t9155
which was added in svn 1.5.

What minimum svn version is required for git svn? I didn't find any
information about that, but I might have overlooked something ...
