From: Dan Savilonis <djs@n-cube.org>
Subject: git format-patch from date never set
Date: Sat, 25 Jul 2009 17:39:27 -0400
Message-ID: <325c62f60907251439n6f3f661dhf0e76a74ce1eaec8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 23:39:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUoxs-0006G1-R1
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 23:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbZGYVj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 17:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbZGYVj2
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 17:39:28 -0400
Received: from mail-yx0-f198.google.com ([209.85.210.198]:51023 "EHLO
	mail-yx0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbZGYVj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 17:39:28 -0400
Received: by yxe36 with SMTP id 36so1304572yxe.33
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 14:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=x5NKSFiLw/Iypvy6SD0WbnF1TlO8C4ZAUfuBzL5NEIw=;
        b=x9R1b0CQD0+YTLxXr3uZ0/8rEH5zSlDDy+nAnjBJ5S5MWdOZCjqaJle43Bb4U/a28U
         cwMG2cG60yLKo2mXBVeuY1on7dW3q05fgoG/IMOYcmzbeAhl6+Oabc5hblDKLSvdd2Sa
         Cc4cvR/h/4qoosFaLt9A5WVk6JZ7l0QLiFDOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=Yd0vbeWTiPbTY9+UGxwExIZhrw2TInwnyBk1qPqr/hmxVx94Hfkeulkswhy3s0FESc
         2TXS6VVo4rWmRJgnmvv2K9yArdyIYlWvJH3lwTaQ8KdymLTk/K0nkI0FTGBNHKQufM7W
         2Y7Kq7Xr8a85zkxwfPVQ9YsrMwL/quT9ztv0g=
Received: by 10.231.34.3 with SMTP id j3mr1557116ibd.43.1248557967927; Sat, 25 
	Jul 2009 14:39:27 -0700 (PDT)
X-Google-Sender-Auth: 51717653a4c95610
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124082>

git format-patch always sets the date in the From: line to the git
default date, e.g.

    From b9ff0ba6f3e228e1a8b67a25bc7be6b1da5ed1f3 Mon Sep 17 00:00:00 2001

The command uses GIT_COMMITTER_DATE as the date, but this env variable
is never set in cmd_format_patch(). Is this a bug or 'feature'?

--
Dan
