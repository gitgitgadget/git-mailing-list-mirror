From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: exporting the last N days of a repository
Date: Wed, 29 Oct 2008 11:31:37 +1030
Message-ID: <93c3eada0810281801l29253e02g95c7a6851c4c4db3@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 02:02:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuzSW-0005mE-QI
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 02:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbYJ2BBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 21:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbYJ2BBk
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 21:01:40 -0400
Received: from mail-gx0-f31.google.com ([209.85.217.31]:37383 "EHLO
	mail-gx0-f31.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbYJ2BBj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 21:01:39 -0400
Received: by gxk12 with SMTP id 12so6785gxk.13
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=e5vV+NrgE5KJ9Yzg2NrAGyCoa7FI19iBVoy7xuVafYI=;
        b=rbRHWce0v1o18BnPuxnAc+SNGo9d/9kjBmNIuP5FJR0o7+GQziNHFQLROLy01J0elg
         AF04lMMJlKeKnxOxBjymETLYdHC8+YrD7ELCZR3SX4MpM3+RfrNsqrVXvyzkGKJgIydv
         nppfkS4/3SbFlJRUL9PQRUibRx49KYgmzaEQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=HETQw7VYNEOdxQK1yJlGk8Xeiv14o7WQ99E/XPye9gVa+7PHc5gFkYIV8gRzRRN+nW
         0HS3+KqckRt3nEzcBQlBCVkT32qED9jbCOmRonnnoFSx87KtIAtE2KehAngL6dv+M9a9
         0iKCyTfVyX3kNsRLugx4hk4BNslAKBqI83+rw=
Received: by 10.151.46.17 with SMTP id y17mr15374889ybj.115.1225242097539;
        Tue, 28 Oct 2008 18:01:37 -0700 (PDT)
Received: by 10.150.181.6 with HTTP; Tue, 28 Oct 2008 18:01:37 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99343>

I want to export "the last N days" of a repository to create a copy
which has an origin which is
the state of the repository N days ago and has all the history between
then and now.

Can fast-export do this?

Cheers,
Geoff Russell
