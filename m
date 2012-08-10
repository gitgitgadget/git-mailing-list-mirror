From: Matthew Korich <matthew@korich.net>
Subject: =?windows-1252?Q?git=2Dp4_migrates_perforce_=93main=94_branch_into_git_?=
	=?windows-1252?Q?branches_as_subdirectories_=28doubled_code_in_git_branches=29?=
Date: Fri, 10 Aug 2012 12:14:58 -0700
Message-ID: <CANWnr5aqswATTM9_Zyw=w_x01=e8CqoCsn0Ybee0XvGSJ3F_yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 21:15:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szufq-0003Uq-U8
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 21:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760010Ab2HJTPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 15:15:01 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:65180 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab2HJTPA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 15:15:00 -0400
Received: by vcbfk26 with SMTP id fk26so1910964vcb.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 12:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=eIj5mwnrq2LWHDirW3plZBABFmTub8+mYhUVVwuuLsc=;
        b=KcAy9aKsLfy6K6/JUj7GuHv986Z228NX7tq27DgKANtVl8fv6yswEuqW/y7QaVSazT
         68VrAT5TuRtAh8Rj8Et/7ykW8EkPRERIft+I7TYoeZF/u1AJxmRBggRNJ2dKreheeouz
         uSPmAZFfjmkbZeRdYuTpOCNb2agawuh4VXoedtsQ5dFnkJzw1siJi70fiyY8rW1mHd7Y
         XF861h498eTPlK1q52u+lE0AhI2si5Kv0fH37VR8cP92lTKkpptw0BRk4oLlRHEr7b52
         PduGsz1KkA+UJO0jdp1ajV+Jyvhauj8m+RLpTmSD9jw1PpE+LGEONuI6aDTmFZ2jpLvc
         KzaQ==
Received: by 10.220.219.7 with SMTP id hs7mr3397990vcb.0.1344626099392; Fri,
 10 Aug 2012 12:14:59 -0700 (PDT)
Received: by 10.58.65.33 with HTTP; Fri, 10 Aug 2012 12:14:58 -0700 (PDT)
X-Google-Sender-Auth: hh44DPcmvN2FMkaq5cn-Z5nQP-U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203250>

Using git p4 on git version 1.7.12.rc2 has path issues. Standard
clone/sync ops apparently place detected master and branches on
independent and parallel directory structures instead of git branches.
See http://stackoverflow.com/q/11893688/1588831 for a full demo of the problem.
Thanks,
-Matt Korich
