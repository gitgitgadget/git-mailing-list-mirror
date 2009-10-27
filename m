From: Lachlan Deck <lachlan.deck@gmail.com>
Subject: git svn branch tracking + ignore paths
Date: Wed, 28 Oct 2009 10:00:54 +1100
Message-ID: <41F0F1D6-4F99-4828-9259-1B2BDC689747@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 00:01:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2v2P-0002JT-3A
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 00:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938AbZJ0XA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 19:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754798AbZJ0XA4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 19:00:56 -0400
Received: from mail-qy0-f174.google.com ([209.85.221.174]:42571 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784AbZJ0XA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 19:00:56 -0400
Received: by qyk4 with SMTP id 4so147475qyk.33
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 16:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=7ZPdAPTTbJMxb45J7UChTNyLic9ZdekemYeKgJktS9Q=;
        b=M1nkj1wIK3YKAfHa12y4IJ5TU8H8rc4hKQFkhPkBLRLOqKi4kN2R0csscdSz/gANiX
         hkd+Txf7+H8zue2Yunc0o49l/IyFDXASWJYIozDsbHFqu+mgoSVU0gYkwidGmWhIdCNg
         ei16+qLXQImdcsVx9IuB/vXowYVj2Bw7XBsgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=PQ73O5dzQZJoUWvDk0Go2pdDBop0uiKs9SasXGd3v+hONPdifzovE8lWe+x6ghQfQl
         uBS2uPyLT7ZvANQBBF4MF5yhHxIypDgSIr9D7JrmfEtv4+k4tL1hwUsYkkKOGkTFJLOK
         Dyt3hEjAh43XimhOucf+6ZYkrcqpHMfKI6Qw0=
Received: by 10.224.122.3 with SMTP id j3mr8829169qar.335.1256684460710;
        Tue, 27 Oct 2009 16:01:00 -0700 (PDT)
Received: from ip-144.ish.com.au (ip-144.ish.com.au [203.29.62.144])
        by mx.google.com with ESMTPS id 20sm199473qyk.13.2009.10.27.16.00.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Oct 2009 16:01:00 -0700 (PDT)
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131386>

Hi there,

(Note: relative newby)

I'm wondering if it's possible to create a branch (starting as local  
but later on pushed to svn) that essentially stays in sync with the  
main branch (svn trunk) but both (a) ignores pulling in certain paths  
from trunk and (b) provides a few extra paths of its own (some of  
which overlap with those ignored from trunk) and (c) only pushes to  
trunk paths that are relevant for trunk (i.e., not specifically  
ignored)?

If someone's able to share how they'd go about setting this up that'd  
be great.

Thanks!

with regards,
--

Lachlan Deck
