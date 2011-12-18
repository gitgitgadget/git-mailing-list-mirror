From: "Ryan O'Hara" <minitech.me@gmail.com>
Subject: BUG: Git command causes crash
Date: Sat, 17 Dec 2011 19:13:53 -0800
Message-ID: <CAOgd6zFr5LorTK6X5o6NQE3L61KhaUZG9tX4LEB4_Na_YKPPpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 18 04:14:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rc7Cu-0005zp-E7
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 04:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab1LRDOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 22:14:16 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59106 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab1LRDOO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 22:14:14 -0500
Received: by vbbfc26 with SMTP id fc26so3342511vbb.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 19:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=5CCMqtQJtNMPGatTs61l2P0ZfeGsJjYVaeYKvUj+Pmo=;
        b=nrQTNlgFMshTWFWSKDl1/O2knuN6QUdCrSKoTeo2897t/bkyJc0wSSxYT+GXaMF0JM
         fyGx8XDl9IxSjKp5B6wKL1zi9ScvsY5m2AbsHGEqOeDSxpIQe/u3npZm9x/IFiClF/Hz
         DRjPF0WZ8PpG8/LxjEnPI2iRupObbKDud0uxU=
Received: by 10.52.173.176 with SMTP id bl16mr9114137vdc.47.1324178054168;
 Sat, 17 Dec 2011 19:14:14 -0800 (PST)
Received: by 10.220.0.85 with HTTP; Sat, 17 Dec 2011 19:13:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187410>

On Git for Windows (MinGW), at least, this command causes git to crash:

git commit -a --no-message --dry-run
