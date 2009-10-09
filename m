From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/9] Documentation tweaks
Date: Fri, 9 Oct 2009 05:14:00 -0500
Message-ID: <20091009101400.GA16549@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:14:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwCUo-0002is-W1
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbZJIKG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754678AbZJIKG3
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:06:29 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:56948 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbZJIKG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 06:06:28 -0400
Received: by ywh6 with SMTP id 6so6097627ywh.4
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 03:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=NVTSP3UPtEn6OIJCkiGk1aHVLDtf2o1gfjUjoVD/r0M=;
        b=YazDxPe3mo8QtS4OmS+zHN+MmjUZmvTpMA+if8sKFx9jxp/WNGnS7STuzKU8i6aFvT
         nHJ+WYCwBlCXpCLHCN7YA2DJfh9kgU5+GErYJ/Yau4SigHYmvOD5pxVxqhEsThF9SZjZ
         sqU+ET2EU12q5ZV4pSIcb9hZ6FX8RLRNA4JYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=TNhnfqfOVLRyHv40Ihmao81ovQpWV2PBflVqUjpB0eOcLvhjdYCW56zrDw2j4qHMqa
         lZx5PaEuvFf3ARRssZi1Allvtob2Juf4oq+/ZMIEEWrSFIvTmzY1AbOlgHItIPxT3c7j
         taLKO9COnM0YpYl5tnKOjNjSW0/TPpV56a6M4=
Received: by 10.150.88.8 with SMTP id l8mr865702ybb.38.1255082751774;
        Fri, 09 Oct 2009 03:05:51 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm445752gxk.2.2009.10.09.03.05.50
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 03:05:50 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129757>

Hi gitsters,

Here are some small documentation patches that have been sitting in
my tree for a while.  Most important is the first one, which makes it
easier to find the appropriate options for building documentation
from source on a new machine.

Perhaps they could be of some use.  I look forward to your thoughts.

Jonathan Nieder (9):
  Describe DOCBOOK_XSL_172, ASCIIDOC_NO_ROFF options in Makefile
  Documentation: git fmt-merge-message is not a script
  Documentation: fix singular/plural mismatch
  Documentation: say "the same" instead of "equal"
  Documentation: clone: clarify discussion of initial branch
  Documentation: branch: update --merged description
  Documentation: clarify branch creation
  Documentation: clarify "working tree" definition
  racy-git.txt: explain nsec problem in more detail

 Documentation/config.txt             |    2 +-
 Documentation/git-branch.txt         |   27 ++++++++++++++++-----------
 Documentation/git-clone.txt          |    3 ++-
 Documentation/git-fmt-merge-msg.txt  |    2 +-
 Documentation/git-merge.txt          |   11 ++++++-----
 Documentation/glossary-content.txt   |    6 +++---
 Documentation/technical/racy-git.txt |   10 ++++++----
 Makefile                             |    6 +++++-
 8 files changed, 40 insertions(+), 27 deletions(-)
