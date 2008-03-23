From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: List all SHA1 hashes in repo
Date: Sun, 23 Mar 2008 16:17:29 +0300
Message-ID: <c6c947f60803230617if9606baxea21fa99dc3df37c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 14:18:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQ5T-0001qy-Uo
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 14:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759138AbYCWNRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 09:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758840AbYCWNRa
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 09:17:30 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:14545 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758769AbYCWNR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 09:17:29 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2488195wff.4
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=R2AF5pTy/MADzCbp4ZA5uzkTAa3CT79gybH6IejS0dA=;
        b=c/71z9eVr/gtxmTAnLel5Hnc4xiMxl52N7SbyHijnbTM7luV7FQ1DLOwLiBHyzgAXy9ArdokbBxiQjpRClGyG1+H+Qk5TiRUYtvtRfpfj4BWwbq5aPcATTNvw5J2WWlhyV0ccuJuj6jKWjnP/LPQizo4Ow9hoR+0VLcTmuYHLsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Yrk/6cgoAnwVkUgnNXfSFp9qLRlevBbcTzm1mQoOSFUA0Ro6eJpiLxGvBDs5CVK3yPxOWcWBZkrr83/hxRag8T8zk4SAUgby1h4fEGmiwIG78ECDJxe5/r7+x0cCFYheWcnKyFpKMrSQfRvTqRvpFtIrc1dkApgEiXNBbqwaIU8=
Received: by 10.114.190.6 with SMTP id n6mr9660436waf.51.1206278249124;
        Sun, 23 Mar 2008 06:17:29 -0700 (PDT)
Received: by 10.115.111.4 with HTTP; Sun, 23 Mar 2008 06:17:29 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77889>

Hi, list!

To help testing little Git-related tool I'm writing, I need a lot of
pregenerated SHA1 hashes. Git repo seems to be a perfect source of
such. Is there an easy way to extract a list of all (well, most of)
SHA1 hashes in the repo?

The git rev-list --all gives nice list, but, as I understand, that is
only commit objects, and there are much more of SHA1 hidden inside.

Thanks in advance,
Alexander.
