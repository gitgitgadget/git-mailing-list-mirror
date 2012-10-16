From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: feature request
Date: Tue, 16 Oct 2012 13:36:04 +0200
Message-ID: <CAB9Jk9AwTVM4TPwPg1Gmi8TCnnXWUsMAfaz8DdfcEhBNW_15Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 13:36:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO5Ra-0008Be-Ap
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 13:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479Ab2JPLgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 07:36:06 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:41252 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab2JPLgE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 07:36:04 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so2895872vcb.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 04:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=RwKDYj2R07BivcWHjA65HEdqvRQueWMBrExNxl97Kmw=;
        b=VbxvzAwtkAuZXQqZOosy3LX44ZpCWrKZlyt0/8aF7oMrB1WWPCuAGlZ/frIypX/ghI
         8anyhySRj0rkzD5y/bWi1U+y+MnQrxtetBfX5gZYboiL4l284H3jqSBQ+Cf0eqn6RjKH
         8wrWvwmq6rtWNvrmCjWylY/KeA7QDY3yUamI4RwFx7sMthf8+Hi4ntdTG5XI5RkS3EPb
         3n7ZEz8+RaUQ2n+ASIavyeLS4L+Emi9GZpEWQEBBTSn7dQ5RP9ttMcseB6KdQjxFpz0J
         yivvQMXXlzJPh5Ghl27ewu+aw06Mwmw/ANn1Grfnv10H+2hnwPKafUerKhrRHlvmX9Rp
         vQ5w==
Received: by 10.52.90.2 with SMTP id bs2mr6839509vdb.23.1350387364214; Tue, 16
 Oct 2012 04:36:04 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Tue, 16 Oct 2012 04:36:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207815>

Hello,

some VCS, e.g. ClearCase, allow to control the fetching of files so as
to warn, or
disallow parallel changes to the same files.
As of today, there is no way to implement the same kind of workflow with git
because there are no fetch hooks.
Would it be a good idea to provide them?

-Angelo Borsotti
