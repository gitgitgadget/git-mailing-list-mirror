From: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Subject: git blame --follow
Date: Tue, 15 Mar 2011 16:44:44 +0100
Message-ID: <201103151644.44360.wolfgang@rohdewald.de>
Reply-To: wolfgang@rohdewald.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 16:43:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzWPQ-0002pE-KV
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 16:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758092Ab1COPni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 11:43:38 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:58238 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758087Ab1COPng (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 11:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1300203815; l=432;
	s=domk; d=rohdewald.de;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Reply-To:
	From:Subject:To:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=wF0mivf9HTbd+qOtvZ2XYIB2ZcE=;
	b=pB/gB/ax70djT/Qoey3Kn3HWcGbsvBF+g7QII2uGF+gQTpVoZO/YaME/2ZkwTIPrkel
	j5OOTPmzZoTrB6ckte3w8J2mmbH+WdaqyHqHRfdouN2CQlRbunCS9pD0lY8+2ONchXIv2
	s7ofURoR6A94Dskyfeu4/THtUJFGSQ8m16Q=
X-RZG-AUTH: :O2MIc0epdfgAjoV+frHI3UhxNCLBO5P+YS73lHhJYRD2uAuzaM+5N8MTpuriRg==
X-RZG-CLASS-ID: mo00
Received: from i5.rohdewald.de (p5B3E0509.dip0.t-ipconnect.de [91.62.5.9])
	by post.strato.de (mrclete mo42) (RZmta 25.8)
	with ESMTPA id J073aan2FF4Smz for <git@vger.kernel.org>;
	Tue, 15 Mar 2011 16:43:35 +0100 (MET)
Received: from i5.localnet (localhost.localdomain [127.0.0.1])
	by i5.rohdewald.de (Postfix) with ESMTP id E1FA1EA14B7
	for <git@vger.kernel.org>; Tue, 15 Mar 2011 16:44:44 +0100 (CET)
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	shortcircuit=no autolearn=unavailable version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on i5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169075>

git log --follow filename

shows the full history, while

git blame --follow filename

blames everything to the latest commit (which was
a file rename)

it would be nice if --follow were also supported by
git blame. Actually git blame accepts --follow without
an error message, it just ignores it. git help blame
does not mention --follow

using latest git from master
git version 1.7.4.1.234.ga3513

-- 
Wolfgang
