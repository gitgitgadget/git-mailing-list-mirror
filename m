From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/4] autoconf: Some improvements
Date: Tue, 8 Aug 2006 18:34:08 +0200
Message-ID: <200608081834.09271.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 08 18:34:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAUWu-0002KY-VA
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 18:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWHHQeD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 12:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWHHQeD
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 12:34:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:64362 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030188AbWHHQeB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 12:34:01 -0400
Received: by nf-out-0910.google.com with SMTP id q29so223587nfc
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 09:34:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=n/9VF/dT9xG2zRzLod6x+1efij29Hh8++sHgnbukHL3gEI/xY3hTI5XEvqvLQgp1poJunrbzB0E56xTn22NyPW7K3ebGwCPSrav6Q0h1/rg4ul2jt5PFT9yUDV4F3kakqtGgqm+bercqopWtUy+BjlwRktlTv6TqcdoJd/Acaj4=
Received: by 10.49.29.3 with SMTP id g3mr721198nfj;
        Tue, 08 Aug 2006 09:34:00 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id i1sm978271nfe.2006.08.08.09.33.59;
        Tue, 08 Aug 2006 09:33:59 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25072>

This series of patches, based on next branch 
  (commit id: 45c5baf2f082dd5f537f043f7637bff87db515e8)
introduces few minor improvements, and one (last) larger,
following 
  "autoconf: Unset NO_STH and NEED_STH when it is detected not needed"

 * [PATCH 1/4] autoconf: Add configure target to main Makefile
 * [PATCH 2/4] autoconf: Error out on --without-shell and --without-perl
 * [PATCH 3/4] autoconf: Improvements in NO_PYTHON/PYTHON_PATH handling
 * [PATCH 4/4] autoconf: Move variables which we always set 
   to config.mak.in

-- 
Jakub Narebski
Poland
