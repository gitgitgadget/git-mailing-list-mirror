From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: sub module branches
Date: Mon, 8 Mar 2010 16:44:55 +0530
Message-ID: <b42431c81003080314j694114b5o433988470f13328a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 08 12:15:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoavQ-0003cb-Fe
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 12:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111Ab0CHLO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 06:14:58 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64093 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100Ab0CHLO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 06:14:57 -0500
Received: by pwj8 with SMTP id 8so3665838pwj.19
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 03:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=qG8EaEHooSGu6Gh2vy0yTjLgtynN8JeAxC7Zov05oSk=;
        b=He3m4wFQTv4fulYwyJTRYCAjI4ne/kNnx6yX2MhLicwL8aRLLtN5flinraDa74SUaS
         VfSF995ECTE0fiosw2OLLB3hLSYIROHUur0TbdocNvw04qiAiMXTOBfTf4ewpIgIvB3M
         mJJ41wnERkltGOQGCYz87r//hXUVhnmN38wl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ZZK9602BP7RpQg120NbVhfgRedpxXuFPrlXIOoBoZc3Y92XXL+XD8t7wIWWnijg6uW
         HTH+ADltFXkalMcZznRqTiSmVdkHq7U0+Zr/3HfMTylWJdzccJPaXzcel5Yes1M5WDYo
         ZnSLeAvnuCFZClPTF9Grt0vW9f/++D4ggC18Q=
Received: by 10.142.67.29 with SMTP id p29mr3090402wfa.260.1268046895559; Mon, 
	08 Mar 2010 03:14:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141759>

Hi

I have a situation like

project/source.git
           /submod_1
           /submod_2

I need to modify code in all 3 repos viz. source, submod_1 & submod_2.

If I create branch in source, will it propogate to remaining
submodules ? or in other words can I have "global branch" and "global
tag"

Thx/

Mahesh.
