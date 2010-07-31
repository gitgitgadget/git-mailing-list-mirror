From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH 0/2] Clean up add_refspec in builtin/push.c
Date: Sat, 31 Jul 2010 08:54:32 -0400
Message-ID: <cover.1280580026.git.jaredhance@gmail.com>
References: <201007300021.34061.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 14:54:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfBaX-00051i-Cu
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 14:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab0GaMyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 08:54:40 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55783 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab0GaMyj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 08:54:39 -0400
Received: by qyk7 with SMTP id 7so4437909qyk.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 05:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WHCM3ssh4T/f6bO8YacQJXgFXofXlVrBrTKq7DnWPvQ=;
        b=gTj3fQRGvWXWr7s15KreHHq1D6CjODXEfJGU23XImSlNbV17HrtrrgXX4k1PVJL/2o
         I+P3K9BW+XyUTCRXxu2Va6Fcw1KTSTEEXbw7KtUvrKcL5JEOmSeuZflbT8tISIqcvUCr
         y4mTcXhTkXyXQf3YsXS8/PR2lzBCe9snrbniY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TVonGLuryEFEBj5eByA7LTJFIfPwA979Vh8AVenuKdApJJ+fV7BANjm2khdspEYmfX
         41gyIq9AteBQnYLUQjSDEPV0+Lm5PY/uPRs0EA22vGbvzvlujoUlzxVWso/hdy9BsvfK
         yOGv5iEbeKGveJ/x9gJ9cr/+PTXDCG57b7/qw=
Received: by 10.220.169.14 with SMTP id w14mr2160659vcy.17.1280580878092;
        Sat, 31 Jul 2010 05:54:38 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id y25sm2531030vbw.16.2010.07.31.05.54.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 05:54:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201007300021.34061.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152322>

This patch series removes code duplication and other poor coding
practices from builtin/push.c.

Jared Hance (2):
  Remove useless temporary integer in builtin/push.c
  Use ALLOC_GROW in builtin/push.c

 builtin/push.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.7.2
