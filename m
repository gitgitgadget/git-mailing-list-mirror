From: MrUnleaded <mrunleaded@gmail.com>
Subject: git-svn and core.autocrlf on windows
Date: Mon, 28 Jun 2010 17:01:38 +0000
Message-ID: <AANLkTin2CIla9AOt8bRVbQPgyNKhvY6LauOVRc1LqGuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 28 19:01:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTHiM-0003ph-22
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 19:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700Ab0F1RBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 13:01:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33415 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab0F1RBk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 13:01:40 -0400
Received: by fxm14 with SMTP id 14so849677fxm.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=QmbY1nWTGYXQiX7B7VdklNNVUrO1XtybCYRKDJHBFog=;
        b=Yeo3X3D32RhTWemMX5w8fnJj1unmhLAGlTCO17q04O0iEZOPxMNACaUswAd+FrOUxI
         U6uXVvLFp+9DpjlJrJ1+arn8JybmbRShVTjwNX8trmMANn87z+UK9qsFxoJ7d6TenR2C
         JxaaeI4x+Ie7HY5p4XCyBhL6K7clhpBAWXNOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=S67gQk7CPUmoOvJ9iP9iyQoEqmAf4+A1VlQgHNXKC9u5zM15ljkT1m8tbBFEojYgAZ
         RkE1YN4R0eaSMl/32koHeazhsUyvPB5UH4wjHPjfX7+mRJpwkyfPd8gfbLaN9fuCKs6C
         m+JEe57xxqaIRIoKrPvRk+seMZu++YD1q7V/g=
Received: by 10.102.16.36 with SMTP id 36mr1375940mup.124.1277744499102; Mon, 
	28 Jun 2010 10:01:39 -0700 (PDT)
Received: by 10.220.171.142 with HTTP; Mon, 28 Jun 2010 10:01:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149841>

Hello, I was wondering what the best or correct setting for
core.autocrlf would be when using git-svn to commit to a subversion
repository that is a windows project(ie CRLF line endings).

The documentation says that text documents are converted to LF line
endings in the repo. If you commit to subversion will if convert that
commit to have the line endings you have on your system? Or will it
use LF line endings regardless?

I would greatly appreciate if anyone could shed some light on this.

Thanks

-- 
Kevin
