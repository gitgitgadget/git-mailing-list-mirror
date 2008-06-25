From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: Re: how to list all files that will be comitted
Date: Wed, 25 Jun 2008 12:01:49 -0400
Message-ID: <17C0F998-66C0-4DFC-90EB-B85FF6E07844@gmail.com>
References: <644094BE-2835-41EF-B1B4-615B8A4BD509@gmail.com> <alpine.LFD.1.10.0806251154180.5755@sys-0.hiltweb.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ian Hilt <Ian.Hilt@gmx.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 18:03:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBXSU-0007DK-7V
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 18:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759657AbYFYQBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 12:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758679AbYFYQBy
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 12:01:54 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:23180 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759657AbYFYQBx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 12:01:53 -0400
Received: by rv-out-0506.google.com with SMTP id k40so8259648rvb.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=gmYbxXZXHpOAXddlFtU0fFroItUIzn7oZW8pnrRh/n8=;
        b=bi6o2d1PLcn72qO3h2H/T7fVdPNR+9BLPxWCnW0+PtB4oh10uQclIckxc6dTXqms/E
         6qfZHaDC7c61xtX0Sb1Sf+m2eB/h9RGFKq+F7CNlpsQxSzQNYCGrSZaYnkfDFhFInP2u
         RZjdrh6WqcGSe2BlsISH4VgvkxFdoByaVGyNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=xSsEXKTJZvnHzfZ3MznoN9JqdkZng50pK6renG/sbdVIYhC0W9jhglyL1pz5/ROlJZ
         i9/IJbNgeFzLO/RtPMOYU0qDjhs6262d5REUXY1KYM1TErAY00gQlNNSbQWDpOGCoDZF
         MlBrIsbKikCidtHkKvOVaNK0mQyH/vS8tmz3Q=
Received: by 10.141.49.18 with SMTP id b18mr6376349rvk.92.1214409713169;
        Wed, 25 Jun 2008 09:01:53 -0700 (PDT)
Received: from ?172.30.0.244? ( [80.67.64.10])
        by mx.google.com with ESMTPS id 43sm14514283wri.27.2008.06.25.09.01.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 09:01:52 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806251154180.5755@sys-0.hiltweb.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86293>

yeah, but i was hoping for plumbing, not porcelain, that showed just  
what i wanted so that i didn't have to parse status' output.

-Kate

On Jun 25, 2008, at 11:57 AM, Ian Hilt wrote:

> Have you tried "git status" ?  It will output something similar to the
> following:
