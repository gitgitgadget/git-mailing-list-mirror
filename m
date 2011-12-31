From: nn6eumtr <nn6eumtr@gmail.com>
Subject: How to deal with historic tar-balls
Date: Sat, 31 Dec 2011 14:04:58 -0500
Message-ID: <4EFF5CDA.5050809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 31 20:05:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rh4En-0001JQ-Ai
	for gcvg-git-2@lo.gmane.org; Sat, 31 Dec 2011 20:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943Ab1LaTE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Dec 2011 14:04:56 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60762 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab1LaTEz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Dec 2011 14:04:55 -0500
Received: by qcqz2 with SMTP id z2so8839727qcq.19
        for <git@vger.kernel.org>; Sat, 31 Dec 2011 11:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=GlWnLXpjhwbHXTAKaWgjuAg3MYNg2Xb10ZwmS9lIc+g=;
        b=deknvK4fZE0gdRV8kPRqvVhUomjRA13CDaOjL3qHLj4Rxl47u6MWsqzfe/vUxR6WOv
         irrtQknuAs0NFFyyHnbMQkQNiZIvpanN1NHdgN2jTQq4tcou2eaxo/mCx0Ovmvaj4Kae
         0a0usUCYd+hhuDrXM7Hlvu+RuJ6F7i+IHB9PE=
Received: by 10.229.135.85 with SMTP id m21mr16007330qct.26.1325358294549;
        Sat, 31 Dec 2011 11:04:54 -0800 (PST)
Received: from [192.168.0.7] (cpe-24-90-181-153.nyc.res.rr.com. [24.90.181.153])
        by mx.google.com with ESMTPS id dj9sm80778627qab.18.2011.12.31.11.04.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 31 Dec 2011 11:04:53 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187814>

I have a number of older projects that I want to bring into a git 
repository. They predate a lot of the popular scm systems, so they are 
primarily a collection of tarballs today.

I'm fairly new to git so I have a couple questions related to this:

- What is the best approach for bringing them in? Do I just create a 
repository, then unpack the files, commit them, clean out the directory 
unpack the next tarball, and repeat until everything is loaded?

- Do I need to pay special attention to files that are renamed/removed 
from version to version?

- If the timestamps change on a file but the actual content does not, 
will git treat it as a non-change once it realizes the content hasn't 
changed?

- Last, if after loading the repository I find another version of the 
files that predates those I've loaded, or are intermediate between two 
commits I've already loaded, is there a way to go say that commit B is 
actually the ancestor of commit C? (i.e. a->c becomes a->b->c if you 
were to visualize the commit timeline or do diffs) Or do I just reload 
the tarballs in order to achieve this?

All replies appreciated!
