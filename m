From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: Git Fetch / updating HEAD
Date: Sat, 17 Jul 2010 21:02:47 +0530
Message-ID: <AANLkTinuK4gx9SG1VKo_NbkP_QWMCmtsfJgUgfoL_KGo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 17 17:33:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oa9Nz-0002OU-He
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 17:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084Ab0GQPcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jul 2010 11:32:52 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41874 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab0GQPcw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 11:32:52 -0400
Received: by gwj18 with SMTP id 18so1519113gwj.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=MqQm7y9uMbFgiDE+CTlcb57dpkwWfRA+BVWuCC7chM8=;
        b=I0xJmDTRlWALq808rwKgNRymiVuLUevQCaBBlq32rYCCKgRa0xMLCL1jaB9FdV3hPJ
         N0G8jhnYgagqMCnbKd2Y2So/ANphRq8nP5iAdM6q5wXZznSPDdcpL6kkt5xSvUOZhPv5
         xvybl6DbpAdUpghC8kBFoB1jkOO+UjVUUqRLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=eU2ABIdYjGKtP+/BBWCH4ZOdmR2wbt+ZSam5nSScX8SA2qESUo+k21b5gr9sXSkbJy
         VGUPN730VmZDiGryx3wA+z5RnFghNii1NhoimumJ3QrBbNBKlP8LA3fk5Qq9WEVIEs/v
         wRof9H4ve54uPmdM1ol3O+82G98wcEeEktaOs=
Received: by 10.90.49.7 with SMTP id w7mr1659317agw.184.1279380767176; Sat, 17 
	Jul 2010 08:32:47 -0700 (PDT)
Received: by 10.90.33.8 with HTTP; Sat, 17 Jul 2010 08:32:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151186>

Hi,

git fetch --all --append updates FETCH_HEAD. I'd like this command to
update HEAD as well; is there any flag ?

I have a reason to do it; trying to implement multisite

A (master) -> B (readonly mirror) -> C (workspace)

if sitting in B; git fetch does't update HEAD


Mahesh Vaidya
