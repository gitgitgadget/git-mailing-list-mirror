From: Timo Sand <timo.j.sand@gmail.com>
Subject: Fwd: Bug: git web--browse doesn't recognise browser on OS X
Date: Thu, 14 Mar 2013 11:39:28 +0000
Message-ID: <CAMxBVStw-b3J_Fm9x=h3==9ebdLUkpjBSQ9-W4+zJ9N20ojfxg@mail.gmail.com>
References: <CAMxBVSs6dJFnK78E2Da7t4V9ndJFRVDZEd1fR5QuCFz=u2Bnpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 14 12:40:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG6WW-0005sa-DP
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 12:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757000Ab3CNLjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 07:39:51 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:33653 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972Ab3CNLjt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 07:39:49 -0400
Received: by mail-qc0-f178.google.com with SMTP id j34so954053qco.23
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 04:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=0TGt+wqXozx9LDA6fq7lK+DvKxAajXbWesT59aZcsFI=;
        b=Qxo8aMNcGXhXnb3Jsu3gBZjUF1g3GUoWgiLJRjxTLcKuynmB+ZpLzuctF8V9ZnCpBS
         BRVHK+6LIvXMcaGy/6srWmK/vsbVyGonlu4vXTKAUAFy908u2tRZM81GtdI59GbSg3D4
         m4l2f9+AhDQgPe7/n6OFsWRSdIQCnyGftMXoFQpFDNbRG3RjNX0mV+qrp74Ct5zBJicW
         JLXzOt2+NhmShCtVYheLYM0D3QFV5c72VXWum1nS0lleUf1r/Bl8S3HgQ6viir1a58AD
         jOaAHTm3bOuK3OGqD7cRV/FsDZ+VPDGgqoNpbC77BLrAvQguCjBgHgKC2kt7JLfCL6Jb
         6YtQ==
X-Received: by 10.49.30.70 with SMTP id q6mr2797451qeh.28.1363261188523; Thu,
 14 Mar 2013 04:39:48 -0700 (PDT)
Received: by 10.49.116.68 with HTTP; Thu, 14 Mar 2013 04:39:28 -0700 (PDT)
In-Reply-To: <CAMxBVSs6dJFnK78E2Da7t4V9ndJFRVDZEd1fR5QuCFz=u2Bnpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218128>

Hi

I tried to open a website by runnin 'git web--browse http://google.com'
and it replied 'No known browser available'.
I also tried with '--browser=chrome' and '--browser=google-chrome' but
the responded with 'The browser chrome is not available as 'chrome'.'

I expected the command to open a new tab in my browser in each of the 3 tries.
This has worked for my system before.

OS X 10.8.2, git 1.8.2, Google Chrome 27.0.1438.7 dev

--
Timo Sand
timo.j.sand+sig@gmail.com
