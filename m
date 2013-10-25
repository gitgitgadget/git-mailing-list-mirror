From: Francis Moreau <francis.moro@gmail.com>
Subject: git describe --contains --abbrev=0 <sha1> doesn't work as expected
Date: Fri, 25 Oct 2013 17:56:26 +0200
Message-ID: <CAC9WiBhFRRkwiWH9H4BSUdLrktst5e6MaZd0PLwf03seUUq9eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 25 17:56:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZjkV-0007Pe-P0
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 17:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab3JYP42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 11:56:28 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:59054 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab3JYP41 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 11:56:27 -0400
Received: by mail-ve0-f181.google.com with SMTP id jz11so2718069veb.26
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=OOqB/bjBFiLN5TC3AW+9rXrrIvBnXa25u+MVXtIwxXk=;
        b=Z7aosUAfddyMVZhmP/UvsQpWhMMnphuIM8dChPNDam+nEEepYDqpC+qftlgYrF4h/G
         64jzGV27GKp95cKAQ6szbwWSPFn2AIhfr5jKynPK8a4CLMicDshzXCYyIlEsp+CQH5nH
         mT1jpHjH4XPepFEs9DMS/xiLstn9eEgiqzRiol5nn4znQz1FUS5pWh2DWnHbRhMrqANV
         GGpGjIzIVHfgBBJFnzU2FUm+eddrQcyRtubnQYKuDlSSBqqWOPyK0sL4/U0e+3PdauVH
         oUIXLCwLASfkkC05W04p6MBg6DbH1E9vJHnQATPWlJq6BS72txa+bKTVlyxlxeyYFHLP
         D/Cg==
X-Received: by 10.220.145.75 with SMTP id c11mr737916vcv.30.1382716586679;
 Fri, 25 Oct 2013 08:56:26 -0700 (PDT)
Received: by 10.58.218.39 with HTTP; Fri, 25 Oct 2013 08:56:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236707>

Hello,

Basically doing: git describe --abbrev=0 <sha1> gives the closest tag
from <sha1>

I would expect adding "--contains" option would give the closest tag
containing <sha1> but it seems that --abbrev=0 has no more effect in
that case:

$ git describe --tags --contains --abbrev=0
7f285fa78d4b81b8458f05e77fb6b46245121b4e
v2.6.35-rc5~14^2~4

Is that expected ?

Thanks
-- 
Francis
