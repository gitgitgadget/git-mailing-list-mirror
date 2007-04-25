From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: unnecessary check in builtin-add.c ?
Date: Wed, 25 Apr 2007 08:53:27 -0400
Message-ID: <f36b08ee0704250553w7ceee488y2586a5dccb62fe2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 14:54:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgh0R-0002Dv-Ny
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 14:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965662AbXDYMxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 08:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965655AbXDYMxi
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 08:53:38 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:13514 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965650AbXDYMx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 08:53:28 -0400
Received: by wx-out-0506.google.com with SMTP id h31so222339wxd
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 05:53:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=E2nGF2EvZcyfDfDkH1z5Ydm7nC+quJRfYteakXH5GNYdnZT0nkxQsEco0Mr3bOwF+3brXEkQpI8zdc7p6VwMUmQ9hwqz1yzWZ4eycxecp+Zi//T8LaWLa74crrlobpd8KwXcpT5iweyAYkkl1n/+1s5BPYuLg8x11IR1JvRQeTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=m0qturiv/SBm4fRZR5mJ17VEDGVKGo/p3u5TuI8UEml/ylCPlThdX8gpCwd3/k0Bxs0HDum+Wcw7w6E1NqVuQHXqUiNzXZ5DZjKPWpD3GSiTLbypXp68W5yS0CRpDpIU4yBQ7KxBZ70DugosQaHLI8ZqHdU25XuebHu40qHZkZg=
Received: by 10.90.49.1 with SMTP id w1mr597100agw.1177505607071;
        Wed, 25 Apr 2007 05:53:27 -0700 (PDT)
Received: by 10.90.73.8 with HTTP; Wed, 25 Apr 2007 05:53:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45521>

At line 91 in fill_directory(), isn't this check unnecessary
(91 if (pathspec)) because of earlier check at line 161 (if (argc <= i) ) ?

Yakov
