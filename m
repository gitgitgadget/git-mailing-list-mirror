From: Dima Kagan <dima.kagan@gmail.com>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 15:33:21 +0300
Message-ID: <4826E791.7030407@gmail.com>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dmitry Kagan <dima.kagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 14:34:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvAlH-0004N9-G7
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 14:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbYEKMd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 08:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754712AbYEKMd3
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 08:33:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:61135 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbYEKMd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 08:33:28 -0400
Received: by ug-out-1314.google.com with SMTP id h2so507176ugf.16
        for <git@vger.kernel.org>; Sun, 11 May 2008 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=3ql1rPClZ+T9LZ1SiHNToD3W6eepmQB2T2JbGiFSpyY=;
        b=JUl1eZuPHOnlGg0hMBp9hq/m7rJJmGvUj2NqypM3gtzKkzZx1P1hPFVSJrt35hSZB71mgYV745xjFwjWofhdbDXB9bFxYkMjN4hRcGwu+u52B9+z6qJwIKVXh3MzHDmIKy+nBxKFOp70Ehpgxjj0k2a9WC8d8NWzhWR/M/47HoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=isPc1R51p1HYPxMGQ8oo9o3rliMJmmJ78tnPwsXQWLrpTiE/Z2IjtoHb8hD7k8foR0KuKZiAY+TiAn63Dq9bQ8cK7hvLrrqIIi8t5oZ/Kmr0LpIaiAP3jfEv4fhdsx+u+UkxlXD9sJY5rKpVrMtQoJrYhpRCiLqEEfzBLLxpG+0=
Received: by 10.67.116.19 with SMTP id t19mr4040817ugm.47.1210509204762;
        Sun, 11 May 2008 05:33:24 -0700 (PDT)
Received: from ?192.168.1.60? ( [82.166.58.226])
        by mx.google.com with ESMTPS id u14sm12970620gvf.6.2008.05.11.05.33.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 05:33:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <m31w495apd.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81767>

>> Basically I see that the same file I edited on the 'test_branch'
>> branch appears to be modified on the 'master' branch as well. This
>> behavior is unwanted, of course.
>>
>> Can someone please tell me, what am doing wrong? Or is this git's
>> normal behavior?
> 

I just realized that this behavior is even more confusing.
If I commit the file on 'test_branch' and only then 'git checkout master' the changes are not visible on 'master' until I merge. So why should 'master' be affected by uncommitted changes on some branch???
