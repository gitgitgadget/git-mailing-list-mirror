From: Alex Coppens <alex@nativetouch.com>
Subject: Problem with rerere forget
Date: Thu, 14 May 2015 14:05:55 -0400
Message-ID: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 20:06:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsxWE-0001Z0-Rw
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 20:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbbENSF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 14:05:57 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32998 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbbENSF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 14:05:56 -0400
Received: by pacwv17 with SMTP id wv17so93388351pac.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 11:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=8jUn37F7tR6kFfuxkuDdIexdxsgxJnk63ryn6CO0IJ8=;
        b=e5Qmva/fi1AtGL5IHErFG/vGTgtZBZbUye73SKmeVHCcbIaOdkUkDI5RDHpkdlV7bJ
         lpglQ+Av5cclLcqOz9KLML8s2n/nU4BBqc0l61IrJbGxIDadbH7aXgyOCdx5OoVeKPa4
         /HdRf3b3r8NwAO+HBpMWnokeaO1TuZsS5e+SIpVqLNGEh1n8X5+ur1uRLFIl7Y/vCjyZ
         GaxqndJaIPxBQ3Y6jMabMfj7cg9jYGrFCInlxMyLjdwyz9c2PtWetorspmdLUJ6kQpCp
         hb9h3W+y1tQcrJTXGRdQ5v9gwd5vNFmTHNIQs1QT1ntAY6IFdga+ZomIw8dNbfO68t+0
         qZIw==
X-Gm-Message-State: ALoCoQkOMm+NyohxD77Xf/C+cxJHZyMd/cQHjA87TpK2FD0Ucgf7YO2BLg5Jk1Dxfek2n/uyQFb/
X-Received: by 10.66.249.168 with SMTP id yv8mr10507570pac.49.1431626755546;
 Thu, 14 May 2015 11:05:55 -0700 (PDT)
Received: by 10.70.45.135 with HTTP; Thu, 14 May 2015 11:05:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269059>

Hello there,

So I am trying to make git forget a conflict resolution:
_______________


git rerere forget path_to_file/file.js

fatal: BUG: attempt to commit unlocked object

_______________

Google doesn't seem to know the answer: No results found for "fatal:
BUG: attempt to commit unlocked object".


I think I am using rerere forget the wrong way. Can someone help?

Regards,

Alex
