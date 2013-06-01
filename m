From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: can we prevent reflog deletion when branch is deleted?
Date: Sat, 1 Jun 2013 07:01:24 +0530
Message-ID: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Elijah Newren <newren@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 01 03:31:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiafK-0001kJ-VR
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 03:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758104Ab3FABb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 21:31:27 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33492 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954Ab3FABb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 21:31:26 -0400
Received: by mail-wg0-f43.google.com with SMTP id x12so1725488wgg.22
        for <git@vger.kernel.org>; Fri, 31 May 2013 18:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=ouamz9+QZdkpiG+oL2DVOEprYJesDgIQueLA0+bLzkA=;
        b=L5BMEqlnedGofJP0s1g7ElMfZsJnkipfvCt1yMMtr+i2eRMJhHua/dnHtn4jpfWleu
         y5HKhND7OJzMRYHYFb4LNdHnmy64CtLH9ChjtvLlVF32H6GVMxr+BuAHnfqw3g46T58J
         WTC1gduz82dcUqkWLXWDWSV5hfASyjEdUNShpOXsPjAp5EfPsm3y8D+yCsSYDO4H4nrO
         lMAul8NFtO8oYC9Tu4WAsxhQhmzzkx02TFjzhDmsbAW7L1TajGAZADIOpF9IchMk77kE
         utPmR+uR/I2EwP0o6t7k0wys5O1CQHOtLKmcZk0025krxj0v0Xq9VSNB948Glt6pFoq7
         PODQ==
X-Received: by 10.180.198.49 with SMTP id iz17mr5397350wic.39.1370050284955;
 Fri, 31 May 2013 18:31:24 -0700 (PDT)
Received: by 10.194.170.65 with HTTP; Fri, 31 May 2013 18:31:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226100>

Hi,

Is there a way to prevent reflog deletion when the branch is deleted?
The last entry could simply be a line where the second SHA is all 0's.

--
Sitaram
