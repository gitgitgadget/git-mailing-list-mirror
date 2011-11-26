From: =?UTF-8?B?4piCSm9zaCBDaGlhICjosKLku7vkuK0p?= <joshchia@gmail.com>
Subject: git branch -M" regression in 1.7.7?
Date: Fri, 25 Nov 2011 19:36:08 -0500
Message-ID: <CALxtSbRbwkVDKJcXiKY9rHYCjA3XGgCytbXQnRhQvbEnY8SpjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 01:36:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RU6Fb-0003rH-Vg
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 01:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab1KZAgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Nov 2011 19:36:10 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35379 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035Ab1KZAgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2011 19:36:09 -0500
Received: by pzk36 with SMTP id 36so1349085pzk.1
        for <git@vger.kernel.org>; Fri, 25 Nov 2011 16:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=bIxUvG4tL5kLbaYbiysZvkkyxMom/N7/Q/Ke79tmkmA=;
        b=OGxDGS5iQZdRQwuZ+EvGfZr84wByh/t8c0IZ5gLMyCmhlHp6IVygY6+n4v00WxLQOq
         X+KBH+JS2JfNUCDwMxuYxgchEPMg/Arj3RmrG7RZL1FKpxE7UKHrTIeDlbi+ll/QEsnX
         377JaWjh4Vrfw0GrgVlKAI80bpctf+ZAZy3L8=
Received: by 10.68.30.136 with SMTP id s8mr32015689pbh.45.1322267768825; Fri,
 25 Nov 2011 16:36:08 -0800 (PST)
Received: by 10.68.47.137 with HTTP; Fri, 25 Nov 2011 16:36:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185942>

On git 1.7.7.3, when I try to "git branch -M master" when I'm already
on a branch 'master', I get this error message:
Cannot force update the current branch

On 1.7.6.4, the command succeeds.

Is this intended?
