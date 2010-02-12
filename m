From: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
Subject: Subtle git completion hacks with aliases
Date: Fri, 12 Feb 2010 14:40:41 +0100
Message-ID: <a1b6cb1b1002120540o8ff8f50vec1c7b528d462b8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 14:40:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfvlI-0007GT-VI
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 14:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab0BLNkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 08:40:43 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:40422 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab0BLNkn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 08:40:43 -0500
Received: by ewy28 with SMTP id 28so1322099ewy.28
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 05:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=LGLEAdQDMFtU7+cP0C8S/KzjTKZcFeAATiPm1+SG7fs=;
        b=TP92g+8rxRW0H/FQXb+jleplK2Y20GMGkB1/wuOTnsGuEtYqSiYnAQgU0Sv01fRKBL
         IWj7017ow3HpowYCczbSvGDj93/nD5phbJ9bx450Y9Tw1Xu/3C1M+cClilVad7scu68E
         4TmVSR7ulrjUgHq7RMbBQ0F2enoI/blxv8O3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=f+nXFxkWu70kg91DU50f67mfXcTlOAzQOJPx4sfNyhmy7yCWzdTEyrRgPV5ni87zn+
         DK7t5KU7KgBZFoSGF4cZfyPsY27SXgh9nOifFK3nGhr9kVK6MagECHsz5YcCzjJemv67
         stPLV9CR4Rh4iPPIuJjhx3zDp9jaNR5xRTS48=
Received: by 10.216.89.82 with SMTP id b60mr807608wef.170.1265982041421; Fri, 
	12 Feb 2010 05:40:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139710>

Relying on git refusing to use aliases that shadow git commands (and
rightly so), but the git completion script taking them at face value,
we can customize the completion of plumbing and custom scripts.

[alias]
        # Make this plumbing command autocomplete
        count-objects =
        # Make this custom shell script (git-unmerged)  autocomplete
arguments as branches, not paths
        unmerged = log

Given the firm beliefs in the aliases-shadowing-commands question, I
think the above should be pretty safe.

Ulrik
