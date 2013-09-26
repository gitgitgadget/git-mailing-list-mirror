From: Francis Moreau <francis.moro@gmail.com>
Subject: git-log: --cherry-mark option and %m placeholder
Date: Thu, 26 Sep 2013 09:46:09 +0200
Message-ID: <CAC9WiBhu5aW+h-YPKo+Uyg__TE06yBXeybYkBNKYKJQUZBMx3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 26 09:46:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP6H9-0004MF-L0
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 09:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720Ab3IZHqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 03:46:12 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:62242 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab3IZHqK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 03:46:10 -0400
Received: by mail-ve0-f181.google.com with SMTP id oy12so586670veb.40
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=hy5eYBR4/d/PMZ86vdevYNfI3jFS0t3s0ud8vUzotfM=;
        b=tromm2ObL/MTWnJF268VJQapRdreg/VRQM/Q4/tyBMsHoWPsxMMFmYJZyqYR8L/7dn
         sdiWaxyjuQkgaD/89TMBuSpKmUtc8A1b16vYmJNW1I0lbKwx7a7NsNUj2M0CFCrF2YGY
         Y2709xsyKlJ871duGSJTiltFz7hHyXcZjmgDcy1EGvvQW8blaL52KEu/uWZaPtF4lvCp
         71TTEFxXy0sDCdc/3P6QUzNXsLFNE6whkJPuBbOoCPhJTPW27zCHlaOTa+IqDa8/cgeM
         r25WmHESXIzAsWnOnrtYW9E9CBPJFCohcJdkCsojEb2KAGaU1iLa/btdJQFRMol7i/wC
         siwQ==
X-Received: by 10.220.145.75 with SMTP id c11mr65996vcv.30.1380181569933; Thu,
 26 Sep 2013 00:46:09 -0700 (PDT)
Received: by 10.58.8.169 with HTTP; Thu, 26 Sep 2013 00:46:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235402>

Hello,

When using --cherry option (which implies --cherry-mark) the mark
boundaries are "+", "-", "=" when revs are displayed.

But if I'm displaying them with --format=format:"%m %H", it's still
using "<", ">", "=" instead.

Is that expected ?

Thanks
-- 
Francis
