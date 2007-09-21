From: "Peter Stahlir" <peter.stahlir@googlemail.com>
Subject: Git as a filesystem
Date: Fri, 21 Sep 2007 12:51:30 +0200
Message-ID: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 12:51:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYg6j-00016d-Ks
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 12:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972AbXIUKvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 06:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755893AbXIUKvd
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 06:51:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:13130 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807AbXIUKvc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 06:51:32 -0400
Received: by nf-out-0910.google.com with SMTP id g13so745688nfb
        for <git@vger.kernel.org>; Fri, 21 Sep 2007 03:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=m0EOU+Yl08d04gmSdMzmYmxndvSpSnbNRqZ3vjo2dDU=;
        b=uUzV1euISYIFnlE99qrXnDqqSz5EaXo//+2qqhXJVM2Af0+Gf3zrEsmHoUmFWnUjY13jBb0CLxja1thbWtlIzK68wglDEL5UaTMnSEPAhqhA7O3Syh4dbGv7fl28fO7qqsSOIFncsRItL/q0AF3Vds2dBn8QuV8d9IxPPmZQk7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TcOOI/pw59cZaqcj48KJRnSNEY/bK2Ea+YydjF5XrvI/HmulLaLeKhoSzgWOv1X8bNghYwnMBqRtO+eG+jUAz2+XMAn2IRUmrECXBE3XQXx4dHODVTzLvMiZc5SybwrC3JJ5+Pmz9+gPO42gDWg9hF5VaxPc+v3jCG8GDvYocGI=
Received: by 10.78.150.7 with SMTP id x7mr1106193hud.1190371890935;
        Fri, 21 Sep 2007 03:51:30 -0700 (PDT)
Received: by 10.78.140.12 with HTTP; Fri, 21 Sep 2007 03:51:30 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58842>

Hi!

Is it possible/feasible to use git as a filesystem?
Like having git on top of ext3.

This way I could do a gitfs-gc and there is only one
pack file sitting on the disk which is a compressed
version of the whole system.
I am not interested in a version controlled filesystem,
only in the space saving aspects.

Thanks,

Peter
