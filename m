From: Jon Smirl <jonsmirl@gmail.com>
Subject: cogito and tags propagation
Date: Sun, 12 Jun 2005 11:50:08 -0400
Message-ID: <9e4733910506120850f762078@mail.gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Jun 12 17:46:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhUfL-0004fV-KR
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 17:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVFLPuq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 11:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVFLPuq
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 11:50:46 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:62178 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262630AbVFLPuJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2005 11:50:09 -0400
Received: by wproxy.gmail.com with SMTP id 68so1325636wra
        for <git@vger.kernel.org>; Sun, 12 Jun 2005 08:50:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rFTdB2zk1tCWHiwb5GF7RvouoUZtMsoxis0mBjzkDy9SSvaQ3/7gVmL+gUUFpnKildYHHEVk/8BBPAfyahnoI+jvAcyePggtmQ6WlHwJAQWhQ9H5z1uAwYrjy8rRt6RB1F1CQnO72inDIPNT4Qg6bLKDfE3jUrvFiQWX3ZW6hYg=
Received: by 10.54.46.47 with SMTP id t47mr2254715wrt;
        Sun, 12 Jun 2005 08:50:08 -0700 (PDT)
Received: by 10.54.94.8 with HTTP; Sun, 12 Jun 2005 08:50:08 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If I add a tag to tree A,  then go to tree B which depends on A and do
cg update. It says the branch is already fully merged. It's not
counting the addition of a tag as something that marks the tree dirty.

-- 
Jon Smirl
jonsmirl@gmail.com
