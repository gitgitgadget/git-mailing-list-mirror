From: "Murphy, John" <john.murphy@bankofamerica.com>
Subject: RE: [PATCH] Re: Gitk --all error when there are more than 797 refs in a repository
Date: Mon, 21 Sep 2009 10:11:51 -0400
Message-ID: <6F87406399731F489FBACE5C5FFA0458518E11@ex2k.bankofamerica.com>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
 <878wgcbb52.fsf@users.sourceforge.net> <19124.8378.975976.347711@cargo.ozlabs.ibm.com>
 <6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com> <4AB78910.7010402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 16:12:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpjcv-0008LI-6f
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 16:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756233AbZIUOMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 10:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756241AbZIUOMG
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 10:12:06 -0400
Received: from vamx06.bankofamerica.com ([171.159.192.13]:39072 "EHLO
	vadmzmailmx06.bankofamerica.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756233AbZIUOMC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2009 10:12:02 -0400
Received: from vadmzmailmx03.bankofamerica.com ([171.182.200.79])
	by vadmzmailmx06.bankofamerica.com (8.13.8/8.13.6) with ESMTP id n8LEBuUX017402;
	Mon, 21 Sep 2009 14:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bankofamerica.com;
	s=corp1; t=1253542316;
	bh=ftrJOMJK8i9sQ2bi3Zmbzx4UVK4oh3ql2bMQo7/BDU4=;
	h=Date:From:Subject:In-reply-to:To:Cc:Message-id:MIME-version:
	 Content-type:Content-transfer-encoding:References;
	b=tbMIjIMrv9q051ucDOgerULObFBQxxC5JeprV5v89aNXEnP+vQnK8tMYM/EIERB3W
	 WBZN+AOU6c9KaqnXWpj+WXEAQj4JrxZLa4LZFrocEsOV/4/AgK4+taPZMwDXAXpGcJ
	 ssvD0WPp1hq1ckiM1Rt3clxQb9ofc91cm3JRyUgk=
Received: from memva2mta02.bankofamerica.com (memva2mta02.bankofamerica.com [171.186.140.77])
	by vadmzmailmx03.bankofamerica.com (8.13.8/8.13.6) with ESMTP id n8LEBFbw018103;
	Mon, 21 Sep 2009 14:11:55 GMT
In-reply-to: <4AB78910.7010402@viscovery.net>
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
Thread-topic: [PATCH] Re: Gitk --all error when there are more than 797 refs in a repository
Thread-index: Aco6xSMRllXPvXwuS3S4q7INQ6lrqAAACOXg
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-OriginalArrivalTime: 21 Sep 2009 14:11:52.0108 (UTC) FILETIME=[777C3EC0:01CA3AC5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-09-21_09:2009-09-17,2009-09-21,2009-09-21 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128889>

Johannes Sixt writes:

> But in order to have a $revs that exceeds 32K, you would already have
to
> invoke gitk with a huge command line that exceeds the limit (but this
is
> not possible), no?

>How do you run gitk?

gitk --all
