From: Andy Parkins <andyparkins@gmail.com>
Subject: git-gui blame dividing by zero
Date: Wed, 4 Apr 2007 16:21:49 +0100
Message-ID: <200704041621.51390.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 17:22:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ7JW-0002z7-T4
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 17:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992922AbXDDPWA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 11:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992923AbXDDPWA
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 11:22:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:39658 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992922AbXDDPV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 11:21:58 -0400
Received: by ug-out-1314.google.com with SMTP id 44so700676uga
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 08:21:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rtGl5lqOM81pw8SyR4apM+/tRbsRxok42grCf2jdnL4s8SoaLIzPj0Ic24HmoaojfsL4Sa8eGRlve/ovfWFHoqDWXkSookBfcdT3crT/I7gsFnYtD8Kh43kCXK5FoTzprC0cX6ibqOV6laQK9+a3zsJ5jrXRkHyA/6qrHM1qnf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hRdwmaJ/d0TSC8R2YW/91yDvsUSqq82ya5tHdZ+jr6DTSUbiUtgn2anqNbJWZQSfrj10KfSPYBjyfKUUe6920bZoj6YQWFw12N6JaIx7RSXlBSY2rhZN/xY0Brq00ueCQs8vn7ZVTM7ThC3UX9TH3cxtBEFj5tqoF6aeh5MUZNo=
Received: by 10.66.218.15 with SMTP id q15mr1498424ugg.1175700115379;
        Wed, 04 Apr 2007 08:21:55 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm1463223ika.2007.04.04.08.21.54;
        Wed, 04 Apr 2007 08:21:54 -0700 (PDT)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43746>

Hello,

I've not used it before, but I thought I'd give it a go:

 $ git --version
 git version 1.5.1
 $ $ git-gui --version
 git-gui version 0.6.5
 $ git-gui blame HEAD somefile.cc

I just get a window that contains:

divide by zero
divide by zero
    while executing
"expr {100 * $blame_data($w,blame_lines)
			/ $blame_data($w,total_lines)}"
    (procedure "blame_incremental_status" line 4)
    invoked from within
"blame_incremental_status $w"
    (procedure "read_blame_catfile" line 27)
    invoked from within
"read_blame_catfile file6 {} HEAD 
somefile.cc .cm.t .out.loaded_t .out.linenumber_t .out.file_t"

Am I doing something wrong?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
