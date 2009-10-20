From: Joe Perches <joe@perches.com>
Subject: git-send-email.perl defect: address missing trailing > accepted
Date: Tue, 20 Oct 2009 15:12:47 -0700
Message-ID: <1256076767.2029.59.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 00:12:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Mwn-0003N3-Us
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 00:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbZJTWMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 18:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbZJTWMn
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 18:12:43 -0400
Received: from mail.perches.com ([173.55.12.10]:2284 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbZJTWMn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 18:12:43 -0400
Received: from [192.168.1.151] (Joe-Laptop.home [192.168.1.151])
	by mail.perches.com (Postfix) with ESMTP id B518524368
	for <git@vger.kernel.org>; Tue, 20 Oct 2009 15:12:44 -0700 (PDT)
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130857>

I typo cut/pasted an invalid email address,
neglecting to copy the trailing ">".

was:	"Name <addr.org"
needed:	"Name <addr.org>"

Anyone have suggestions on how to get
git-send-email.perl to notify and abort
sending on more invalid address styles?
