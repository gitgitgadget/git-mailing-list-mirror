From: Jeenu V <jeenuv@gmail.com>
Subject: What to do with patches that should go upstream?
Date: Wed, 13 Jan 2010 15:21:11 +0530
Message-ID: <5195c8761001130151q12ac636cnc69513087320195@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 10:51:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUzt2-00040Z-2x
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 10:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab0AMJvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 04:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755219Ab0AMJvc
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 04:51:32 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:60471 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab0AMJvc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 04:51:32 -0500
Received: by qw-out-2122.google.com with SMTP id 8so3568621qwh.37
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 01:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=ei+MBbsinkqcq+j06Neuou/FCRx8sIAvDtPArZfdj3A=;
        b=M+ahwaNJ/q6kfaD1USJl7DIjRqtDw6v3Wkvln4AB6cUpCr2NnJThz8Ko0fltcrLH8C
         hVod41y3BCdUumSjcPg4IFg6Uza1Xh1pnQE3f17EHzqMx0dKwKG8UXGez96lLFfISeR2
         1RpQQ0D2qrMP/IkrC1t2ZVSFTz4fQjKdVRV1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=KCK9hvva76UPpfcl8LRSMRFqrU91ssyfPLzbmyjM6wBtnywQHHgF/RyT64VDSrqyjq
         fQW0YaD7o8rNOagx3QfhywiijK6i8i/LvbMelxBymiw+WDjYuxMLcUFiPuXnD2zP/Jvx
         QY847wmHghQZaZBjaN99pmEFYfLhXPngTombQ=
Received: by 10.220.122.201 with SMTP id m9mr396865vcr.4.1263376291210; Wed, 
	13 Jan 2010 01:51:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136805>

Hi,

I'd like to know what's the best practice to follow when one discovers
that a change that's been applied on the current branch, has to
actually go upstream. For example, in the following figure,

     A
-O---O-+
        \        A'  B'
-O---O---O---O---O---O---O W
            /
  -O----O--+

W is the current working branch. But there are commits A' and B' which
should go upstream. What I wanted to know is the next step from here.

1) Do I switch to A and B, and then cherry pick the commits A' and B'?
2) If I send the patch out to include in upstream, wouldn't it
conflict the next time I happen to merge from A or B?

Please suggest.

-- 
:J
