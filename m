From: Mattia Tomasoni <Mattia.Tomasoni.8371@student.uu.se>
Subject: certificate problem for *.github.com
Date: Thu, 04 Nov 2010 16:21:35 +0100
Message-ID: <20101104162135.47chayboagwwkcc8@webmail.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 16:31:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE1mH-0005vA-IF
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 16:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab0KDPa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 11:30:57 -0400
Received: from lyra.its.uu.se ([130.238.7.73]:39028 "EHLO lyra.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316Ab0KDPa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 11:30:56 -0400
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2010 11:30:55 EDT
X-Virus-Scanned: amavisd-new at uu.se
X-DKIM: Sendmail DKIM Filter v2.8.3 lyra.its.uu.se D6F2939684
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=uu.se; s=centralsmtp;
	t=1288884099; i=@uu.se;
	bh=wOLtaTQoRVzz/6Jro0TVaL6vhB7G565vfILB6o3fR2w=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=TyJ3B6Jk2Ivsv4dgPBARVHwL68CN3SgdbGB0kHyKzlhvplhN0jub7yvzwFlcpZgU6
	 akS+UhRKcp/79CP0qvL7ILxdghw75qL9HOu1lcsbE77ieBIE+78gaJK9sRRFcN79/0
	 +Jp5IMoQWYJ5j577KfkSf4aAiQdV+m+ONoLjkAJg=
Received: from rufa.its.uu.se (rufa.its.uu.se [130.238.4.225])
	by lyra.its.uu.se (Postfix) with ESMTP id D6F2939684
	for <git@vger.kernel.org>; Thu,  4 Nov 2010 16:21:38 +0100 (CET)
Received: from jubula (localhost [127.0.0.1])
	by rufa.its.uu.se (Postfix) with ESMTP id CDCBD1BEE5
	for <git@vger.kernel.org>; Thu,  4 Nov 2010 16:21:35 +0100 (CET)
Received: from dirac.dbb.su.se (dirac.dbb.su.se [130.237.190.37]) by
	webmail.uu.se (Horde MIME library) with HTTP; Thu, 04 Nov 2010 16:21:35
	+0100
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160727>

Hello Git community!
Here is my question: until a few days ago I used to be able to point  
to a certain file in my git repository with the following url:
http://github.com/percolator/percolator/raw/xml-1-1/src/xml/percolator_in.xsd
Now this gets redirected to an https address.
No problem opening it with the browser; but I do get an error with,  
for instance, wget (...and, more important, with a program that  
attempts to use that file as a schema against which some xml code is  
validated...)
I get:
certificate common name `*.github.com' doesn't match requested host  
name `github.com'

wget --no-check-certificate works...

Thank you!
Mattia
