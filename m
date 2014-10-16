From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Git log with follow & author not working
Date: Thu, 16 Oct 2014 11:09:45 -0500
Message-ID: <CAHd499DPx+1s+WTxJBEzgsJVy0M8AmuZzAx00mODWNy3KuCjdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 16 18:09:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xencc-0005gj-FP
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 18:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbaJPQJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 12:09:46 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:48591 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbaJPQJq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 12:09:46 -0400
Received: by mail-vc0-f182.google.com with SMTP id la4so2962691vcb.13
        for <git@vger.kernel.org>; Thu, 16 Oct 2014 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=9dh/qpwNiPu1aeuhWdOjwDaoQbgmhFRwrE2JcnR9vvA=;
        b=d8eYuxlAWXpAut0hItSr2S/lmCDN9BfPlkVU/cVAyf1R35lAWm5vaK3lomGIJgo2Fh
         Yfw6OW8XdNm4GcTO+/PK/x4Z76fqP3E/JSD/hguRQDA3GhvgCeG669QJDAHBnDoOw6ut
         f3qcj9c7bpKMc1ZeovTDxiDbJeswOzZIyGl32AE+SzQVvShrIb/VNVlu36Ouw7PzzQj2
         z1AWu7ItLLuoYJiHvwqz2998JMlkIis59smHS5GJ7QZaqTLwcoUDCIJ3vEMX5YHgTqb9
         gXjrzZl9U0tx/RE/hxf7fn+H+1KFKixZYvSEy5d/RYGIV7pv3lZo5p6dDVtEnKlXn1NL
         CQ6A==
X-Received: by 10.52.26.116 with SMTP id k20mr1545175vdg.82.1413475785421;
 Thu, 16 Oct 2014 09:09:45 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.3.200 with HTTP; Thu, 16 Oct 2014 09:09:45 -0700 (PDT)
X-Google-Sender-Auth: caVScLXgV2eHxuQcm0TfCI4niZ4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have relocated a file into another directory and committed that.
Using the --follow command on the NEW path of the file, I want to find
all commits to that file by a specific author:

$ git log --follow --author david -- new/path/to/file.cpp

When I do this, I get NO results. When I use the OLD path to the file, it works:

$ git log --follow --author david -- OLD/path/to/file.cpp

Also --follow seems to work fine on the NEW path if I do not specify
--author. Is this a bug or am I using this command incorrectly?

Follow up assistance is very much appreciated. Thanks guys.
