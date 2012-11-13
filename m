From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] remote-hg: fix compatibility with older versions of hg
Date: Tue, 13 Nov 2012 10:55:37 +0530
Message-ID: <CALkWK0k9Ta-SOo43Knz9kMV0ePKf7wjK-3Zm6ocDQpe7VzFz+A@mail.gmail.com>
References: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com> <1352742068-15346-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 06:26:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY90w-00074T-Hz
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 06:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502Ab2KMF0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 00:26:00 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51380 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab2KMFZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 00:25:59 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so7058843oag.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 21:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EC8ddsTwQl5YOv2Qj6pTJBUNKVNMqGHIKEnmfBFgOXI=;
        b=eBZKt4vmrvg+Yy7O7E1VRorHcR9WodgjWn42ZoXEkDXpNj18vpcjMLPlolbra//mjO
         I3Xx/gcAKNZmOCKWSZqdu4U+GY6vkCZOJByAL5cx1RnYhDlRUVH+Qmfqn0JefZ50860P
         kZbF4DqJQ33ivAneR6DjxQPyo74nZTyHIbfHzpUgBWud0dRIyFDnRGYVpWFKxUSdxNXy
         bwo++MPQOLOLI7Qxf9ADHg2k9R+gNOiBIZenXonECLJUEWLSp9bJwnFSoxYDxjzRPEnX
         AKV/+eBNR2DQRdy5vqMVOTbSut0vxoy6P9GdNdM5JC3a9d0qThbAQpNvuVS2cTHKUH1E
         OH7A==
Received: by 10.182.86.225 with SMTP id s1mr16937146obz.91.1352784358041; Mon,
 12 Nov 2012 21:25:58 -0800 (PST)
Received: by 10.76.168.40 with HTTP; Mon, 12 Nov 2012 21:25:37 -0800 (PST)
In-Reply-To: <1352742068-15346-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209574>

This patch fixes my original problem. So,
Reported-by: Ramkumar Ramachandra <artagnon@gmail.com>
Tested-by: Ramkumar Ramachandra <artagnon@gmail.com>

However, test 4 in test-hg.sh still fails for me:

--- expected    2012-11-13 05:22:57.946637384 +0000
+++ actual      2012-11-13 05:22:57.946637384 +0000
@@ -1,2 +1,2 @@
-zero
-refs/heads/master
+feature-a
+refs/heads/feature-a

What is going on?

Ram
