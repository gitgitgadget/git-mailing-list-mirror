From: Tim Visher <tim.visher@gmail.com>
Subject: `./configure --XXdir=` ignored?
Date: Thu, 26 Feb 2009 09:48:29 -0500
Message-ID: <c115fd3c0902260648g3cc9bfeap58823e53a9dc72e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 15:50:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LchYw-0002kq-3G
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 15:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbZBZOse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 09:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbZBZOsd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 09:48:33 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:37406 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbZBZOsc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 09:48:32 -0500
Received: by yw-out-2324.google.com with SMTP id 5so438383ywh.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 06:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=LJT4t5ivbk6B9qYH5i9SxyWMPb1LYV27oAtA22TL82s=;
        b=UnQsK5zrw/LyCYvtJXY4HOgIMeLO4cEry05wqS8GlAc8Ocn/HSSf/MpQAhDURRrVnE
         q5+XAT1EZ7oSnBo+0HZB9StBf+lUyA0FPnq6l/FI4vKeyWatQlQfJmptfORKCXDfTp3t
         bAdy59x7yKSEH4Z6fpO7S1tr7Mj/jkY/2nn8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=viP0289o3B8w9ip4i6cFnWeV3narxpzi9U5wlmcJojNHoua4RZYNkFDasTuX3M2Ft/
         xKVdt1CJFclIctsfocijWPkPx7ZPBijKBzIoJxLRbfNZ75iTBsIxtG8OjD8gU8u5Ij+U
         Kqvw1G4BQcEN6tURYkfVqCE5yFYAe231N1VtQ=
Received: by 10.100.11.14 with SMTP id 14mr1527980ank.89.1235659709971; Thu, 
	26 Feb 2009 06:48:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111566>

Hello Everyone,

I'm working on getting git 1.6.2-rc2 built.  I have a bin, man, info,
and html directory in my home folder that I'd like to use as the
defaults for git.  I attempted to do this through

    make configure
    ./configure --XXdir=/full/path/to/dir
    make all man info html
    make install install-man install-info install-html

But other than the binaries (and I'm not even totally convinced they
got in correctly) and the man pages, everything else seems to be
attempting to go to the typical places in /usr/local.

What am I doing wrong?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
