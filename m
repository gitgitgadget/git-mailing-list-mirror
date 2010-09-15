From: Jay Soffian <jaysoffian@gmail.com>
Subject: ls-files --exclude broken?
Date: Wed, 15 Sep 2010 18:40:20 -0400
Message-ID: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 16 00:41:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow0eu-0007lq-0p
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 00:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab0IOWkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 18:40:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47684 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0IOWku (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 18:40:50 -0400
Received: by iwn5 with SMTP id 5so464276iwn.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 15:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=LOoIOtFPc7hcEdyivM695r4k2x2+IkMxB3+RFasaxPQ=;
        b=jdV1sWqTeX4Q/3MDzd6IOcSy/G1qyFdbR1YU75MVBTpKrpMCLBuWJLuzcomRUmOGmF
         bDYwU4ElkmxN8ClTKhSqncM8C0AI/hbONit/yFaxpLy3/9a4VsqoSQpABUjZx4NAkYZn
         UUVFDJrj7IlRWQFxYvgoZCMcMQ+mOK53FBLH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=C/jrholg7bxYEBEX4n4oRZFpgwbr7iOsazWCxL3dVJU4E/JfUz4vwWdeT95umZbFt+
         /JnUHpiFKokOF9bQhyRkUse994c9hlU0CF5pAPOWYM7X6jmEPUMH4+LRqruNeMzED2DX
         mgGKeEK36+2XbFBXureBIdb0a7GvCJZLKkBdo=
Received: by 10.231.159.204 with SMTP id k12mr2424410ibx.42.1284590450253;
 Wed, 15 Sep 2010 15:40:50 -0700 (PDT)
Received: by 10.231.11.11 with HTTP; Wed, 15 Sep 2010 15:40:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156265>

Am I missing something really obvious here?

kore:~/Repos/git (master)$ git ls-files | wc -l
    2009
kore:~/Repos/git (master)$ git ls-files -x \* | wc -l
    2009
kore:~/Repos/git (master)$ git ls-files -i -x \* | wc -l
    2009
kore:~/Repos/git (master)$ git version
git version 1.7.3.rc1.5.g95127

j.
