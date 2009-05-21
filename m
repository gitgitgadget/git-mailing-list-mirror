From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git doesn't append ".git" to url WAS [PATCH 0/3] http*: refactor 
	fetching code (v2)
Date: Thu, 21 May 2009 22:17:33 +0800
Message-ID: <be6fef0d0905210717j174499f5k4740dc2f821bec62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu May 21 16:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M795b-0001pc-0w
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 16:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129AbZEUORd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 10:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754687AbZEUORd
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 10:17:33 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:57962 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbZEUORc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 10:17:32 -0400
X-Greylist: delayed 94043 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 May 2009 10:17:32 EDT
Received: by pxi1 with SMTP id 1so719614pxi.33
        for <git@vger.kernel.org>; Thu, 21 May 2009 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=1NpATeFoDWrC5bHdbJh+6fHsk5i+QUSaPfBbvdsdcpc=;
        b=QdXFGL9ZKLiW9Mkvfdv/EKOBKxx2cSKClesh9n+tVVHIsmsYgju5rxsKbo4zfQUunB
         CH8AbTDYs2SIFyXZxUEIiBYKQspMikyjI7agjVibYXVggYGP36P87eI6q4nVqzjpZqep
         EQ+MPNVgDUc2ddhzHr61X6PqwQEkDy8mEOT4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=nMIugWHowkC+svST8EgpqCuk9uMxjbFUA4dqYZZ3QGv+ui7Rkv6qrBWOkWj3Ge7iKP
         QqGKRHiq//WQHHjPnfalPWHrV/oVvq0fROntmX4C1K5voGrFnC/zC1ixVdmHfJV0qHeT
         5qeTf4o6YdbT5e54dldxaqe26ffAxmERGJwHE=
Received: by 10.114.134.1 with SMTP id h1mr5238738wad.219.1242915453245; Thu, 
	21 May 2009 07:17:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119682>

Hi,

On Wed, May 20, 2009 at 10:03 PM, Tony Finch <dot@dotat.at> wrote:
> On this topic, some of my friends have complained that git doesn't
> automatically try appending .git to a URL when it fails to find a
> bare git repository on the server.

are your friends hosting non-bare repositories directly (with
checked-out copies)? In the first place, this isn't a good idea;
please refer to

 http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#def_bare_repository

and

 http://kerneltrap.org/mailarchive/git/2009/1/30/4852194

for reasons why.

-- 
Cheers,
Ray Chuan
