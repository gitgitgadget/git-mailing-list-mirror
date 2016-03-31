From: Romaric Crailox <romaric.crailox@gmail.com>
Subject: gitk and hook script
Date: Thu, 31 Mar 2016 19:06:39 +0200
Message-ID: <CACRny=SO+EpYZhb_hbyJiAcN=hGCeHR4znh7+uiBHgRuGih6yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 19:06:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alg3Q-0001DK-MT
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 19:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbcCaRGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 13:06:41 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33736 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbcCaRGk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 13:06:40 -0400
Received: by mail-io0-f173.google.com with SMTP id a129so113742649ioe.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 10:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=/YuN3X0a5K6xFNYlC3XCiwX2TxtWA81/NzgdO/OSXrs=;
        b=YrGZ5AArNLut8Jj/GSlvXu+YdNz9uv6MUJQTym2mjJF14GWcJsFSdjz1DSrxdP9XZf
         ln+2R4cyWN3PtKrzjl+yGLJYSvQX4NtyFz7QfC9mSrKoC+gjm4E3PThSAuU/0++CSmt5
         FOBTWCFwMaUti0vt47bdQXP+Y0uUBiJBALzqcA3fUp+uhFULgaBb7yj/T5ERIr/M6Stf
         8Za2ex3I3YW8x3H73Nobqn0gbX4sBGHO1xCK8Y0UpJBYvR+lnZID8btAu/+DjI6p3Q4l
         wnb0D5LmBXNNr+4wSLagKHBKu1euF9H/1Ta5wqHjK9XbvZrZBKm3Ne0/8Ea8xPYGzlaG
         7CVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/YuN3X0a5K6xFNYlC3XCiwX2TxtWA81/NzgdO/OSXrs=;
        b=XVLsWpQLr3M3nIi4ey5fZrYKgw5/K2ChG+lJOEDPhdD1HmAWruCuHZDqdpoghdVbM/
         g4gq0e7jCAr7yy0yOkDI5mlLGFCy4wMkfnhz79dvErvmmOChUZbRrB2YefIBe8WdJu4W
         cWex61c9FoaP1URnpyJqFKkN+bGRXs5HLqelH8MDbf2TTtCADwHUOBfqv1K32BtMZ0Yj
         27aodYSxa6qykfN0uB0mhF5d3XTcuchXi+QqhV4rTJXV/maRqXFbIJOSKxwifnh8mxxi
         McOgiYa26Oze8unZ0GdvklfJJgCSAycg+n/LyGjr6S8bOF/lGN6dcEF4zXVq1/FKtPPm
         VtUA==
X-Gm-Message-State: AD7BkJI0UCbz0csej2n2B8XNtJKLkhSnZLPhqE2oFLMhNJx7wqXmYXcm0DsIpYEmturpZ61ezd0FhcwoEXpqeA==
X-Received: by 10.107.136.69 with SMTP id k66mr3043096iod.0.1459443999645;
 Thu, 31 Mar 2016 10:06:39 -0700 (PDT)
Received: by 10.36.61.140 with HTTP; Thu, 31 Mar 2016 10:06:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290422>

Hello

I want to deploy a hook script to control format of commit message.
For this I use the prepare-commit-msg script.
I want to check if the commit message starts with a number of 3
digits. If this is the case, the script returns 0, otherwise 1.
It works fine for an utilisation with the git command, but it doesn't
when used with gitk. When script returns 1, the commit is not aborded.
I don't manage to display message either (an information message
explaining why commit will be abort).

Is there a way to use hook script with gitk?

Thanks.

CRAILOX Romaric

PS: I use git version 1.8.5.3
