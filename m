From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: purging unwanted history
Date: Mon, 17 Nov 2008 10:56:23 +1030
Message-ID: <93c3eada0811161626h69929cd7va3fa4007a2341bae@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 01:27:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1rxs-0004Hi-22
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 01:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbYKQA0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 19:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbYKQA0Z
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 19:26:25 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:25979 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbYKQA0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 19:26:24 -0500
Received: by yw-out-2324.google.com with SMTP id 9so936061ywe.1
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 16:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=GvQITTV37qvBMd7cRbUDKiP8Y2Dp6r72MPExljcA4W4=;
        b=Iw8NIq8JPRQr1UemKriGmZ0/GJSLrOZLE9Z/Oo6Cj+kOZ9m//1lzNinTpe3QsihRsV
         g6A4a3SUCPO2yBgS6kJWa0Xu3UUUrltRKhkcA0tqUsk9T5ff9wg7Xhkx+KSbsb6YFAxQ
         nbJuj0ZciXzgUaDIPRe4arlYmYgqq8AODfi0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=eR39GkDOz359PvX+UGDj91VXqqc7MUNOX16BRuUJOyM0wDWpUkYUTwRgaOrjso23kI
         735tmQVfxnllGJplJxGNV/ghDxYq+dw6BfsnXhAAfDZuXDDB6bD+O10VCdzpEAToiOlA
         uBA8oCH70X0XOplQnenOLVfU45vLVj4M7aeco=
Received: by 10.151.112.17 with SMTP id p17mr6804841ybm.50.1226881583736;
        Sun, 16 Nov 2008 16:26:23 -0800 (PST)
Received: by 10.150.121.2 with HTTP; Sun, 16 Nov 2008 16:26:23 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101186>

I have a repository with 5 years worth of history, I only want to keep
1 year, so I want to purge the
first 4 years. As it happens, the repository only has a single branch
which should
simplify the problem.

Cheers,

Geoff Russell

P.S. Apologies, but I've asked this question before but didn't get an
answer which
I understood or which worked, so perhaps my description of the problem
was faulty. This
is a second attempt.
