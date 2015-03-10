From: "Mladen B." <mladen074@gmail.com>
Subject: Missing slot "unmerged"
Date: Tue, 10 Mar 2015 13:44:03 +0100
Message-ID: <CAKHLQpFPJS2rp-QswBSmO72yx253LZC-LTZCimk+f+un0tAWZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 13:44:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVJW5-0006rA-Su
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 13:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbbCJMoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 08:44:05 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33763 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbbCJMoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 08:44:04 -0400
Received: by iecvj10 with SMTP id vj10so13223157iec.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=KObtYHjKfVFfjEIVud8Bf0pNZC1ee7ugK7Ogzackrg0=;
        b=kCZ7jjevJELwOMyAa/tPtopSzEB8XA7eEj+HKhBRfYbOnOLic4agaL2oaXt73Mw0jo
         kFZvijMefwXzAsNZL6rVVnwgFGG9KM5ErR09xbrqoNbs9hRP+ZPiwHl0VY04G0RMrhlB
         Sz9eU4137+8CWVVygNN0hINImdKDISjT8FeFm+y0Oihj/2UTXeMWdMZRUew3xXLSTyiN
         DfMsW2v1Jo4+qrL3DvJZTlivdrP/hg49wzptyBiARXL2OWlO3WdA6VUuhopNP6ccdJt9
         o0wV72bC9YUp7tSxEWccDrkevQXmhMBaN0BzeXF+1v59Hu6t7oZI/BB5k0Sj0D4K9If8
         rufg==
X-Received: by 10.50.136.228 with SMTP id qd4mr83700612igb.13.1425991443745;
 Tue, 10 Mar 2015 05:44:03 -0700 (PDT)
Received: by 10.36.121.136 with HTTP; Tue, 10 Mar 2015 05:44:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265231>

Hi,

I noticed there is a missing <slot> named "unmerged" inside the
"color.status.<slot>" on the documentation page:
http://git-scm.com/docs/git-config

This color is used when "git status" command is performed during the
conflict in the rebase process.

M.
