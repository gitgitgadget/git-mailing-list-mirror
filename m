From: Craig de Stigter <craig.destigter@koordinates.com>
Subject: git-svn fails with non-alphanumeric SVN authors
Date: Thu, 25 Feb 2010 09:47:40 +1300
Message-ID: <e260aad41002241247r180d5477kd18f5cbee8109634@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 21:47:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkO94-0000hm-H1
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 21:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758050Ab0BXUrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 15:47:42 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47704 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758041Ab0BXUrl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 15:47:41 -0500
Received: by pvb32 with SMTP id 32so1021552pvb.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 12:47:41 -0800 (PST)
Received: by 10.142.248.4 with SMTP id v4mr176825wfh.258.1267044460572; Wed, 
	24 Feb 2010 12:47:40 -0800 (PST)
X-Google-Sender-Auth: 8a50de7723a404d9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140987>

Hi list

I'm trying to use git-svn to move our subversion to git. Some of the
authors in our SVN repository are x.509 identifiers, so my authors
file has some entries like this:
   /C=NZ/ST=New Zealand/L=Auckland/O=Koordinates
Ltd/OU=IS/CN=cdestigter = Craig de Stigter
<craig.destigter@koordinates.com>

git-svn doesn't like that - it fails saying:
   Author: /C=NZ/ST=New Zealand/L=Auckland/O=Koordinates
Ltd/OU=IS/CN=cdestigter not defined in ./authors.txt file

I presume it is choking on either the spaces or the '=' characters in
the SVN username?

Comments / workarounds / fixes welcome... I'm avoiding messing with
git-svn myself since I have no perl knowledge at all.

Thanks for any help
Craig de Stigter

--
Koordinates Ltd
PO Box 1604, Shortland St, Auckland, New Zealand
Phone +64-9-966 0433 Fax +64-9-969 0045
Web http://www.koordinates.com
