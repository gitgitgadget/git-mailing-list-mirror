From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Listing authors of each file in branch HEAD since given revision
Date: Thu, 29 May 2008 12:43:46 +0400
Message-ID: <c6c947f60805290143r731b4a80v8d8297124899be22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 10:45:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1dkW-0002iQ-4A
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 10:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbYE2Inr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 04:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbYE2Inr
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 04:43:47 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:6333 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbYE2Inq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 04:43:46 -0400
Received: by wa-out-1112.google.com with SMTP id j37so3506404waf.23
        for <git@vger.kernel.org>; Thu, 29 May 2008 01:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=QDV3kWOA9QtJHB8sc24J4SQUw4TlVIAp1K5KSodgKK4=;
        b=LQU8pJxAff2OU9N72B9HKhQYKy5UAM1nMSFqEcaVQX72KloxN07whOJEM4ksnLSnrXQgoV8iujqEZ8PLJpWlfWZkR3V/bROHXT2xBz1AWOaIKBKDjHmynM8pf7YVxLn3Slzc9+jHiDbOKAqtA8dIGDQy0//pvcQFJkJQC/ol+wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ujn4p5SKGqNXrivCtNeRb77o8ajg4tXA7cr5iVFqv6F/OfOInkBq6Qjh5o4GUPCMg421mM5ZJoY27DE/NgWY05iOZaWKU2YfZUYhnibMvzRFt8Eluunu+boO0ECJr4yNy+C7VyIAyB2+fcfbOxhAXrVd1x2C39tWk0uMMq+9DbU=
Received: by 10.115.78.1 with SMTP id f1mr3936630wal.100.1212050626441;
        Thu, 29 May 2008 01:43:46 -0700 (PDT)
Received: by 10.114.74.20 with HTTP; Thu, 29 May 2008 01:43:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83181>

Hi, list!

For each file in the head of my current branch I need to get a list of
all people who altered it since given revision. If file was not
changed, it should be not listed.

Something like:

  my/file1.ext user1 user2 user3
  my/file2.ext user1

I also need to be able to get closer view with commit names and
messages for along with author names:

  my/file1.ext
    <hash> user1 commit text1
    <hash> user2 commit text2
    <hash> user3 commit text2

  my/file2.ext
    <hash> user1 commit text1

I believe there should be such tool already, or it should be simple
enough to glue it from existing pieces. Please point me to the right
direction.

Thanks in advance,
Alexander.
