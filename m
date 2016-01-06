From: Eric Curtin <ericcurtin17@gmail.com>
Subject: Initial git clone behaviour
Date: Wed, 6 Jan 2016 22:26:05 +0000
Message-ID: <CANpvso58uPtMcz_L0D=WBcCj+mSLLYZ5LpfO1i5yLo-jrb6bsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 23:26:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGwWy-0000Ko-6P
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 23:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbcAFW0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 17:26:08 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37102 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbcAFW0H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 17:26:07 -0500
Received: by mail-wm0-f52.google.com with SMTP id f206so96537043wmf.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 14:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=kWyBNtFyEOLP9rB2Ao74P/82E2w9Z00rfjGyt13Tkvk=;
        b=Wf/kZOA+kC2FfoZuAnbSD5/HjGhqtdh8r6N6AgNKlIPosGQJvM9GAdimm6XmB0/O++
         5fQ988CLb3Ef4y6iUnhIbrJ9BNPtT2LEHZccL7PqUZ6545LaeqLVx4QIjY/wIIrTUD1p
         I13nO1wa7WCGt8OtLFmcvZxuOj6lbRhQF0cvkwF0ni5xzCbPGbGT1ImXqI7KsqL2K17c
         zZsH9rOqZWRhENX52z1u7Fulu0IGwA0z0aVVFqKTtzXqWe2uuSDwwFkjZFqDVWDWfXrK
         Zk5U6aeapKUC8gH9myisotgGOxZeN2Uzo/58YoVwf+tCOlXePk05ySXd6FuJxs9cX/bY
         KnDw==
X-Received: by 10.28.97.11 with SMTP id v11mr13429301wmb.42.1452119165058;
 Wed, 06 Jan 2016 14:26:05 -0800 (PST)
Received: by 10.27.217.211 with HTTP; Wed, 6 Jan 2016 14:26:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283455>

Hi Guys,

I am not a git developer or a git expert but just a change I would love
to see.

When I clone a really large repository (like the linux kernel for
example) initially on a brand new machine, it can take quite a while
before I can start working with the code.

Often I do a standard git clone:

git clone (name of repo)

Followed by a depth=1 clone in parallel, so I can get building and
working with the code asap:

git clone --depth=1 (name of repo)

Could we change the default behavior of git so that we initially get
all the current files quickly so that we can start working them and
then getting the rest of the data? At least a user could get to work
quicker this way. Any disadvantages of this approach? Maybe I am not
the first to suggest something like this.
