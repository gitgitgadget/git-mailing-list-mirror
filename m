From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: t7063-status-untracked-cache.sh test failure on next
Date: Wed, 21 Oct 2015 15:37:16 +0100
Message-ID: <5627A31C.10906@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 16:37:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZouWB-000095-32
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 16:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392AbbJUOhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 10:37:23 -0400
Received: from avasout08.plus.net ([212.159.14.20]:49702 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbbJUOhV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 10:37:21 -0400
Received: from [10.0.2.15] ([87.114.3.134])
	by avasout08 with smtp
	id XqdG1r0072tV80P01qdH8T; Wed, 21 Oct 2015 15:37:19 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bI7rW6KZ c=1 sm=1 tr=0
 a=qQ71F3v+nKp5qei/W0vv8w==:117 a=qQ71F3v+nKp5qei/W0vv8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=7I1cOqIWGEDzTnf3XrYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279983>

Hi Junio,

While testing the next branch today, I had a test failure, viz:

    $ tail ntest-out-fail
    Test Summary Report
    -------------------
    t7063-status-untracked-cache.sh                  (Wstat: 256 Tests: 32 Failed: 22)
      Failed tests:  1-18, 20-21, 25, 29
      Non-zero exit status: 1
    Files=726, Tests=13035, 394 wallclock secs ( 3.61 usr  0.51 sys + 82.93 cusr 256.21 csys = 343.26 CPU)
    Result: FAIL
    make[1]: *** [prove] Error 1
    make[1]: Leaving directory `/home/ramsay/git/t'
    make: *** [test] Error 2
    $ 

However, I have not been able to reproduce the failure, so it
seems to be an intermittent fault. (Unfortunately, I trashed
the 'trash' directory before thinking to save it - although
I almost always find it useless for debugging if you haven't
run the test with '-i -v' anyway.)

So, this is just a 'heads up', since I can't debug it. :(

ATB,
Ramsay Jones
