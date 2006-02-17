From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: stGIT: commit vs export vs mail
Date: Fri, 17 Feb 2006 13:09:48 -0800 (Pacific Standard Time)
Message-ID: <Pine.WNT.4.63.0602171139020.3052@jbrandeb-desk.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Fri Feb 17 22:09:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FACrR-0006H6-Gh
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 22:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWBQVJv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 16:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWBQVJv
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 16:09:51 -0500
Received: from fmr17.intel.com ([134.134.136.16]:63186 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751794AbWBQVJu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 16:09:50 -0500
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr002.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k1HL9nT9011824
	for <git@vger.kernel.org>; Fri, 17 Feb 2006 21:09:49 GMT
Received: from nwlxmail01.jf.intel.com (nwlxmail01.jf.intel.com [10.7.171.40])
	by orsfmr101.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id k1HL9nbQ001510
	for <git@vger.kernel.org>; Fri, 17 Feb 2006 21:09:49 GMT
Received: from jbrandeb-desk.amr.corp.intel.com (jbrandeb-desk.amr.corp.intel.com [134.134.3.102])
	by nwlxmail01.jf.intel.com (8.12.10/8.12.9/MailSET/Hub) with ESMTP id k1HL9nAN011251
	for <git@vger.kernel.org>; Fri, 17 Feb 2006 13:09:49 -0800
To: git@vger.kernel.org
ReplyTo: "Jesse Brandeburg" <jesse.brandeburg@intel.com>
X-X-Sender: jbrandeb@orsmsx408.amr.corp.intel.com
X-Scanned-By: MIMEDefang 2.52 on 10.7.209.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16366>

So I am using stgit .8 right now, and I'm having a hard time figuring out 
what the correct workflow should be for using stg and then committing a 
change

Here is what I've been doing:
stg new test
  enter my short description on first line
  enter my long description on next lines.
vi file
stg refresh
stg mail <blah blah blah>
or
stg commit

Problem that I'm having right now is that the templates do the right thing 
for mail, but, the commit only puts in the "enter my..." text.

Is there a template based way to automatically append the author in the 
Signed-off-by: line when i do stg commit?

I realize that I could put Signed-off-by in the log by hand (or even in 
.git/patchdescr.tmpl which i just found) but it would be cool if the 
commit just had something like patchmail.tmpl (maybe call it 
commitdescr.tmpl or something?)

thanks for any opinions or instruction.

Jesse
