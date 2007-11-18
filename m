From: "Henrik Vendelbo" <hvendelbo.dev@googlemail.com>
Subject: only accessing some git repos: Am I configuring daemon wrong?
Date: Sun, 18 Nov 2007 13:18:04 +0000
Message-ID: <9732aadb0711180518n26c2681aqe7f0a823012c6fe3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 14:18:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itk2d-0006pi-B3
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 14:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbXKRNSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 08:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbXKRNSI
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 08:18:08 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:26945 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbXKRNSH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 08:18:07 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1545455mue
        for <git@vger.kernel.org>; Sun, 18 Nov 2007 05:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=O0xq7jcrII+Pc+4MhgwhEwYwCl77VNkh77scf/1dW2Q=;
        b=uFmo5FN/lyWnMwyWnt7F/BO8u3hXaORPsZBFi37PRFaQZR92Nd9obYy63aqlGHu4PKb2BGOw1TUT7kL4lSFobCs+wJ0jnlMD+lPnSgjFGJ8qqnm7r6tkB3HCNT0UyzpQE88oSkDY1/pLq0M4JRgUg61Ad/dtYmA057H9wHlWgcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OvnoWdKr/Mr5uDTpI7b940ZjGFc92iNsGrb1976gClxv4ps8Ixy/PAs7sxxfcmKVq0yxcR4j/3GcgMb5qTrdgA7uAuM9ciAMzBu6VI9CcMRfx+l4P0yFJGrrVKY80jkRtps/CvAJ2HBOUZzc9BpQOnqpbdDT7kY4QGdLffSwWHY=
Received: by 10.64.3.9 with SMTP id 9mr6211804qbc.1195391884448;
        Sun, 18 Nov 2007 05:18:04 -0800 (PST)
Received: by 10.64.150.13 with HTTP; Sun, 18 Nov 2007 05:18:04 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65370>

I run the daemon against a base directory with all my repos.

/repositories
  + /blingon
     + /config
  + /thepia
     + /config

The config directories are git repositories, and the repos are made
available with the following command:

henrik-computer:~ x$ git daemon --export-all --verbose --base-path=/repositories
[337] Connection from 192.168.9.130:56583
[337] Extended attributes (20 bytes) exist <host=192.168.9.165>
[337] Request upload-pack for '/blingon/all'
[337] Disconnected

For some reason when I try to pull over the git protocol to a
different machine using clone, I get a failure telling me that there
is 'no matching remote head'

I tried specifying the actual repo directories, but that made no difference.

Any ideas?

Henrik
