From: Ping Yin <pkufranky@gmail.com>
Subject: How to setup bash completion for alias of git command
Date: Sat, 12 Jan 2013 22:30:45 +0800
Message-ID: <CACSwcnQu8Rx83mcGYR6NGzEhoreNR6DfiK876LF7pa9PGm30JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 15:33:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu292-0005Gx-O6
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 15:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab3ALOas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 09:30:48 -0500
Received: from mail-ia0-f177.google.com ([209.85.210.177]:33702 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab3ALOar (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 09:30:47 -0500
Received: by mail-ia0-f177.google.com with SMTP id h8so2318214iaa.8
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 06:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=BzBdqBwEJZvriyVeOvkMQlliMVxvNy0a1BaEM4K5KBo=;
        b=dJOVKM8Hd8fbrZ5bcaJkeEcXOCJEQ0KqluPA8anMxOpWL27WZ28JydxY9zC5faG/Id
         C+cCx5ymRT/q8vIhwt9MRcaeqmuKtzw9ImV/pFHE3CadFC19XwlVrGYJAq8UItyZ7ohF
         M3vczn/NCR3GVH3fTTvuT/v9FXl+hVGoVqjmv4AaS+XiUTNdHtn13q5Mq6elE3MDoFJ7
         52aNa16npwnXt3N41bbAApcp0I1id1w5tq62SGfihwJxTC5NV8BNUATXmpvLIuPXyALa
         EQB7fP6Rbhk1Ky7InWkXYP9azuB0mylUu4NeGRkLbHsTe2OGG/mB+gaUX+8tNzJhcHcZ
         p4nw==
Received: by 10.42.63.4 with SMTP id a4mr58964020ici.40.1358001045525; Sat, 12
 Jan 2013 06:30:45 -0800 (PST)
Received: by 10.231.133.10 with HTTP; Sat, 12 Jan 2013 06:30:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213284>

Following setup works for me  in ubuntu (10.04,11.04) for a long time

alias gtlg='git log'
complete -o default -o nospace -F _git_log gtlg

However, in debian (testing, wheezy), it doesn't work

$ gtlg or<TAB>
gtlg or-bash: [: 1: unary operator expected
-bash: [: 1: unary operator expected

$ git --version
git version 1.7.10

Can anybody help?
