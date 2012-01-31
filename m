From: =?UTF-8?Q?Marcin_Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
Subject: Disable merge conflicts on on non-conflicting changes to subsequent lines
Date: Tue, 31 Jan 2012 11:55:46 +0100
Message-ID: <CAC9GOO8GzvezgLH=2F735u=k+-5_1wMsZPbK4sy656dxMvCv3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 11:55:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsBNQ-0000KT-AE
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 11:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152Ab2AaKzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 05:55:47 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45153 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024Ab2AaKzr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 05:55:47 -0500
Received: by iacb35 with SMTP id b35so693054iac.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 02:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Bk12HWZARgZOrWOHtWNhyAmCjv0WG6qyKs4SROogmAY=;
        b=FKZnN/koSJ3xpMW9vkPTZnvaRJsNuiMI8QjhYFCBxX9sjG2HAF2jA0OR95LTnjI6tp
         nX94q7lxIqY6XGjUeOLdFqoybcXbbV5JTwZIKC6ohVx51kmQWPTPBAH4kQNexBk1JnLR
         DxuZf3vkKtXJcjcBBuIJc1yMXAuv6FUqqjylk=
Received: by 10.50.207.72 with SMTP id lu8mr21519959igc.0.1328007346762; Tue,
 31 Jan 2012 02:55:46 -0800 (PST)
Received: by 10.42.169.200 with HTTP; Tue, 31 Jan 2012 02:55:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189450>

If two subsequent lines are changed in different branches, merging
will result in conflict event if there isn't any.
Invoking merge tool will mark file as resolved automatically.

Is there a way to disable this behavior ? I want the merge to happen
automatically if possible.
