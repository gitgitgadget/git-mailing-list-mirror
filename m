From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: how do I exclude a commit from set of commits to be pushed.
Date: Sat, 3 Jul 2010 21:05:43 +0530
Message-ID: <AANLkTiko8joz_a94QwHwdDwlsjXslu8LdWAnJuvShFFI@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 03 17:36:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV4l4-0006XG-8G
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 17:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab0GCPfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 11:35:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39480 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab0GCPfo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 11:35:44 -0400
Received: by gye5 with SMTP id 5so801532gye.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=AH99fF5rL8KgBTQthJsZ/QcVsPSuMGstG7SGMarSdDE=;
        b=eYm0jTiz3JmgYkY4UvB5AHTC68GQeSdxSuppE/ny2SF4sOds6WHrnpgiBmSUEYyKb7
         wRXCdqGpqLbtkal6ye/d2ABXa8Zuily/15VTKrQ3npBQOXNoV1rA/lGHSos+6Nfc3xbY
         hdaURWAumvBKy2UPQCAVvTKhTLTshhc858dlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=CNbPCrSGgb1BYS0IIBbkQtHwgLBQaAponx83c/I/ljl9UoBLWyQSW4/3sVxwSt1hTO
         rn9GfOcjm7olOQMN3vLxqJ8AujVJj000hXvu4NycCr4W3hV2DXtQ1SZT5xVBeBpB5ESN
         GbV5ugDef5L4VXMIdCOMTJYQbD8pI+t1MK6js=
Received: by 10.90.71.17 with SMTP id t17mr831557aga.144.1278171343192; Sat, 
	03 Jul 2010 08:35:43 -0700 (PDT)
Received: by 10.90.100.4 with HTTP; Sat, 3 Jul 2010 08:35:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150192>

In the series of commits C1..C8 how do I exclude a commit to be pushed.

use case -
I have commits say C1..C8 to be pushed. Due to my pre-receive hook
commit C4 is complying with commit standard. I have amended C4 to C5 ;
still C4 shows up in commits to be pushed list.

git reflog delete --rewrite and git gc --prune did not help

Thx/ Mahesh
--
