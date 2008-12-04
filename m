From: "Tim Harper" <timcharper@gmail.com>
Subject: pre-rebase safety hook
Date: Thu, 4 Dec 2008 10:58:41 -0700
Message-ID: <e1a5e9a00812040958u3af4c69ofba66567baacb79c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 19:00:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8IUa-0004fA-0C
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 19:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbYLDR6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 12:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbYLDR6n
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 12:58:43 -0500
Received: from wf-out-1314.google.com ([209.85.200.170]:14664 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbYLDR6m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 12:58:42 -0500
Received: by wf-out-1314.google.com with SMTP id 27so4348652wfd.4
        for <git@vger.kernel.org>; Thu, 04 Dec 2008 09:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=GLGceFd1f90zx/HBHOTTP1PheHlUWOF4vaxZ3SyNi4E=;
        b=I3mrcOKpxlW4T3eo5TxiifLI5yyo5A6mu2afpIHy4C/65FQ0RZ1joZ5a6VpbO57mcI
         NT9Jl2AMVQpHEIswHLcC5qaz7ua4U1VtbYIS7hd6oM94tHhxYUXIX1eqUnegmBngWhZE
         1Qy8w7dENmCV3ke4F4olbS8Pz7iupU8Xvwga8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=oBsn8RXdnsJBvYFvm4j2y71vUliXkJBMGDPZ6DjjQpOX3ngUzCEIgTA+o7Rp35Kc+2
         +uZi0zszbg9HUvcqXi4nFpngV5ZzHal7H9bNoVcIZPUNhjF8aCLv0b7Jrzco/YeOJ06X
         o7qRm+QyUAOymQSOmNwLrMoESz+5cyXZNKz54=
Received: by 10.115.47.13 with SMTP id z13mr9181330waj.108.1228413521051;
        Thu, 04 Dec 2008 09:58:41 -0800 (PST)
Received: by 10.114.146.19 with HTTP; Thu, 4 Dec 2008 09:58:41 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102353>

Is anyone aware of a pre-rebase hook script that will prevent (or at
least warn) you from letting a rebase rewrite a commit that has been
pushed or merged into any branch except it's own?

I've activated the pre-rebase.sample, and it does seem to give me any
warnings at all:

Here's the terminal output demonstrating what I mean:

http://pastie.org/331082

Thanks!

Tim
