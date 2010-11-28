From: Matthew Ruffalo <mmr15@case.edu>
Subject: [RFC] Add diffstat width config option
Date: Sun, 28 Nov 2010 18:49:37 -0500
Message-ID: <4CF2EA91.9030205@case.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 00:55:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMr5w-0001uG-HB
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 00:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283Ab0K1Xzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 18:55:43 -0500
Received: from mpv1.tis.cwru.edu ([129.22.105.36]:61501 "EHLO
	mpv1.tis.cwru.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226Ab0K1Xzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 18:55:42 -0500
Received: from mpv7.TIS.CWRU.edu (mpv7.tis.cwru.edu [129.22.104.170])
	by mpv1.tis.cwru.edu (MOS 4.1.9-GA)
	with ESMTP id BEB22445
	for <git@vger.kernel.org>;
	Sun, 28 Nov 2010 18:49:42 -0500
Received: from mail-qy0-f182.google.com (mail-qy0-f182.google.com [209.85.216.182])
	by mpv7.TIS.CWRU.edu (MOS 4.1.9-GA)
	with ESMTP id OUP45433
	for <git@vger.kernel.org>;
	Sun, 28 Nov 2010 18:49:41 -0500
Received: by qyk36 with SMTP id 36so801602qyk.13
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 15:49:41 -0800 (PST)
Received: by 10.224.20.83 with SMTP id e19mr4805266qab.63.1290988179324;
        Sun, 28 Nov 2010 15:49:39 -0800 (PST)
Received: from [10.0.8.11] (cpe-184-56-209-12.neo.res.rr.com [184.56.209.12])
        by mx.google.com with ESMTPS id l14sm2779502qck.41.2010.11.28.15.49.38
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 15:49:38 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162367>

The diffstat --stat-width and --stat-namewidth options are
nice, but do not affect the width for merges (which would
be nice). I will shortly send three patches that add config
options 'diff.stat.width' and 'diff.stat.namewidth'.

I haven't written C code in a long time, and hopefully I
didn't introduce any bugs or deviate too far from the
established Git source code style. I look forward to any
comments.

Thank you,
Matt Ruffalo...
