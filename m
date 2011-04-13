From: Jon Seymour <jon.seymour@gmail.com>
Subject: is hosting a read-mostly git repo on a distributed file system practical?
Date: Wed, 13 Apr 2011 11:40:06 +1000
Message-ID: <BANLkTiniGcRAHbt5LP2NVhE+c8grOr5sLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 13 03:40:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9p44-0008GQ-7N
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 03:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776Ab1DMBkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 21:40:08 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59292 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932755Ab1DMBkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 21:40:07 -0400
Received: by iyb14 with SMTP id 14so145859iyb.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 18:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=G/h06X/aRvFMyfOIitzeg9Jw+WJcuD0yG9z8txnQzEM=;
        b=sEKW4EI71Y8+ajfGhP0oIBHKuJtejb2RRyw+NI2i+NTmZKVOAyPZUjP71IBF3CSwwW
         CPytZ1lPAbjjbwj8y8OyFyDLiKM1AmXtkEb5NUyydpJnqydpQ8xGRCYrZenKol1OEW6o
         Fw9htF1PkyLttWLmNr36t1iV9hfmer5ZsBmtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=EOKS9RUZawDjv8NEyTvOV2qA18d7mxf+nlCsHaSiBBJ2j3M/n0lMPBbrAmviztuCrW
         Y/WO8bkaQ/LlNQ8vIlhp8E0KCOjBHmHGALZWC9w4HNUNonLYuuNvzF0buNPZ8ar8XJJ/
         BwzGa+/hc2d3OLh0LPzfjcVMLRhmnV7XBVFfk=
Received: by 10.42.117.134 with SMTP id t6mr3180476icq.459.1302658806428; Tue,
 12 Apr 2011 18:40:06 -0700 (PDT)
Received: by 10.42.218.68 with HTTP; Tue, 12 Apr 2011 18:40:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171428>

Is it practical to host a read-mostly git repo on a WAN-based
distributed file system?

The idea is that most developers would use the DFS-based repo to track
the tip of the development stream, but only the integrator would
publish updates to the DFS-based repo.

As such, the need to repack the DFS-based repo will be somewhat, but
not completely, reduced.

Is this going to be practical, or are whole of repo operations
eventually going to kill me because of latency and bandwidth issues
associated with use of the DFS?

Are there things I can do with the git configuration (such as limiting
repacking behaviour) that will help?

jon.
