From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: deleting non-existent ref via push
Date: Fri, 23 Sep 2011 10:34:26 +0530
Message-ID: <CAMK1S_gksrR800yJHSnQWDNeDvD75+3Rp+qRWCuUrQyWmNDMsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 23 07:04:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6xwA-0005ct-BQ
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 07:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab1IWFE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 01:04:28 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45232 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1IWFE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 01:04:27 -0400
Received: by vws1 with SMTP id 1so3900660vws.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 22:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=i105aR4dOIoquqtSoJ0q4DGhcUpla5rpaEhqdOWsxq4=;
        b=vGwoNgXCf90+36GET4wvPhxmyN3Xqua8h/ZGB3GIwrduTBxg/Q/Nr+VWKeywoWgMmZ
         cbT5QvH8g7XBQzxBtywffcvFEtPrmMoUVzuVqPxf71TdF2LG+ZRDPIjTw84rySeqZmcO
         t7E9jOvqP19FYYRGxYNYZLTUq9hC68WhjRFAY=
Received: by 10.52.173.178 with SMTP id bl18mr2787689vdc.205.1316754267014;
 Thu, 22 Sep 2011 22:04:27 -0700 (PDT)
Received: by 10.52.161.197 with HTTP; Thu, 22 Sep 2011 22:04:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181942>

Hello,

Pushing to delete a non-existent ref (git push origin :refs/heads/foo)
works without error, except for a warning that the remote is "Allowing
deletion of corrupt ref".  By "works" I mean all hooks are also
executed.

Is this expected/supported behaviour?  Can I rely on it continuing to
work, especially in terms of executing hooks.

Seem like a great way to "poke" a remote repo into executing hooks
without having to make a dummy change and push :-)

-- 
Sitaram
