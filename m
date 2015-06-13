From: karthik nayak <karthik.188@gmail.com>
Subject: [GSOC] Week 2: Unification of tag -l, branch -l and for-each-ref
Date: Sun, 14 Jun 2015 02:10:20 +0530
Message-ID: <CAOLa=ZTYfrUyy4Z+xOwOH+KgWy2-0htkR5QdzNYUL4_5u-QioQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 13 22:40:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3sEQ-0004Oj-Of
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 22:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbbFMUkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 16:40:43 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34599 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbbFMUkl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 16:40:41 -0400
Received: by oigz2 with SMTP id z2so38993792oig.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=RuwscAqy1lfmtZYjgzZ8IR91hocYRMb8PZWmCfjoD2Y=;
        b=jBWV8I+Fl1/7uPm1tcZzc7gsM40b8lHpADiYNHIMOwn8p2i+n7gAI1sPj2e5gjKQNU
         MmBjtTDcDEzlwFSO7ngoOHYLCcetUGCsSIdAs4n/hCRlCcNCVJzq+vaJ7TWflhuX+tOx
         uRdH2zSw74y/TG1FJ9dsrSb7SVRt5R1atkCyE7q+wqKsUnYKUtU0gNRgDAqX62OqexUr
         INg7EO2m2RkpvDMnkS5boHloFtqyMFUMZKoVZ9zz46G/6HORmxs7FwxWNZw8FCabQqUK
         vaPAfJsFCTD71OG9KNwfdQzHkKqA5mEqT1fpoVyz0fn7TfcIsE27MAlvqCT9EZmt4NJH
         /o2A==
X-Received: by 10.182.213.37 with SMTP id np5mr17518621obc.42.1434228040992;
 Sat, 13 Jun 2015 13:40:40 -0700 (PDT)
Received: by 10.182.28.5 with HTTP; Sat, 13 Jun 2015 13:40:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271590>

Hello All,

As part of GSoC I'm working on the Unification of 'for-each-ref', 'tag -l'
and 'branch -l'. I will update the list on my weekly progress in an effort
to keep everyone updated.

Current Progress:
Currently I have two patches for review on the mailing list.

1. [PATCH v8 0/11] Create ref-filter from for-each-ref
(http://article.gmane.org/gmane.comp.version-control.git/271563)
This is basically related to the movement of code from for-each-ref to
ref-filter. ref-filter would act as a base for tag -l and branch -l. They can
eventually use the ref-filter APIs to implement the --format and --sort options
provided by ref-filter.

2. [PATCH v2 00/11] add options to for-each-ref
(http://article.gmane.org/gmane.comp.version-control.git/271575)
This relates to the addition of options like '--points-at',
'--merged', '--no-merged'
and '--contains' options to ref-filter and making use of these options
in for-each-ref
and implementing tests for the same.

Work in progress:
You can follow my current progress on Github:
https://github.com/KarthikNayak/git
Currently working on bringing tag.c on board and making it use the
ref-filter APIs and implement the various options provided by
ref-filter.
This might require an option of having ref-filter sort based on
version no when listing refnames.

Whats next:
After getting tag.c to work with ref-filter APIs. Start porting branch
-l to use ref-filter
APIs too.





-- 
Regards,
Karthik Nayak
