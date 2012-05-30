From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: How to find all the commits that comprise a branch?
Date: Wed, 30 May 2012 19:39:28 +0200
Message-ID: <CAMP44s2kEMK8ik2NTiP4uiN4FPWFNYNJfY5qh5QE_hRH2AiNYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 19:39:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZmru-0002Af-EO
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 19:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075Ab2E3Rja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 13:39:30 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51726 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755976Ab2E3Rj3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 13:39:29 -0400
Received: by lahd3 with SMTP id d3so57116lah.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=kQ0hx6gyjyhokZIKlvwn26wL4eLDK/+CoTr69Zly9hU=;
        b=r31t9VpC/y577rdYXwpIjbA1zv3Rlxk8fFre9Xp4IV0gubl7LCdayT/b2i+7uYP+Nr
         OrYy0qi27pJEYtS2OwB4XcQ2cnUXysFtTJ/9EbiD+tpw/c19OZb0wuvsyHLnoav4LYgS
         VD3CaekDq7HZDlMVN79Opk4eBvsFNr31zCVfYfOrJNW6lEgpTfEGx0jH9NMEcGWzL9me
         fzZ1TQnrOYyfzOSsq88Zn4g2F9coFFzcCEjkvBpdiXIQBvvGfkXRuWQOZMVKt/Qd7oA5
         yVrfIKgbzyhZrgct70OQwAnC/ANrNKRP0wHHQv57iZQ66cQsG41S8RHUlgyYKL+HzLTh
         TbKQ==
Received: by 10.112.82.165 with SMTP id j5mr7316883lby.50.1338399568105; Wed,
 30 May 2012 10:39:28 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 30 May 2012 10:39:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198825>

Hi,

Basically what I want to do is:

 % git log branch ^<any-other-branch>

IOW; all the commits were 'git branch --contains' would show 'branch'
and nothing else.

Is there any easy way to do that?

Cheers.

-- 
Felipe Contreras
