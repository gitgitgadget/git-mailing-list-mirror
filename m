From: Carsten Mattner <carstenmattner@gmail.com>
Subject: tag scheme
Date: Tue, 25 Nov 2014 17:17:52 +0100
Message-ID: <CACY+HvouE0GBH=e4iu7hsFfBJmeZiPKgAC0870S5vPADSYXcJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 17:18:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtIoa-0001iG-GM
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 17:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbaKYQR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 11:17:59 -0500
Received: from mail-la0-f47.google.com ([209.85.215.47]:33850 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbaKYQR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 11:17:56 -0500
Received: by mail-la0-f47.google.com with SMTP id hz20so851283lab.34
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 08:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=5z1Geg8SwErrxvtD3/PHBK7kV0caUXKFwuXw2beOCKQ=;
        b=Wb+gtijWX648D6mN2Gq5h0EzIb3/SokmLCZan2/ktYKUR+19m3pmjwVA1VMf3oIq/C
         BpNbWUXnFjSXVTnnnwH5KwSnr7J/Q1Rz+9/GgRDTj+Vckyj8Ooh662iyrf83FC2aP7MV
         xldiy59qy0SwNhekL8CLDrHs55zQZGHLGpsdIGONphAmJY7f63ZZkSzvPwvR6SgwSlkV
         rl4bFyHczYfqPP0RX5SLiPejGKYUulPeLW/Y2nH4p4v4943jWWkuLRGD+GLdVzHm+hL0
         hvo+7Cle6YsZ0LcfijEeO8QcjCS7LStcH7vqIFh1qK7+ydWiJFVO7G5eQGD+e21F/te2
         764A==
X-Received: by 10.112.132.2 with SMTP id oq2mr28366661lbb.11.1416932272577;
 Tue, 25 Nov 2014 08:17:52 -0800 (PST)
Received: by 10.25.20.67 with HTTP; Tue, 25 Nov 2014 08:17:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260222>

I'm looking for advice on a tagging scheme, especially pros/cons
of using a 'v' prefix as in v2.1.0 like git does.

My impression is that using a common prefix for tags makes it
simple to distinguish from maintenance branches for past releases
but it seems that most repositories use tags without a prefix.
Before I settle on using vX.Y.Z (which I favor right now), I'd like to
understand why some projects do not prefix tags.

Any comments?
