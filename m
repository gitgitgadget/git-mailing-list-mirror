From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH 0/2] Add -e/--exclude to git-clean.
Date: Tue, 20 Jul 2010 15:35:37 -0400
Message-ID: <cover.1279654370.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 21:36:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObIbg-0005rc-JK
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 21:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757892Ab0GTTfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 15:35:46 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64072 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757409Ab0GTTfo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 15:35:44 -0400
Received: by gxk23 with SMTP id 23so3083294gxk.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 12:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=9NBWkneaZEIiN43lAsovCA/PumVG1wl2uRtvLpUoDXY=;
        b=nE3/vretTcuilGMaF5iXXxaKAYtqgL2m/JyOGfIz0jAsyL2unFebyoBsyy0MkC9yhp
         U0qbCjLPVOv/EhFQMaEyBpTFtBZs5Sl6PRo+l3/8tGbxF5p9uaDYScOzut+crtNKaHPO
         tO28yHS5Cp8SCGnofc3o4tkfSROMG1X9FEG7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=nmgwocHUrAIBrDtgeYWUCMkDEeS7QB0P3ln7+4JNsYnN4gFQA8G136vxqJf9mF79WC
         FLwyR7mmLTMsO8jSTy2R+EGL2g6APvuP4QS2h5SWTP3n+WJdETLQGLtgrglsybimLcuT
         bkuTIfsj9Ss/AzG7K0VTPo1H4rtFPQ9wsmM4U=
Received: by 10.224.112.215 with SMTP id x23mr6086424qap.37.1279654543158;
        Tue, 20 Jul 2010 12:35:43 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id fb41sm28372749qcb.27.2010.07.20.12.35.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 12:35:42 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151354>

Changes:
    - Use -e multiple times instead of using a separator

I'm starting a new thread since the code change is rather major. I've
incorporated Julio's changes, touched up on them a bit, and updated
the test suite so that it uses multiple instances of -e rather than 
using a separator in them.

Thanks to Julio and all that helped.

Jared Hance (2):
  Add -e/--exclude to git-clean.
  Add test for git clean -e.

 Documentation/git-clean.txt |    8 +++++++-
 builtin/clean.c             |   17 ++++++++++++++++-
 t/t7300-clean.sh            |   16 ++++++++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)
