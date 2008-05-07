From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: Sort of a feature proposal
Date: Wed, 7 May 2008 21:50:12 +0400
Message-ID: <37fcd2780805071050n5153f5d2rf31a0f263820e92@mail.gmail.com>
References: <86fxsutbke.fsf@lola.quinscape.zz>
	 <alpine.LFD.1.10.0805070924300.3024@woody.linux-foundation.org>
	 <86k5i6rp23.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed May 07 19:51:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtnnO-0005Hz-B1
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 19:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056AbYEGRuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 13:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753772AbYEGRuP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 13:50:15 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:12781 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbYEGRuM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 13:50:12 -0400
Received: by wf-out-1314.google.com with SMTP id 27so361466wfd.4
        for <git@vger.kernel.org>; Wed, 07 May 2008 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=O6/i/cNxBP7z4PIhPOo7mh6n3328y2OTNqTuaXBMQPU=;
        b=Rm3MwuSaurRV4nFT1agJZ5Vg0HC/ZJ9mF6KO7EAomCzL2j7KEXh/47KClndP0AgqvzWJ+evvPrN7sWyPraCmNbsAe7G0G1biVebwK3mtpR6tp0rneHNSR3hOvkNNiMNAfiZXYVYxiYaQ5rTgYcr0DdSA4hBG7ZB6QhB5ThUyrxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lgH0AIyzz1IH6Kclmihx5UBOqlhpVaKB5DjJyeFx0/iiJ7x+nBoBOSCoYGghBmlbOnglJmK3YlxVfGltVbmLzsbZ832c+w209H6XVLvo4galQOmSG2SBJyra+A+sxRtVx2gRFTDa4RbS04yORLcrjlv6pfCjNDU56Bi2+u/Fn0o=
Received: by 10.142.52.9 with SMTP id z9mr977377wfz.237.1210182612136;
        Wed, 07 May 2008 10:50:12 -0700 (PDT)
Received: by 10.142.81.18 with HTTP; Wed, 7 May 2008 10:50:12 -0700 (PDT)
In-Reply-To: <86k5i6rp23.fsf@lola.quinscape.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81469>

>  Is there a way to completely invalidate the disk cache without
>  unmounting?

echo 3 > /proc/sys/vm/drop_caches

Dmitry
