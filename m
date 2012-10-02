From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [ENHANCEMENT] Allow '**' pattern in .gitignore
Date: Tue, 2 Oct 2012 12:51:49 +0530
Message-ID: <CALkWK0nXfeAnFfdFtdDNdEwtk0mMPtpYbg8sPzfrEXUpXsGQOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 09:23:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIwo9-0005vO-1B
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 09:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab2JBHWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 03:22:11 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43555 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab2JBHWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 03:22:09 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so305847qad.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 00:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=TZq7SzlK2I5RX2NAAUpkCC6un8UNJ/D1+qYKnbQlZ7Y=;
        b=PNC9ZTMzjypjRoNXT/WM+vM2v2y6QQtz3UHrGKto3EVgERHHKqH/nEMoEsulsIQUjp
         QOXJoSIQLGK3Yku4rXxGTXvWtWV1CG7un9ynqdlBfOIcImO10g6KC48rnuKAFXICzaxN
         W+AsIisvkykDkcSb6cN2MAZWhY5BU0t4yv5X2M0TSVli/o07Ji+4O8poQMS3w58KaEjd
         P7UxtAB0RJERnOIB46vCfov+Z8Q1/LJZgumExz2oa4LipsIo1hixff9bCebPqcuM/T1e
         O1Gyhj6R421xZb3bP93J6CjHYo/gZ5wCBGGwfz3H89tK6V/9qHbbalFgJYuACaf6/djt
         wDdQ==
Received: by 10.49.48.111 with SMTP id k15mr3332758qen.28.1349162529259; Tue,
 02 Oct 2012 00:22:09 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Tue, 2 Oct 2012 00:21:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206785>

Hi,

I've often found the '**' (extended) shell glob useful for matching
any string crossing directory boundaries: it's especially useful if
you only have a toplevel .gitignore, as opposed to a per-directory
.gitignore.  Unfortunately, .gitignore currently uses fnmatch(3), and
doesn't recognize '**'.  Would extending the .gitignore format to
accept this be a useful feature?  Would it involve re-implementing and
extending fnmatch, or is there some other way?

Ram
