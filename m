From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Convenient shortcut to push delete current branch?
Date: Thu, 1 Oct 2015 11:43:18 -0500
Message-ID: <CAHd499C3n8DGuhxwajQbFrH+Fr8zHRA7sVjhG3yfSD5kKPSZsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 01 18:43:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zhgx2-00019N-59
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 18:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756715AbbJAQnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 12:43:19 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36556 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbJAQnT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 12:43:19 -0400
Received: by ioii196 with SMTP id i196so91768579ioi.3
        for <git@vger.kernel.org>; Thu, 01 Oct 2015 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=HfWZT7Ge3k7juzHmLvwBxqGhSmJwidkhUQWNT88uc7A=;
        b=TdCt+g0TaMMwv6PGwwmHoACWJvFgecQTKB911qQ1wzdlaKGD7GjDVN4k2nml6JFVKq
         133trh3tNx2oTo81j8ieSJqtS9Lo7CTMKly51BNnDot3z7FkxefqAhdADDZDAee8n1l/
         HC7JWUN0reyWUYIoZ8cSJXCYqb6fCTMk2LuHByZAEDtEovCXp3JeAduYeQmI2nOsw777
         LSt9QzPv3CzFEeXJvHISQvo9GjD6F2rENwwIYBRWM3h7i5cklDSm+iuvZ0lQSKs+qsGY
         HOyk53rqtBURUvde2cW0+E9r+CTFUJKh74KdVrKe+V1gOc0OoPJ+weKvy1jgp2QMZrRs
         vmqg==
X-Received: by 10.107.159.198 with SMTP id i189mr11648689ioe.59.1443717798535;
 Thu, 01 Oct 2015 09:43:18 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.83.147 with HTTP; Thu, 1 Oct 2015 09:43:18 -0700 (PDT)
X-Google-Sender-Auth: Fh3OJsTc4rJYnKPn43CwR7ytn_M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278893>

For convenient pushing of current branch, git supports this syntax:

$ git push origin HEAD

This will push your current branch up. However, is there such a
shortcut for *deleting* the branch? The only goal here is to avoid
having to type the branch name in the push command. Normally I rely on
tab completion but we have tons of branches, all which start with some
prefix mixed with numbers, so it becomes cumbersome to rely on tab
completion. Ideally I'd like to be able to do:

$ git push --delete origin HEAD
$ git push origin :HEAD

Is there a syntax like this available?
