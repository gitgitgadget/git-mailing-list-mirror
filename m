From: Tomasz Kontusz <roverorna@gmail.com>
Subject: Continue git clone after interruption
Date: Mon, 17 Aug 2009 13:42:22 +0200
Message-ID: <1250509342.2885.13.camel@cf-48>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 13:43:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md0cJ-0005Bv-Is
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 13:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757851AbZHQLma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 07:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757850AbZHQLma
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 07:42:30 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:48597 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757825AbZHQLm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 07:42:29 -0400
Received: by qyk34 with SMTP id 34so2106123qyk.33
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 04:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=fD1UvMlwym/ZBdWjYpf0+YXgO3ROFhWvqZVVuJsPrkM=;
        b=Aol+gBjrwYeSk8M8Olu1PGEYX0X+x20s31EFQgP4ByU8PIaPp/eF5wQAJbXFWBsvtg
         D/gCccDAcBrpG4RkCJ0929nnGnMMgL64u8XrJuvlW2imRKU2/XfduppTjbozl1Sj8cmN
         eLPz3wbWAwvDSOpP2WaxWNhAWOtIk9jxRtuIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ADZfAPobxuyGoQFJruLhzK1ODZoJuILaLXfjcJm3TG9gaD7cMMOPfzePpDRh4fQQ6n
         v0fPSF+t3GnGIS/al6Y07PXP/y5wszsS9tN27uJCI4XCWAlGrYxw/6QEMnItPK1lzMIZ
         Jq9wvsc+4hhvhl8GIS+1vMg1J84MHHPWnQJvA=
Received: by 10.224.54.206 with SMTP id r14mr4035990qag.204.1250509348223;
        Mon, 17 Aug 2009 04:42:28 -0700 (PDT)
Received: from ?192.168.11.117? (pub-177-87.czarnet.pl [77.252.177.87])
        by mx.google.com with ESMTPS id 6sm6261945qwd.58.2009.08.17.04.42.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 04:42:27 -0700 (PDT)
X-Mailer: Evolution 2.26.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126159>

Hi,
is anybody working on making it possible to continue git clone after
interruption? It would be quite useful for people with bad internet
connection (I was downloading a big repo lately, and it was a bit
frustrating to start it over every time git stopped at ~90%).

Tomasz Kontusz
