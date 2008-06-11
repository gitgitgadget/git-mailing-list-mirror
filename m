From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Porcelain/Plumbing
Date: Wed, 11 Jun 2008 21:50:24 +0200
Message-ID: <bd6139dc0806111250y53cfbdbdj9f00e38bf6e1c912@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 21:51:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6WLo-0006qD-7R
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 21:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbYFKTu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 15:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbYFKTuZ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 15:50:25 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:3622 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbYFKTuY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 15:50:24 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3246141wfd.4
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 12:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=oHzgOD2ZU1pIH5kVvLdaTPE/xQHsxuWL4QIYYfftEjs=;
        b=Z+h84ZB4NUC7OvqNmH+4qZisRkiSxLOWP6zGI7a9M+qjWpO5aSFb3j1nroV2Y1nmT+
         xWXCmetViETAD6mrti8C1uAytuzbA3I8AcK/yWkfr0bsUXhwlTqpQ8P66etASvjpTcT5
         LDnFWvgDtfW8Q/XU/L/ARmTZtBPX276UkGX8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition;
        b=fnNHE5KW+Ei+WON3sQyCMmRCyAji1XustIdhiCMzrzsjWhUz+98K3uk0o1oUlHHEI5
         xgC+E/HwfuYDqFufwqtCJ/yoEpnlnwGl/CVpVMJPiOaLkUbqEk1CTIYcTXv7pterj8TP
         WlW2i1Dzt5f/PombUM+LYsWLtnrkk+EoEKCjU=
Received: by 10.142.126.17 with SMTP id y17mr96253wfc.300.1213213824314;
        Wed, 11 Jun 2008 12:50:24 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Wed, 11 Jun 2008 12:50:24 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84647>

Heya,

During my efforts gsoc efforts, I stumbled across (or actually, was
pointed at) 'git branch --contains' to list only branches that contain
a specific commit. The problem here is that 'git branch' is listed as
porcelain, and that there seems to be no plumbing equivalent of this
feature. I have the same problem with 'git log -S', although 'git log'
is pretty sturdy output wise (if you specify the output with
'--pretty=format:' that is), the idea is the same.
My question is, is it intentional that there is no plumbing equivalent
forsome functionality, and, in such cases, is it 'ok' to use the
porcelain from a script? (I think it is not.) I've been recommended to
stick with the plumbing as much as possible from my code, but with the
above two cases I've been unsure on what to do.
What is the advised course of action here?

-- 
Cheers,

Sverre Rabbelier
