From: =?iso-8859-1?Q?PICCA_Fr=E9d=E9ric-Emmanuel?= 
	<frederic-emmanuel.picca@synchrotron-soleil.fr>
Subject: =?iso-8859-1?Q?RE=A0=3A_RE=A0=3A_trailling_whitespace_with_git_am_=3F?=
Date: Fri, 14 Aug 2009 22:46:43 +0200
Message-ID: <606CC410B038E34CB97646A32D0EC0BF0181FABE@venusbis.synchrotron-soleil.fr>
References: <606CC410B038E34CB97646A32D0EC0BF0181FAB4@venusbis.synchrotron-soleil.fr> <81b0412b0908141310x7e4acf4fgf4ea71cf53de6eea@mail.gmail.com> <606CC410B038E34CB97646A32D0EC0BF0181FABD@venusbis.synchrotron-soleil.fr> <7vab22i1dl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Alex Riesen" <raa.lkml@gmail.com>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:47:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc3fy-00071b-PI
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 22:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbZHNUqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 16:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbZHNUqy
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 16:46:54 -0400
Received: from dns.synchrotron-soleil.fr ([195.221.0.3]:34561 "EHLO
	sucette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752242AbZHNUqx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 16:46:53 -0400
Received: from localhost (unknown [127.0.0.1])
	by sucette.synchrotron-soleil.fr (Postfix) with ESMTP id 2F6F93D760;
	Fri, 14 Aug 2009 20:46:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from sucette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (sucette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jQg4HKGqjoYo; Fri, 14 Aug 2009 22:46:48 +0200 (CEST)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by sucette.synchrotron-soleil.fr (Postfix) with ESMTP id E25843D75E;
	Fri, 14 Aug 2009 22:46:48 +0200 (CEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: =?iso-8859-1?Q?RE=A0=3A_trailling_whitespace_with_git_am_=3F?=
Thread-Index: AcodHi2FokFrxd6pRYaGoP1/9T4uJAAALZgt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125951>

> how can I do the difference between a patch with normal CR+LF (the autor use this format)
> and a patch without CR+LF due to the webmail ?

> That is a question to your webmail provider but I think you generally
> can't.  Use dos2unix as Alex suggested and you should be fine.

git am --whitespace=fix was sufficient to apply the patch
