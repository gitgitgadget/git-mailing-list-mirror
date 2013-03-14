From: =?windows-1251?B?yu7t/Oru4iDF4uPl7ejp?= <kes@reg.ru>
Subject: git merge problem
Date: Thu, 14 Mar 2013 23:27:17 +0400
Organization: =?windows-1251?B?0OXj6PHy8ODy7vAgxO7s5e3t+/UgyOy47Q==?=
Message-ID: <15610448431.20130314232717@reg.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 14 20:27:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGDob-0006wS-VO
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 20:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab3CNT1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 15:27:23 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:47890 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab3CNT1W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Mar 2013 15:27:22 -0400
Received: by mail-ee0-f53.google.com with SMTP id e53so1261385eek.40
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reg.ru; s=google;
        h=x-received:date:from:x-mailer:organization:x-priority:message-id:to
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=nAduZ14urYOvRV3q1lks4Orszz23vKBqctfP0qnGqKY=;
        b=mb+74wgRE5X2u/YeSNHiGIEAMljBdcq7kX2uL5lJgsRvu+f2tYUHEVVv0k4Bcb2mM2
         YxHur9bhuVHkVCFve2mpooaUPUw98ZLwh7YaWKPW4BXhNS2+8CyhsYMs9rZ3e5qzwSSm
         2cyjWspqZw9FgXv8kf/ZNBIZPbmYSaMe2W7d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:x-mailer:organization:x-priority:message-id:to
         :subject:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=nAduZ14urYOvRV3q1lks4Orszz23vKBqctfP0qnGqKY=;
        b=e4vTmncx2IQ2KCYuFpTRrtAk1kJjwJB+a+siO62+cCplMTISRrzXHhT6rv/gxdhtwq
         MCHlEPQdEexNOxLjTOeykHxwlqJGDFhDdW/4DDxAFzqLUdIeq9VQqxx6O6wNYXBo1OSu
         PAbAM9kHl98LmJjzme2luqvM6jXeiBZWUjzM216v+a4zRKCClP33qP3X8xLPDCCQbvv2
         FYiDdgrmrsPub5SPrXT8emep0rgreDJoFYPX16L3kkpSMOQdDcCiCAx+z/uomR0DvKWn
         4i6T9iK2UVyP45TPA+1LQ/89T7o7rfzrsIOwMQEe8MDsYJh4RbTlbKVhWG5cYkhvw6oi
         Z/cQ==
X-Received: by 10.14.4.69 with SMTP id 45mr10162179eei.0.1363289241381;
        Thu, 14 Mar 2013 12:27:21 -0700 (PDT)
Received: from KES-PC ([77.93.52.13])
        by mx.google.com with ESMTPS id 3sm5623808eej.6.2013.03.14.12.27.19
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 12:27:20 -0700 (PDT)
X-Mailer: The Bat! (v4.0.24) Professional
X-Priority: 3 (Normal)
X-Gm-Message-State: ALoCoQkF1m1GEbBSblH0e2P1DMH/POtjrVB0KUJyHjY1DEhBUIkhxy4lLL3IJOEct2Vegfd7etnK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218160>

Hi

I have started branch from master
then on master were changes in whitespace (code formatting)
in branch on that lines changes were not.

Now when I try to merge branch to master I get lost changes at space on master
So I try to ignore space change

git merge -Xignore-space-change my_branch
 I have lost formatting in master.

I wanna to give priority to changes on branch master:
git merge -Xours my_branch

and now also no results: I get old space formatting which were on
branch master before starting my_branch

Please tell me, how can I fix that problem?
# git --version
git version 1.8.1.5


git diff master...new_function_find Domain.pm
index 7eb8191..5abba1c 100644
--- a/lib/FrontOffice/Controller/API/RegRu2/Domain.pm
+++ b/lib/FrontOffice/Controller/API/RegRu2/Domain.pm
@@ -124,7 +124,7 @@ sub get_prices : Local {
         return;
     }

-    my $show_renew_data  = $p->{show_renew_data}  || 0;
+    my $show_renew_data        = $p->{show_renew_data} || 0;
     my $show_update_data = $p->{show_update_data} || 0;
     my $lang             = $r->{lang};

as you see on branch master right formatting will be replaced by wrong
formatting on branch new_function_find

as I have said: doing #git merge -Xignore-space-change new_finction_find
no result :_-((

the wrong formatting on branch new_function_find are old formatting
that were in branch master, before branch new_function_find were started
no changes were made to that line on branch new_function_find

while on branch new_function_find all new changes from master
were merged as:
#git merge -s recursive -Xignore-space-change master

please help
