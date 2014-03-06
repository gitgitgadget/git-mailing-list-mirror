From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: gc/repack has no option to lose grafted parents
Date: Thu, 6 Mar 2014 18:07:06 -0500
Message-ID: <CACPiFCLqa=ZQM6Azh2G5hwBCMx96Cxa5BMN=-2aCy5x=YhBpGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:07:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLhNz-0000Qy-WD
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 00:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbaCFXH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 18:07:28 -0500
Received: from mail-vc0-f177.google.com ([209.85.220.177]:61794 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbaCFXH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 18:07:27 -0500
Received: by mail-vc0-f177.google.com with SMTP id if17so627556vcb.36
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 15:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=9B/dlKH06PyeXXVIBzC7bIAZCts70hn939DujoTfEWE=;
        b=UedW9H45UxgJxbTmhA4wwbvpJYtptpDlVQw61wfZBYC1Tl912Ha/5Q1B5XHIVjD1Un
         Puo0Kr8hWEoGHf76Rtt80M4Iv4kUIZMa0J1lokzvKw3R6As2ZNJkYlFHNiScB2XEm1T3
         k98wldB+Kqc/7uBt0WzpcX8C3v+oBHlHl64Pdb0dJE3nIlWRjkFAFdg8CEbsx3XrH+aj
         RmgI6T/44EgGsK+QGO779XaqlSPyDwzZYZM2MpfmDD9qPDxvo8VmYLDOlHq6jiPFmdw3
         l0KkidKBg7xeeBaxMVs7+U+0ZZ1f/4dZ5Q18IwCbesdayTTJVlgC5sFnFifJtdOJ2ug7
         2ATg==
X-Received: by 10.52.30.230 with SMTP id v6mr9729655vdh.6.1394147246525; Thu,
 06 Mar 2014 15:07:26 -0800 (PST)
Received: by 10.220.183.138 with HTTP; Thu, 6 Mar 2014 15:07:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243568>

Back in http://git.661346.n2.nabble.com/PATCH-0-2-Make-git-gc-more-robust-with-regard-to-grafts-td3310281.html
we got gc/repack to be safer for users who might be shooting
themselves in the foot.

Would a patch be welcome to add --discard-grafted-objects ? or
--keep-real-parents=idontthinkso ?

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
