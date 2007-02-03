From: Michael Coleman <tutufan@gmail.com>
Subject: [PATCH] fix use of sometimes uninitialized variable 'msg'
Date: Sat,  3 Feb 2007 10:49:22 -0600
Message-ID: <11705213633209-git-send-email-tutufan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 17:49:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDO4x-0004VT-Fi
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 17:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946494AbXBCQt2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 11:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946500AbXBCQt2
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 11:49:28 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:41295 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946494AbXBCQt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 11:49:28 -0500
Received: by py-out-1112.google.com with SMTP id a29so567120pyi
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 08:49:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=aSBx5X9GX6TU71U0DfXetrhelYdKiAZQHozWgkMLkvyPQZhNz/eU9o8SuGyDenFKllMUEuJ1NrosdZM61qI7ZzG6+0DjkcHcwQN68XoxPWvfaA2yAkPZkkqzXtlLm6toMgr0JjkkuaC/a28+hoCWDWX9EaMcWYV/AxL1H+P4H28=
Received: by 10.35.102.1 with SMTP id e1mr9485896pym.1170521367561;
        Sat, 03 Feb 2007 08:49:27 -0800 (PST)
Received: from tutufan@gmail.com ( [69.154.213.42])
        by mx.google.com with ESMTP id n67sm6602314pyh.2007.02.03.08.49.25;
        Sat, 03 Feb 2007 08:49:27 -0800 (PST)
Received: by tutufan@gmail.com (sSMTP sendmail emulation); Sat,  3 Feb 2007 10:49:23 -0600
X-Mailer: git-send-email 1.5.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38575>

