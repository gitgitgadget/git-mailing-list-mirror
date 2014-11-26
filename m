From: Woody Gilk <woody.gilk@gmail.com>
Subject: git file listing is inconsistent
Date: Wed, 26 Nov 2014 15:10:33 -0600
Message-ID: <CAGOJM6+DTSn2qa-KTWceqyraaugX_YVZhirkdc+t+cDfFB4OyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 22:11:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtjrq-0006FW-Dm
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 22:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbaKZVLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 16:11:14 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46446 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbaKZVLO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 16:11:14 -0500
Received: by mail-ie0-f174.google.com with SMTP id rl12so3328235iec.5
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 13:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=SQsYYu7Oug2gdp79xMN5/jYqKVCPTeI7PA4kB/xVuB8=;
        b=dOeTcS0lqCNOZV9CmJXaNgLZcoOJrqviRP4L9dmX/OGvPgARn7sqqPHjs03asjAFBz
         Rvdv6qJBvSMAzRXBpKnJnDXwB7EW5REH+wsVZS8uUfZVRY64DYON3NV+oj2P49FtIsqe
         TQYjNwVlV3FFpfLfjZzGNqZ8ESomHTBhO8/i59qDAZOKJeG77GWUAfvAnz/x0GQoRnBC
         M/TT/+B7BG8pQE7DPAC15F4uvpkNdAMym9TJ0fR828sB6Bv2KLCnK0GMl5SXoHZrwTZE
         d1q2QCAetxB92WE00SXS1dYZsGD7PbYcFa2K+PbRpHeApQp9ZGgj5mIcLfSluYddJGqy
         M/7g==
X-Received: by 10.43.73.71 with SMTP id yr7mr6207307icb.32.1417036273219; Wed,
 26 Nov 2014 13:11:13 -0800 (PST)
Received: by 10.50.85.18 with HTTP; Wed, 26 Nov 2014 13:10:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260305>

git diff --name-only
git grep --files-with-matches

I think --files-with-matches should be deprecated and replaced with
--name-only for consistency.

Thanks,
--
Woody Gilk
http://about.me/shadowhand
