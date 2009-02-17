From: Jay Soffian <jaysoffian@gmail.com>
Subject: FETCH_HEAD question
Date: Mon, 16 Feb 2009 23:43:32 -0500
Message-ID: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 05:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZHpN-0007F2-QN
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 05:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbZBQEne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 23:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbZBQEne
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 23:43:34 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:30250 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbZBQEnd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 23:43:33 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1851291rvb.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 20:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=aIHZolDX9g5I6uXOiyahEVtpowM+E/+wn5Wi+APZRAY=;
        b=D7MeIlWVE0IBN2QJGtS/nIKg3jKmbvwkE2nzJgWl/+fnz/eWMCh4x+13IPYFXJrovo
         M9rexZFP8N014o5Aw0YTRgsQLG7+nHj4AVkAa95hrIZOhNB4AyZCTInooZiql8+gYixu
         bG7OiOWM4uLDRq52JADt+BdeXPl+AL+ikoWWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=oL5G5eNPmLf76boyNTGKeAjhbFSrUIwwXxXRfeyNHuJ7m3kYnbOU+JHTFm16LKTveD
         n9e9tfGx7O7xYUKpxLNGL7dWtTqNoQt5TMINRTdNRoeItjPAIVZYg1+9V62Xfhn1ylO/
         /J4TfAeXS/oqeV3dQP1sKsngQ1Gd+WprKjqgA=
Received: by 10.141.99.2 with SMTP id b2mr3054539rvm.46.1234845812361; Mon, 16 
	Feb 2009 20:43:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110306>

I did this the other day out of mild curiosity:

$ git fetch
$ git merge FETCH_HEAD

Which did something, but not something that was at all useful. It
merges in the first ref listed in FETCH_HEAD. It does not appear to be
an accident that it does this, as git merge has special treatment for
FETCH_HEAD to generate the merge message.

Why does this behavior exist? Historical?

j.
