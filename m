From: Jon Seymour <jon.seymour@gmail.com>
Subject: A question about the tree associated with a git notes commit
Date: Wed, 10 Feb 2010 17:16:55 +1100
Message-ID: <2cfc40321002092216p5cbf432bs3766d40858f9bf3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 07:17:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf5sm-0005tA-ND
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 07:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772Ab0BJGQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 01:16:57 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:64102 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab0BJGQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 01:16:56 -0500
Received: by pzk17 with SMTP id 17so916059pzk.4
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 22:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=72ar24UL1Dgq6ioj/isuuMlY1A2U9+Dla6Etz07VE+I=;
        b=Nrh4EZ/U474yHty4sM1VYmBFRbeydT7f225Cy0pMfq1X+tI1hrTM5uEbz2xTrvJxQk
         v6aHxR+U2SZpolFKJ0d0NmnKyDIo8A1Sxo1mJQupaZ4uBE30zz5iYYMyYf0CFHv3ZnKI
         XyxO/KJlL6r02B7t+Iu33M9v5B97MAcycAUEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=fuu+LSEdr7gnzYRMzp//Zu0lvBNwl3ynTUl3zu32sr/USsH5Xl+RdbFXluVWN1vp0J
         SyUbXkT9tsRLtdIyH3KvAxhKUOujL8JQqzWfkxFYpXAT9Sy3NKEixM7JNbeREyFzuedn
         DKxZ6Csz00QlAziOFnEcV6LfaggpWYQXcWfHY=
Received: by 10.115.2.20 with SMTP id e20mr3205124wai.50.1265782615711; Tue, 
	09 Feb 2010 22:16:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139494>

Is the tree associated with a notes commit limited to a single level,
or is there some attempt to balance the tree as the number of
annotated objects increases?

If the tree is currently restricted to a single level, is this
eventually going to be a problem as the number of annotated objects
continues to grow?

Apologies if this question is answered with trivial analysis of the
code, I admittedly haven't done that.

jon.
