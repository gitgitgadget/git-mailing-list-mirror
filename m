From: shawn wilson <ag4ve.us@gmail.com>
Subject: verify signature hook
Date: Mon, 29 Apr 2013 12:32:41 -0400
Message-ID: <CAH_OBieXyHuQBpG7Ge1wA4Q+MKBEy7MD-TpZmMLZjEF0jAzLwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 29 18:33:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWr0u-00059i-5T
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 18:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757672Ab3D2QdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 12:33:06 -0400
Received: from mail-vb0-f49.google.com ([209.85.212.49]:47790 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349Ab3D2QdC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 12:33:02 -0400
Received: by mail-vb0-f49.google.com with SMTP id 12so1953341vbf.22
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=Jt7oHC8+N6NZOajLCX1LHiziz3C+Sqe3prIyBBnC7zM=;
        b=rdBMyPMNNHzHYA6aZQ0Pbg3LVVdPbUcKLFQ7rqA8homLTupwS1RJVoPq8T1KFjNGky
         x/TogZwNKBbu4eCC3NyX0u+tpZyBtUFSSv/KVfw9rQ0OYFib9eHLilJ6PikPQmqQiGHW
         x5zIS9RR+ilXTCTmjdPrVWstGuJU4Psw2twpqfT+8r08hpKUBgdvszL+OTZXO16wxHZP
         dMJx/KlkDqESzqBDY6LdRt5XIR/sH166Y+VTNTdL+ZOSnCUQ96zt0oK0gSr3f4lD4HA8
         /m+xq7UPF1D2xn6ACesarBFZ7j+OFCDkdV7DC85/sIDdgeqexhee2ER8kM5kuQ8hHxIM
         9k+g==
X-Received: by 10.220.228.74 with SMTP id jd10mr33308426vcb.65.1367253181287;
 Mon, 29 Apr 2013 09:33:01 -0700 (PDT)
Received: by 10.52.103.14 with HTTP; Mon, 29 Apr 2013 09:32:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222809>

How do I complain when a commit/merge/tag/etc aren't signed? Ie,
everything should be signed and I'd like a hook that complains loudly
if something isn't signed (or if a signature isn't verifiable).

Also, how do I default to signing everything?
