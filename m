From: "Dana How" <danahow@gmail.com>
Subject: [PATCH 00/13] limit pack size in git-{repack,pack-objects}
Date: Thu, 5 Apr 2007 15:21:36 -0700
Message-ID: <56b7f5510704051521v4df5706aw97d7a00f61323d33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:21:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZaKr-0002kO-2P
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767211AbXDEWVi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767215AbXDEWVi
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:21:38 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:9437 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767211AbXDEWVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:21:37 -0400
Received: by nz-out-0506.google.com with SMTP id s1so401362nze
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 15:21:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cH6SjuYrh9RT6yrqLT9D16FcDMXfjbuKO8wlLOLSRWziDLIy2Zwq495Z7ZszMjC6Wsu6g4T7jP0dOmr4ben3LY7b+1/s0J908lFnYoi+Mzh6RRWug/gGAHzkcQAoZcKtiCQ6Tmft4L4Qi+KYMRroArMNpQU953c5cpDa42r8FkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=G8diK12bxvajmMAFLjAMXZ1v25XRcEcbcYu6CyrV8FMeV5qZwPHdeV8Gy77xkgyzcH+wrVvI5aCy5Mo9iygrKZFOKYuEKspC4vudUzblJusT3hPVD2dxWqsV0npYn09YMH1Dg3Wz225UG9AjsMpXxyYclIa5jhdBJu9jiscIrqw=
Received: by 10.114.168.1 with SMTP id q1mr926400wae.1175811696098;
        Thu, 05 Apr 2007 15:21:36 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 15:21:36 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43863>

The following patchset is similar to the one I sent previously,
but it is now in smaller more numerous chunks.
Since no one rose to defend the --pack-limit/--stdout combination,
I have removed any code to support it.  I don't need it myself.

Unfortunately gmail makes me include the patches as attachments.

Enjoy,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
