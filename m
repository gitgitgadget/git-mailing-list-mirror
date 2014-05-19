From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Git showing tags in logs when it shouldn't
Date: Mon, 19 May 2014 08:17:07 -0500
Message-ID: <CAHd499Dx8aZVm0yr7bSo2JTsmJt0p_b2H64pmjCCZFQCVWfZKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 19 15:17:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmNRM-0005Ir-0B
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 15:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbaESNRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 09:17:10 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:55921 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbaESNRI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 09:17:08 -0400
Received: by mail-ve0-f181.google.com with SMTP id pa12so6280024veb.40
        for <git@vger.kernel.org>; Mon, 19 May 2014 06:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=7dqTAtJoEkFyLoR1pp6uaBsswxTAiv7w8tpPr9L1FC8=;
        b=K5pbUkqUoBmsknkn4Bgz49ezXwKl5KsYtJCwCdBHLVjGs1b0PI0jTKz4g2mYffJc1w
         DTtZyWjwu8ZPmlrg2tWTRokZoOEhpoMHjq5pU4r9xKCrHq/GnTafMQRAYbRFVts4qIiQ
         1g8cjgE0ycSoYS6Yi6HbRCEBe0cMWRaYbTBTWrAYbhrf+trsVuUKA37rEcnegXfawxB0
         nhjJk55WfO4a8Dslr6spRBUAwqZBINCu2JRTLOqg0NHrAni6NLfnbC7qFg5WT5TpQRZc
         JrQHuFnFu5N/MzZ70/PZ6Sf9ieIQRMMZHnB2f7gsooUV3ZtL1ZAQlPi8TNf7YQiJGg86
         kFlQ==
X-Received: by 10.220.116.136 with SMTP id m8mr77976vcq.77.1400505427930; Mon,
 19 May 2014 06:17:07 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.13.198 with HTTP; Mon, 19 May 2014 06:17:07 -0700 (PDT)
X-Google-Sender-Auth: 5Gf7-zKPCkk4QuR49uYfBq6NL28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249578>

I have run the following command:

log --graph --abbrev-commit --decorate --date=relative
--format=format:'%C(bold blue)%h%C(reset)%x09%C(bold
green)(%ar)%C(reset)%C(bold yellow)%d%C(reset) %C(dim
white)%an%C(reset) - %C(white)%s%C(reset)'

After running this, I am seeing tag labels in the log graph. I believe
these shouldn't be showing because the docs for --decorate state that
refs/tags/ should not show. I'm also obviously not specifying --tags

Is this a bug? If not, what changes do I need to make? I only want to
see branch labels, nothing else.
