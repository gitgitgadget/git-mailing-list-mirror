From: Michael Wookey <michaelwookey@gmail.com>
Subject: creating a new branch without an ancestor
Date: Fri, 5 Feb 2010 14:19:12 +1100
Message-ID: <d2e97e801002041919r2043d05cjfb114a466605d9a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL2V-0003Bj-ON
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab0BEDTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 22:19:34 -0500
Received: from mail-pz0-f189.google.com ([209.85.222.189]:36906 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172Ab0BEDTd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 22:19:33 -0500
Received: by pzk27 with SMTP id 27so3626211pzk.33
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 19:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=vKj3zEITvgYbTM/pcfA0sdGbFPekGLtl2cEmpuMU1vM=;
        b=sXzDoa5UJ9d4HUBfHAtiYBwQ/5hr/9PpxYtKJIp/nn83sHsqROEkSFSbf+Yvu/T6JX
         AhyP9gfu9ZPw1O6nlpPQsKXH7ECbZZdWzDyBHO0r2ZB+skEkKuv1lm/OaZTy/7bbE2Pt
         N8+yaMtk4DAa0i2Sfy0eN9ti5MLkxqtvmO+84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=mbtiH3ovM0igzWxkSp3M6bNjs2YdZ/F/jDTQ/G1DxBQR8n5H2ML8nmTcEss5oW/7/e
         4dh1IqU/PA8iROOf6gRTH/rShxvq3QRGR68KUAFqh7aE3l1VOf8z9Bn/HBFk1/AGl/GI
         AzKxjD1VSRzFhJ8EuiA+MNJS92sNSr2NitmJ0=
Received: by 10.115.64.6 with SMTP id r6mr1347309wak.85.1265339972074; Thu, 04 
	Feb 2010 19:19:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139028>

Maybe I'm missing something from reading the docs, but I couldn't see
how to create a new branch in an existing repo that has no ancestor. I
would like to do something like what git.git does with some of the
other ancillary branches like "man", "html", and "todo".

I was hoping to do something like "git branch --no-ancestor
new-branch-name" but didn't see anything in the documentation that
describes the necessary branch options.

Or, am I looking in the wrong place?
