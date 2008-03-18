From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: bug in git-send-mail (the 'next' branch)
Date: Tue, 18 Mar 2008 15:52:58 +0200
Message-ID: <f36b08ee0803180652g68caa4cci21b0c59020c0fd07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 18 14:54:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbcGK-0005Bo-Rc
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 14:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbYCRNxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 09:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbYCRNxD
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 09:53:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:44265 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbYCRNxB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 09:53:01 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2331679nfb.21
        for <git@vger.kernel.org>; Tue, 18 Mar 2008 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ZOdi83fzB9AGSEboplPrOL4NZ8SfsZJdZWJ00dpJUV0=;
        b=N96Vr7VoZ2XXOszVb0VkHDyaa29SVd8S3hYrTo5AH6X9CaCm3KRElj0aPHGF7zpYHjglHak3RKvTj5T9jtPGNrlCbhBJjEqNeFXedWZWAT+v8TJokrtJtRjzGVyubCpmsnor70ZvtFPzGUeGKt++ArrowfUDyoYmixK66o8pYlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rHCIIp2tL019yioYrAg5atsgAnUOkXkKOOTE7TCXEAZwO3JWLQPoZdOwW6MO53sI6eKMYQfYtgW8UTBxkz/8ieh2F/eWoRiYJ68axt+RhGbbR6gweKjDXDvKFmtCynmid+1wjxC0W3sGTI3l3be330LztQiH2TE1rRhfbbMxkzY=
Received: by 10.78.138.6 with SMTP id l6mr1763985hud.71.1205848378814;
        Tue, 18 Mar 2008 06:52:58 -0700 (PDT)
Received: by 10.78.199.17 with HTTP; Tue, 18 Mar 2008 06:52:58 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77499>

There is a bug in git-send-mail in the 'next' branch. If first
paragraph of the file in all indented by 1 space, and 1st line of the
paragraph is at the first line of the file, then the whole
paragraph disappears silently. If it's intentional, there should be a warning
or something. And If it's *not* indented (as if it expects message
header lines at this place), then it appears in the message body, so
there is some inconsistency here.

Yakov
