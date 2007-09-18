From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Latest builtin-commit series
Date: Tue, 18 Sep 2007 11:12:01 -0400
Message-ID: <1190128321.23692.12.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 17:24:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXevw-0002Um-QF
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 17:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482AbXIRPYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 11:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757017AbXIRPYL
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 11:24:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755966AbXIRPYL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 11:24:11 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8IFC8H7004430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Sep 2007 11:12:08 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8IFC7L3029491;
	Tue, 18 Sep 2007 11:12:07 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8IFC7f0027571;
	Tue, 18 Sep 2007 11:12:07 -0400
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58619>

Hi,

I sent out a new builtin-commit patch series last night, and figured I
should have written a cover letter to describe the changes there.
Better late than never:

      * rebase to Pierres strbuf changes.  Note, there is still some
        strbuf tweaking required, to let stripspace work on a strbuf.
        Also, I changed the semantics of stripspace to always add a
        newline if the last line doesn't have one.  I believe the
        current odd semantics (always remove the last newline) comes
        from not being able to easily add a newline, but now that it's a
        strbuf, that's easy.
