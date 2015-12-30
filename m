From: Carlos Pita <carlosjosepita@gmail.com>
Subject: [bug] Graph log and orphan branches
Date: Wed, 30 Dec 2015 16:46:08 -0300
Message-ID: <CAELgYhe4u2qU0-+mBKGwf8CpdZ=MuWMFZmeOhojtdMQZ3-nfhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 20:46:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEMhd-0004Px-Lg
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 20:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbbL3Tqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 14:46:30 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:32801 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbbL3Tq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 14:46:29 -0500
Received: by mail-ob0-f177.google.com with SMTP id bx1so158158980obb.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 11:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=YsfNnwlwt+8B7EVNlS4L5xtFLQfIIP0uozJw54n+XB0=;
        b=ADdP4AMafUBeealO2hTX5XRtodQPoSZCwg1iylPrf8veIyB5MrXW66Zf18co46RHuE
         CMESpU4cY7DnhIcsEWeAnpqlGDo/vd/qw70HQ7b+kK/WxEsqiNCcGjP7Gwf7eHRSaUme
         qK2y0lDeZyncq1Ii7VgGC+xL18N1pZnVfZVnWybCr9Kn1pmcQIP+o+H3smMsJMIR6y3u
         +82Qni9jOK0yJepNuTajyXP6abO4t8CXhA3YglMOGfr6IbeXPVESUrWS/mljwT50gswb
         r3XuSYWnnTWOUtodu7LLJbYXJr9ByyjYXZ29IRITokrcQsAaqbsrX+pFoTvuKVLgGBGu
         kgXg==
X-Received: by 10.182.130.162 with SMTP id of2mr31642351obb.57.1451504788068;
 Wed, 30 Dec 2015 11:46:28 -0800 (PST)
Received: by 10.182.135.167 with HTTP; Wed, 30 Dec 2015 11:46:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283191>

Hi all,

the graph output of log show orphan branches in a way that suggests
they have a parent. See for example:

http://stackoverflow.com/questions/22541261/git-log-of-all-branchs-in-only-the-current-tree

I think this is a bug in the UI.

Cheers
--
Carlos
