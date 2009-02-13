From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: GitExtensions 1.43 crash with large repository
Date: Fri, 13 Feb 2009 10:02:04 -0600
Message-ID: <63BEA5E623E09F4D92233FB12A9F794302E0F326@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 17:03:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY0Vt-00076f-F3
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 17:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756983AbZBMQCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 11:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756706AbZBMQCJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 11:02:09 -0500
Received: from emailmn.mqsoftware.com ([66.192.70.108]:38942 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756692AbZBMQCI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Feb 2009 11:02:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: GitExtensions 1.43 crash with large repository
Thread-Index: AcmN9Gm60lNGl55AQNybGJPc7xZXEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109756>

Just tried to use GitExtensions on a fairly large (500mb after gc
--aggressive) repo, and it dies.  If this isn't the best place for this
report, let me know.

So, the repo loads OK but when I scroll down past what it's prefetched,
it crashes with the error below.

Error text after launching the CLR debugger:
An unhandled exception of type 'System.ArgumentOutOfRangeException'
occurred in mscorlib.dll

Additional information: Index was out of range. Must be non-negative and
less than the size of the collection.



--

Kelly F. Hickel
Senior Product Architect
MQSoftware, Inc.
952-345-8677 Office
952-345-8721 Fax
kfh@mqsoftware.com
www.mqsoftware.com
Certified IBM SOA Specialty
Your Full Service Provider for IBM WebSphere
Learn more at www.mqsoftware.com 
