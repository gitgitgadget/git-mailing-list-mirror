From: dhruva <dhruvakm@gmail.com>
Subject: git-p4: Importing multiple p4 prods into same git repo
Date: Tue, 4 Nov 2008 14:12:59 +0530
Message-ID: <e3f230850811040042m5f07994btf70680c4fdac13cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 09:44:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxHWP-0000wG-Cw
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 09:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbYKDInE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 03:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753853AbYKDInD
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 03:43:03 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:14985 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796AbYKDInB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 03:43:01 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1620649tic.23
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 00:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=rYL0muyYUJdRssihz8Iyfo3N10Ca1extr4SDNkPsTMo=;
        b=R8tyCZ6NXBu+FlF8FnE7HQWYA4+YB6O4tfHyliaPFgsHLXXSRxHBhFRXSQ9cOZTbFf
         SWo1En3QFidYearTOYeLb1Gkhwaa/yeb4D5KoEo8Tb0WIYtUTqSeSSN9CmEu/k+UoXm/
         OzQBC0nsRlYPt1+GriLd5IPrR02x4lEvCpdSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=rasrB2zfL283/T3G17vDhaPvwzzAk2dVaP0vBIk/nNG4I7piumXW/DCJCCz0J2C66P
         K5BOs6AXZW55Fpz4I5IBSaLf2YaDdXR0KzGeVPwDvIIotRl5DoAs0tKhmXXpq66mox9X
         Zb38+/emwO9XuTtXxw7MFkB6c2R10311mkuK8=
Received: by 10.110.16.9 with SMTP id 9mr907793tip.54.1225788179255;
        Tue, 04 Nov 2008 00:42:59 -0800 (PST)
Received: by 10.110.93.2 with HTTP; Tue, 4 Nov 2008 00:42:59 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100059>

Hi,
 I have the p4 layout as follows:
1. //depot/prod/devel/main
2. //depot/prod/devel/hacks

where #2 is a sort of fork of #1. There are lot of common objects
between them and #2 can trace its history to #1. I would like to
import both the above paths under the same git repository as 2 remote
branches so that they can share objects and reduce overall size. Is
this possible using 'git-p4'. I went through the code and got lost in
the complexities...
 I urgently need this to consolidate multiple paths under the same git
folder and be able to serve them soon. Any help is greatly
appreciated.

-dhruva

-- 
Contents reflect my personal views only!
