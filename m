From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] gitweb: Yet another cleanup series
Date: Tue, 22 Aug 2006 16:51:19 +0200
Message-ID: <200608221651.19629.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 22 17:00:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFXjH-0006mJ-Oc
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 16:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWHVO7f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 10:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWHVO7f
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 10:59:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:11134 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932287AbWHVO7e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 10:59:34 -0400
Received: by nf-out-0910.google.com with SMTP id o25so78030nfa
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 07:59:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aOL94LcrUvxafqfvZpR6B+dFnCNvOdFz6Lj3OON2lS0HNgfXRQAHLoSHecAdxrNzdrgXs/4LcT4u7Twp5bqy4B38n+FVJOcDyEEIm6miPPEWH+vVHkPilSZ0mbYh+IdMe5wCdz6MhGCVwvs55B0B2rl7v64EvPSBtfgMnnIo9hI=
Received: by 10.48.202.19 with SMTP id z19mr534461nff;
        Tue, 22 Aug 2006 07:59:32 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id o9sm639373nfa.2006.08.22.07.59.32;
        Tue, 22 Aug 2006 07:59:32 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25857>

This series of patches commences further gitweb cleanup.
It is based on earlier series of patches:
* gitweb: Added parse_difftree_raw_line function for later use
* gitweb: Use parse_difftree_raw_line in git_difftree_body

---
 gitweb/gitweb.perl |  277 +++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 188 insertions(+), 89 deletions(-)

* gitweb: Whitespace cleanup: realign, reindent
* gitweb: Use underscore instead of hyphen to separate words
  in HTTP headers names
* gitweb: Route rest of action subroutines through %actions

-- 
Jakub Narebski
Poland
