From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: git-clean and empty pathspec
Date: Fri, 7 Dec 2007 01:21:10 +0700
Message-ID: <fcaeb9bf0712061021o5383f538h3a086a913ac1b05d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 19:22:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0LML-0001AY-3a
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 19:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbXLFSVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 13:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbXLFSVN
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 13:21:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:15886 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbXLFSVM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 13:21:12 -0500
Received: by nf-out-0910.google.com with SMTP id g13so145072nfb
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 10:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=PCX0QBtfxQ18l/mErIYjMy0/gvo4tL9sJsgXV8YiBlM=;
        b=TyNLQSqwM2WSu1BtCcYkARMw44PHYjpX/RpgoTx4IR1O5nHgqi8/k37Ppd23t3VZDORRLSUnPyXz9ZWYD88ahnUb5X+pkWojLJBU5PGIFjyRBww7cFGkM7+74/JTtSeQ9hJJayZ/74U8Ic98mAT4tT9/izSV46FnPStti0qaQF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=A06yxdwzz7+P+/MV9MtxgCFPSweL3AXbQ3lX47hJnBeFCC6BTjHSxiQTaAuyX1SKwhZ/ZJTFpuh3Gz1IJ7kKXzwv1kwA7uN45QYkHT4wLQngMn3BwTTJ5EG+iz3k99je4kScsrEY180oiM8cmvL8PuWMXqpE7gyX843iOW+bU7c=
Received: by 10.86.84.5 with SMTP id h5mr1284188fgb.1196965270322;
        Thu, 06 Dec 2007 10:21:10 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Thu, 6 Dec 2007 10:21:10 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67311>

"git clean -n" would not remove directories while "git clean -n -- ''"
(two single quotes) would. Is there anything wrong with it?
-- 
Duy
