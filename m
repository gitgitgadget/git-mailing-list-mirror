From: Mathias Lafeldt <mathias.lafeldt@gmail.com>
Subject: [ANNOUNCE] Sharness - Test library derived from Git
Date: Tue, 17 Jul 2012 10:06:45 +0200
Message-ID: <CAMFa-2hS-5CHQj79KMGwY7_qv6nGiK+9cKeDdihMVmSoxfsesQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 10:06:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr2o3-00059b-6D
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 10:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589Ab2GQIGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 04:06:49 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57535 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab2GQIGq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 04:06:46 -0400
Received: by bkwj10 with SMTP id j10so83534bkw.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 01:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=4iVUvGiLoMVxchvwj+kQWuAJbDfJQmAc0LJIciTz4h4=;
        b=TJLlwSJ+GaeEJ/0tnJ7ErhEVUcf16vzY4czhlCSTLmSxyYT8AcKZcjyBb3dMgZmYNe
         bVUie0woneTYDeltGBBQO3I6D93nZm61ZJvwhOFiFdGJKUsl58DPqNGCgDVXuClMKwWT
         raXpffmKhsbQnnvsRgcJYvL1Km3WZ4umnB0Kvohc7dcQLllmAcRi0MXNn6zLZl90gopP
         h3RXkBGTKeO93g2bVruWOAWifuB8snOGcVXxWsMhiHU09FrERngoofgnSwwagUMca/r+
         0zriUBKujbQOfIeG42+sAzrF8twcSyaEQPR5mgQnDbcClGtLgmKC+fv3aMmN7a5ftYkQ
         2GTw==
Received: by 10.204.157.135 with SMTP id b7mr485085bkx.61.1342512405395; Tue,
 17 Jul 2012 01:06:45 -0700 (PDT)
Received: by 10.204.198.5 with HTTP; Tue, 17 Jul 2012 01:06:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201591>

Hi,

I've been wanting to announce Sharness [1] on this list for quite some
time now, but never managed to do so. With the release of version
0.2.4, I think it's about time to change that.

Sharness is a shell-based test harness library. It was derived from
the Git project and is basically a generalized and stripped-down
version of t/test-lib.sh (I basically removed all things specific to
Git). So when you know how to write tests for Git, it should be very
familiar.

I've been using Sharness to test my command-line applications [2] for
over a year now. It's especially useful when you're doing continuous
integration with a service like Travis CI [3].

Development of Sharness takes place at GitHub [4]. If you're
interested, there might be some things I could contribute back to Git,
e.g. the API documentation [5] I wrote in TomDoc format.

Looking forward to your feedback.

[1] http://mlafeldt.github.com/sharness
[2] https://github.com/mlafeldt/sharness#projects-using-sharness
[3] http://travis-ci.org/
[4] https://github.com/mlafeldt/sharness
[5] https://github.com/mlafeldt/sharness/blob/master/API.md

-Mathias
