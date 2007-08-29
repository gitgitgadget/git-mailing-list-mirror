From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
Subject: New to git, related multi-projects
Date: Wed, 29 Aug 2007 14:18:14 -0400
Message-ID: <7F6E024B-253E-40C6-9012-9CF1B2F374D8@yahoo.ca>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 20:18:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQS7W-0003uS-3X
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 20:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbXH2SSU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 14:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbXH2SSU
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 14:18:20 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:48239 "HELO
	smtp110.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752057AbXH2SSU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Aug 2007 14:18:20 -0400
Received: (qmail 81808 invoked from network); 29 Aug 2007 18:18:19 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:Mime-Version:Content-Type:Message-Id:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=vu0W3YfY0/BC9+WH/WhEXUH18YQwZOJHF6RcX1V3oG5icETz2lZMZTMBhJTTr+Rnh2zNuQGEzIPcoooFPvlv2JoT6VV9WMkTx97FNE+5RePAEfgW6zst4oQFPrpv7ai8fwG2O9QT9Z6vilgswt1zJsZliEqWvBCNT9Nl5gyCJyA=  ;
Received: from unknown (HELO ?192.168.3.33?) (jean_francois_veillette@207.96.147.134 with plain)
  by smtp110.mail.mud.yahoo.com with SMTP; 29 Aug 2007 18:18:18 -0000
X-YMail-OSG: exmnqNAVM1mzFBp3ZJnAw2OwxBAAIR3pAodI5JdixJh7GUNpjEja5RpU7yoVZo5kU6eXLJJM9Q--
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56970>

Here is my setup, please briefly tell me what would be the suggested  
git configuration.

The company currently use cvs, it has a cvs tree where the first  
directory level is per client, the second directory level is the  
project, then inside it we have the many artifacts, like :
cvsserver/Shared/Documentation/PresentationTemplate.doc
cvsserver/Shared/Documentation/AnalysisTemplate.doc
cvsserver/Shared/Devel/CommonLib/*
cvsserver/ClientA/ProjectA/Doc/Presentation.doc
cvsserver/ClientA/ProjectA/Doc/Analysis.doc
cvsserver/ClientA/ProjectA/Dev/ApplicationA/*
cvsserver/ClientA/ProjectA/Dev/ApplicationB/*
cvsserver/ClientA/ProjectA/Dev/ApplicationC/*
cvsserver/ClientA/ProjectA/Dev/LibraryA/*
cvsserver/ClientA/ProjectA/Dev/LibraryB/*

What would be the best way to represent a similar setup in git ?
I was thinking of having a repository at the project level, and add  
atomic  subdirectories (code for applications and libraries for  
example)  as submodules.
If submodule are the right way to go, can a submodule, include a  
submodule, for example, ApplicationA use LibraryA and CommonLib ?

Thanks,

- jfv
