From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: How can I get a list of checkout history?
Date: Mon, 15 Feb 2016 09:18:50 -0600
Message-ID: <CAHd499D5nMvFQ-eok_3tMZTNp+9JdcMZSL9XrXqkdUNxmRq_eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 15 16:18:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVKvQ-0006As-2a
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 16:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbcBOPSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 10:18:52 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33921 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbcBOPSv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 10:18:51 -0500
Received: by mail-vk0-f46.google.com with SMTP id e185so109678172vkb.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 07:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=cYDiKP1G0V7VDywxB58picVaRgvyrWQS1O/0UJlrR6A=;
        b=DJFDetJ5w1jpRZxLH7QF282qbOyT9EKUT1y1HBaBluVCCgvAUmI15rxOo+F3eSZ+h0
         C7CUM94djyybDLRMZmRUkoJZRZwUrkibplMcjpmB+wMkOpY18/RYGRtyRnKYBYU/qd9G
         cLNOOYERHo502li02V/NSHC8UuWOJVDP2/gzmXdIi9iAC2ELY1/0kaVd8+BZtGLpM+uF
         ngnECD2Z2H1KbKXpUIldtltBjp1G2Kxh8p3Y0XD1DZtf0uNifixGaHicgFR67WmlJtP3
         p67mlh1+ZoLwUpyNGVNJX9XLfPcyYneSHjAcRZFEJuclcBde5hGKLtPnFy/zWsQKQT2i
         tL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to:content-type;
        bh=cYDiKP1G0V7VDywxB58picVaRgvyrWQS1O/0UJlrR6A=;
        b=AG2aHCMkmKYgLedDt/wxrAYd0rGQQbd3SV06HBl23I0p9U7cE6GG3TVNjtQ+OjGMTg
         Yr2A6eZ1bEUglG93gT8+k3UZ1WPHhh9z/r3j8LoS1riFC4NASLhJSYPjZISh4HdWuyRT
         IF2srmDAcz/AplFwaK2TdyrHrIKacZySzbXUk1tJP2NuXt3sFWwhEyC/jR/cGLEuFjXh
         +PB1W+HcbZV+db1wnhrL0HzxCRj1wDxc83/7o3M+8umNZXkewfw4Vf+SyuI34Sl+dWJX
         vwmYIzI0VikjBt65iZuZrnGyf3MMFM6RY57gieuTunmhfvL6Rif5jjIvq0EqUIFGLtQJ
         dMvw==
X-Gm-Message-State: AG10YOTGVFElgc4xG4J+i5lbD7GRuLNxdVrK2SdzQX76/zos/DsopyEu8zt5ztYn4HZyRYAhAS/bn6WMNSM+Sw==
X-Received: by 10.31.58.139 with SMTP id h133mr13193853vka.158.1455549530275;
 Mon, 15 Feb 2016 07:18:50 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.66.68 with HTTP; Mon, 15 Feb 2016 07:18:50 -0800 (PST)
X-Google-Sender-Auth: Akh6ig1d_CDycwd1A4DkXcLsV-g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286209>

As you know, I can checkout the Nth checked out branch via this syntax:

$ git checkout @{-N}

Is there a built-in mechanism to get a listing of previously checked
out refs? Basically, this would be similar to 'history' command in
linux where instead of actual commands, it lists like this:

HEAD@{-1}: master
HEAD@{-2}: topic1
HEAD@{-3}: 3f556e9 (detached)

Seems like reflog should be able to do this, and maybe it can, but I'm
not sure. Any tips? I'd be fine making a convenient alias for this if
it ends up being a series of piped commands.

Thanks in advance.
