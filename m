From: skillzero@gmail.com
Subject: Fix commit message after push?
Date: Sat, 27 Dec 2008 13:13:46 -0800
Message-ID: <2729632a0812271313l74e9bb85l857a3ad3a3f0d8d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 22:15:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGgV5-0000bU-IK
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 22:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbYL0VNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 16:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbYL0VNu
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 16:13:50 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:12597 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbYL0VNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 16:13:49 -0500
Received: by an-out-0708.google.com with SMTP id d40so1334988and.1
        for <git@vger.kernel.org>; Sat, 27 Dec 2008 13:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=9i6fs1NKaGcehn9ocqqKPYZCyRKpizoNIO1KaG14AKw=;
        b=nQ0T88DrNc+QOiBfElfNoVHkIexEWgzYvYGxY2Dtn9bSuld/1SdvuwFiiDW6JgcSRN
         Ef7PQg/vQdyFL1Zbp130Yy5M22qkagaZtrIcEyDVb06MlfGjaX5eSb+wNTKNH9f2NKi9
         zRhp2agk2iswP5rrlASgb8XWx/4Qr8LmBqrMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=AVCrWaRcjCPYokS/xLbNFRJCtX+Sxg7SxHFBsx3kOeAhtkPgyc26xjX1q5RHW6RSZ3
         dCHIaXJT4V+w4yvNRPvIwMcP0lxccCguUHx1LjImo65/4MqKGRwb4InWWAMujq8yZE6p
         S7rIGMxUI0z97ujJ/oZ+cu1TSlHnFmFj1Zbos=
Received: by 10.64.209.6 with SMTP id h6mr9380836qbg.10.1230412426878;
        Sat, 27 Dec 2008 13:13:46 -0800 (PST)
Received: by 10.65.192.6 with HTTP; Sat, 27 Dec 2008 13:13:46 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104015>

Is there a way to fix a commit message after the commit has already
pushed to someone else? I typed the wrong commit message then I pushed
to the remote repository before realizing it. I tried git commit
--amend to fix it in my local repository, but it rejects the
subsequent push. I somewhat understand why it's rejecting it (my
--amend rewrote history and now they are out-of-sync), but I was
wondering if there is a general way to handle situations like this
with git.
