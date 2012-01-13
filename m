From: "Dmitry A. Ashkadov" <dmitry.ashkadov@gmail.com>
Subject: fetch for bare repository
Date: Fri, 13 Jan 2012 14:42:03 +0400
Message-ID: <4F100A7B.3030001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 11:42:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RleaK-00078K-1T
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 11:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757702Ab2AMKmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 05:42:08 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:42736 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab2AMKmF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 05:42:05 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm14so247621wib.19
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 02:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=ICTsxnPAh6FCsqGWcOVN7IhRMEIAuV0nHCA/P5Q0V14=;
        b=rmqQ1pHyCUvv5bYUuHVlK0Pjf5+YdFS92ITpaGcuyzT0ryFnPRnySzsK8+5khrfWh5
         4KnCZPPUwEm8uu6Ka1mlSKmKFKq/bngL2V6yQ+npYhdCfLCLdRvw61ybtorqCsQhUCJC
         s5456zw7EmVBYI6o4AkhSugkVkoTWv6qU/1hw=
Received: by 10.180.19.42 with SMTP id b10mr7676715wie.13.1326451325137;
        Fri, 13 Jan 2012 02:42:05 -0800 (PST)
Received: from work.galanthus.dyndns.info (95-28-45-120.broadband.corbina.ru. [95.28.45.120])
        by mx.google.com with ESMTPS id fg15sm10543274wbb.7.2012.01.13.02.42.04
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Jan 2012 02:42:04 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111220 Thunderbird/9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188509>

Hello!

I can't understand how to fetch branches from external repository for 
bare repository.

For example, imagine 2 git repositories: "B" and "C". "B" repository is 
external repository and it contains branch "branch1". "C" is an internal 
repository (special repository for some people). "C" repository may be 
created with command:
> $ git clone --bare B .
For "C" repository working set isn't required, so it may be bare, I 
think. This new "C" repository contains branch "branch1".
Imagine that somebody has created a new branch "branch2" in the 
repository "B". I don't know what I should do with repository "C" to 
make the branch "branch2" available on repository "C". Command:
> $ git fetch origin 
doesn't work. Next command for repository "C":
> $ git branch -a 
always shows only branch "branch1"  but never branch "branch2".

Could you help me, please?

Thank you!
