From: Evgeniy Ivanov <lolkaantimat@gmail.com>
Subject: Git merge: conflict is expected, but not detected
Date: Fri, 29 Nov 2013 18:26:25 +0400
Message-ID: <CAO6Ho0d=JHk4ydd1PdcWP1XHxvXpjfYVK+B_QLgd0vpyFTh_xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 29 15:26:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmP1e-0002Ia-6W
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 15:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104Ab3K2O01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Nov 2013 09:26:27 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37993 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab3K2O00 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 09:26:26 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so15934235iec.19
        for <git@vger.kernel.org>; Fri, 29 Nov 2013 06:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=tHPUTGCCpm34C68yWxduBpY56hBnudLYxRkCvv4aCNA=;
        b=jHgLO6nA7grZPcSrN+d3xWPiQqBKalc2j4x+6MATREVacFsO0WPR16GvW2p7IVUPoz
         0xx+nUO1Sv9w7LT79gqDLg3etIiO3cn4rdjiG9etm2ME5wQosOoSLg1/FyMfB4RpFS5H
         HckQDVV7ein8AukaBC/bps2MJL/ocehFkcbreTULHSQEO3kMvIqB9H4YbevWfevXqmxz
         yPmG/rqULBZdZ+LxUIbQOsAH7Y/nP9oS2YAyftF785NXE49U20sLqp8TFfWYXfLwDuK5
         WTP4xuy8YGB3RD7RE+7LMnHJ4ZI7xkmhaLieunrD/PKwB2tDDnkulu1d/C3/7OC7BJo6
         0RPQ==
X-Received: by 10.42.222.68 with SMTP id if4mr1924715icb.62.1385735185792;
 Fri, 29 Nov 2013 06:26:25 -0800 (PST)
Received: by 10.64.77.52 with HTTP; Fri, 29 Nov 2013 06:26:25 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238527>

Hi!

Let's say I have two identical branches: master and topic. In master I
remove some code, i.e. function bar(). In topic I do the same (commit)
and after some time I realize I need bar() and revert previous commit
with removal.
So I end with master with no bar() and topic with bar() in its
original state. When I merge I get code without bar() and no merge
conflict (recursive or resolve strategies). Is it possible to detect
such situations as conflicts? When bar() is C++ virtual there is no
possibility to catch this with compiler.

Please, CC me since I'm not subscribed.

Thanks in advance!

-- 
Cheers,
Evgeniy
