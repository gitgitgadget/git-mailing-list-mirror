From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH 0/3] JGit in server side environment
Date: Thu, 16 Apr 2009 18:01:31 +0400
Message-ID: <85647ef50904160701p2d2b729aw7cb3c2f10ca2d17a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 16:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuSBH-0008Mk-E0
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 16:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbZDPOBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 10:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbZDPOBd
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 10:01:33 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:61446 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbZDPOBd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 10:01:33 -0400
Received: by fxm2 with SMTP id 2so434646fxm.37
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=YKbYMS2XK0nq6pQbAboeM+LQqoH9QN8A2nXqUBotu2c=;
        b=A/RAlL4rMiJdwLxd6QNqdDOONk+0pAP95eexWp59ej678rEa1e2uGzXBN0xuvtJi95
         OBokrs1E1ZiIf5uGg7Vk8f1+ipg71pbcxwESI19rZmPrynhP1jkKts4KC6VrB4oO0CJB
         AG7m9lmE1TqU9YT+JZY0pFV4+2rMTgNydZ1Ac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=qNYU9ENirTmImKM2aDyQ21X/UpDxd6l+l/Kc/DCmuxoGP5IsuKuCCAhyMbqHM+WuIV
         PJ3ZCZvxl4+LfJHXyvBKATm5YtBul54ceADGBvimKnHf6LMOj034KavcnUgx+f9QgHDX
         mgHSpy6DClbLJXlwzQYn+gR7oBHTBFDklf9Ro=
Received: by 10.204.118.70 with SMTP id u6mr1278526bkq.198.1239890491298; Thu, 
	16 Apr 2009 07:01:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116701>

I'm sending a series of the patches that make JGit more suitable for
usage in on the server-side environment, The patches do the following:
 * It is now possible to supply connection specific functionality for
SSH transports instead of using single global configuration
 * It is now easier to write a custom session factory that uses
~/.ssh/config for server-side environment

The patch consists from the following parts:
 * [JGIT PATCH 1/3] Changed Transport class hierarchy basing on
underlying transport
 * [JGIT PATCH 2/3] Moved common SSH related functionality to the base
class SshTransport
 * [JGIT PATCH 3/3] Extracted AWT-independent superclass from
DefaultSshSessionFactory

Constantine
