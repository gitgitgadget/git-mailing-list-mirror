From: Marc Singer <elf@buici.com>
Subject: cogito clone, invalid cross-dev links
Date: Mon, 11 Jul 2005 13:44:45 -0700
Message-ID: <20050711204445.GA16191@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 12 01:54:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds862-000833-44
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 01:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVGKUss (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 16:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVGKUqq
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 16:46:46 -0400
Received: from florence.buici.com ([206.124.142.26]:18326 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262662AbVGKUoq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 16:44:46 -0400
Received: (qmail 16203 invoked by uid 1000); 11 Jul 2005 20:44:45 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It complained when I cloned across devices.  

  `/git/cogito/.git/refs/tags/cogito-0.8' -> `.git/refs/tags/cogito-0.8'
  cp: cannot create link `.git/refs/tags/cogito-0.8': Invalid cross-device link
  `/git/cogito/.git/refs/tags/cogito-0.9' -> `.git/refs/tags/cogito-0.9'
  cp: cannot create link `.git/refs/tags/cogito-0.9': Invalid cross-device link

and so on.  Is this a problem?
