From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Stange diff in "mailinfo: re-fix MIME multipart boundary parsing"
Date: Tue, 19 Aug 2008 18:38:28 +0100
Message-ID: <e5bfff550808191038u645cf4baldca5c2c4bbd02162@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git mailing list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 19:39:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVVB9-0004po-2g
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 19:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbYHSRia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 13:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbYHSRia
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 13:38:30 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:29076 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbYHSRia (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 13:38:30 -0400
Received: by yx-out-2324.google.com with SMTP id 8so20201yxm.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=HnFV07aFp+zKxRj2cKSgW3FFLJdXrDup9lPJD8WXjsI=;
        b=gXo5iOr8PXCsu66dkzhJ1XuELyrN9NePWVPBRZwmuOHGT7eElf4vP2gyG8M9+KBO+l
         nly9T3DmWp4ARkV8GXu+c32lSVzvdmf7L87xRfdWVztqsG59wYcuHSWE4zxQPVTUKQWR
         O/iceG96lgkPFrAdKbtvahm9w09hM1Xk8bTUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=QzE8z1c/2awI5BVxGNH6o857yqx8KSdO/oYuoMiUvNTATvtH3+UP1tdnGUGFUSKlsM
         bDgX3S2o0e0TBvtWI0P5n1lyFvfgxkJjErOdYEMxlj3eqORKGCh20ueZc5GYb/zjJfEo
         mlh82QVfN9AgzINcdLVeCMDbaIaSq+TL4kfCk=
Received: by 10.115.59.2 with SMTP id m2mr6929778wak.197.1219167508602;
        Tue, 19 Aug 2008 10:38:28 -0700 (PDT)
Received: by 10.114.174.5 with HTTP; Tue, 19 Aug 2008 10:38:28 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92885>

Looking the diff at

http://git.kernel.org/?p=git/git.git;a=commitdiff;h=289796dd29dd656734cfd59b657deb943a71cf6a

the part of the patch applied to /t/t5100/sample.mbox file seems very
strange, is it correct ?

Marco
