From: Yang <teddyyyy123@gmail.com>
Subject: "git apply" can't add new files to repo ?
Date: Fri, 15 Jul 2011 12:02:19 -0700
Message-ID: <CAAnh3_-ayozWnHR-ViJ3zjXQvPQA1kd9spGV_TEU=-kFzBytvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 21:02:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhnea-0004hv-Ly
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 21:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab1GOTCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 15:02:20 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33184 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab1GOTCT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 15:02:19 -0400
Received: by ywe9 with SMTP id 9so669459ywe.19
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=9mkKkHWdRPlymEN1Lvi98YuDdgLBAoKHLp4B5G1s794=;
        b=pYa5SF+K/7Tf2gESRIVSTQCX+uDwn3gKasuAfQyy+RAjXxvfk5wfDk01gbpjXhNUot
         2zQXNUST9K+Eqi4O4VtX+TJHa1GXnLJ4CwrqSGzK9jyR3LzkK7PfoNFwqgOAG7TWUVY4
         bHx6cGu72VWmPXiT04HmtuA0Y8yaKHPhkK7w4=
Received: by 10.236.170.67 with SMTP id o43mr4639392yhl.141.1310756539186;
 Fri, 15 Jul 2011 12:02:19 -0700 (PDT)
Received: by 10.236.202.166 with HTTP; Fri, 15 Jul 2011 12:02:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177213>

I created a patch by "git format-patch", and this patch includes some
newly-added files.

when I got back to the original branch, and apply this patch, the new
files appear, but they are not
added to git repository, so I have to manually find all the new files
and do "git add" for each of them.


I guess there should have been a way to automatically do "git add" for
all the new files in the patch,
how could I do that?

thanks a lot
Yang
