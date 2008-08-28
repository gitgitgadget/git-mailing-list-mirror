From: "Nathan Panike" <nathan.panike@gmail.com>
Subject: [PATCH 0/2] Use %as and %cs as pretty format flags
Date: Thu, 28 Aug 2008 06:09:37 -0500
Message-ID: <d77df1110808280409o9445f9fybcab2c8d1066a8d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 13:11:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYfOl-0008U0-PH
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 13:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbYH1LJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 07:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbYH1LJj
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 07:09:39 -0400
Received: from qb-out-0506.google.com ([72.14.204.231]:29707 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbYH1LJi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 07:09:38 -0400
Received: by qb-out-0506.google.com with SMTP id f11so781506qba.17
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 04:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=NF4xR9r6w8S6W0E5Ru7uKMg5/M9ifSGDcEJX1ZqyImg=;
        b=h/Za1C4lNl3cUewXLyhQwpTV94lAOilzJLHSt+FaH8slsU/w5H/mS9teE9IOMn3oa9
         8wQjz0qCD4EQlPDkhnYds5Qx20eFpPtJeFT8mIS/jXz31R4xJTUBqrn81jzxVbnDjsvg
         HHtja970xq11ozbd0X5BG/5o4FeaZM9dnBMNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=BV0b4cJJbVXlg11MsamI722yzBUEodatabzMVpD9hN7BCLqee/OZM0jxvAOJoNAL2m
         M0qqeb1ZatVvHIA7VxIE0f5ZzIWLUUcdcJFcoPYIMPXgaj88sBcPBxWP7oy43pFxLe83
         +XJt5yRoVU8wTs5T3EtnKvmoU5Aq9lVe3PdRo=
Received: by 10.66.220.17 with SMTP id s17mr3214547ugg.48.1219921777165;
        Thu, 28 Aug 2008 04:09:37 -0700 (PDT)
Received: by 10.66.234.6 with HTTP; Thu, 28 Aug 2008 04:09:37 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The patch series below allows git to use %as and %cs as flags for
pretty-printing the format of a date.

Nathan W. Panike (2):
  Document %as and %cs as a pretty format flag
  Give %as and %cs meaning for pretty format

 Documentation/pretty-formats.txt |    2 ++
 pretty.c                         |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)
