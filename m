From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: Merge option suggestion (dictator, humble)
Date: Tue, 16 Oct 2012 23:52:09 +0800
Message-ID: <CAHtLG6TYEstro0J5jFJc1sZMoLC9gkHWrZdu4Y=hz-+kKkqXTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 17:52:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO9RO-0003eo-3G
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 17:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250Ab2JPPwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 11:52:11 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:56741 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939Ab2JPPwK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 11:52:10 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so4283994lag.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=0vtm9M8XURCES+E1hzRMdsRiPqgWLwhsA8YHm4NMk6I=;
        b=tYYbMbGQYZhhEmGNTeDn8jDd47mCEstOV1xdxP3Q5HBTcM/crEB56CL5qWNnhCclit
         j65uHEYNlCLPZC3FWMDchS8/zUOuTNdjH28bvgsl0mdu0U0yIK6DZtmXsIb9q5G9cFHq
         37FuxGgH3wE33urX1EXAxMmhunSAO9hHJsT6xMysKsoOQpu+P85vMAETdbsz2sURBar9
         Y93Y16pX+0RqZ6XyTXNFR52+1E7ZINbBCkOeqMW719fBIpmMA2qzIRXTK7QExiU3Rx26
         2od9085OlUctaCqGiSl0ums9GQsVTISIvbdypz3BKgfUiom6H7azympAOvpaQB9f+1Yd
         YtdQ==
Received: by 10.152.106.79 with SMTP id gs15mr13323559lab.31.1350402729329;
 Tue, 16 Oct 2012 08:52:09 -0700 (PDT)
Received: by 10.112.5.70 with HTTP; Tue, 16 Oct 2012 08:52:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207838>

Hi,

I would like to suggest 2 merge options
--dictator   use all my changes
--humble   use all their changes

These allows to produce a fast-forward commit, without resolving any conflicts.
Sometimes, someone did something completely wrong, so the commit needs
to be ignored.
I cannot tell everyone in the world to run git fetch followed by git
reset --hard.

Regards,

ch3cooli
