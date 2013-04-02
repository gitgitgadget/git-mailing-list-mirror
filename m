From: Garrett Cooper <yaneurabeya@gmail.com>
Subject: [BUG] inconsistent behavior with --set-upstream vs --set-upstream-to
Date: Tue, 2 Apr 2013 10:07:01 -0700
Message-ID: <F58991CB-9C83-4DA6-B82B-2E6C874C30EB@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 19:07:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4gT-00020M-I2
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932854Ab3DBRHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:07:08 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:61569 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760972Ab3DBRHE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 13:07:04 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp14so404051pab.22
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 10:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:content-type:content-transfer-encoding:subject:date
         :message-id:to:mime-version:x-mailer;
        bh=3/3k+QT1Ny+OzZYyd0Bymw6ruXCWXGlfuRa57jsnTIQ=;
        b=U2iUhIyFhjiVJM1u7Fs1+YuewHrHA2oLkzRMVWJ3KDOvUaQvcCcLWYsyGEN3CH7ulD
         7ZWElPIgCY8fIqz2/hHEasUzH+AEloupb4WFY12a+7Rdg8GULpV8jNvgWmVxUFQSBeHA
         fRYwodlnlOyh4PlJeTTqX1hj9XoXj3zjWJ8d3a/j+404UFZPvJHmauRrojggA/O2GfBe
         W/lBSJUx61csp17zuBlDnRklGbX+7YPQYAhyXfE2kv0BhGjQvq5ibah63++Q2TMlUry8
         cvzy85U+w9MNRNXLpVlXwqZJ8CRTO6PBoI58OgvhCwGPMBc3YSH23RI092u3qYQ/+1Pu
         aVkQ==
X-Received: by 10.68.217.202 with SMTP id pa10mr25589494pbc.11.1364922423992;
        Tue, 02 Apr 2013 10:07:03 -0700 (PDT)
Received: from [192.168.20.11] (c-24-19-191-56.hsd1.wa.comcast.net. [24.19.191.56])
        by mx.google.com with ESMTPS id in5sm2418558pbc.20.2013.04.02.10.07.02
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 10:07:03 -0700 (PDT)
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219802>

Hi!
	It looks like git branch --set-upstream-to doesn't function with 1.8.1.3 until I run --set-upstream. Is this a known bug?

root@fuji-current:/usr/src # git branch --set-upstream-to origin/pjdfstest-onefs pjdfstest-onefs
fatal: Not a valid object name: 'origin/pjdfstest-onefs'.
root@fuji-current:/usr/src # git branch --set-upstream origin/pjdfstest-onefs pjdfstest-onefs
The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
Branch origin/pjdfstest-onefs set up to track local branch pjdfstest-onefs.
root@fuji-current:/usr/src # git branch --set-upstream-to origin/pjdfstest-onefs pjdfstest-onefs
Branch pjdfstest-onefs set up to track local branch origin/pjdfstest-onefs.
root@fuji-current:/usr/src # git --version
git version 1.8.1.3

Thanks!
-Garrett

PS Please CC me as I'm not subscribed to the list.