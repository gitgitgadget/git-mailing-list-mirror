From: <Patrick.Higgins@cexp.com>
Subject: RE: [PATCH v3/RFC] Remove the use of '--' in merge program invocation
Date: Tue, 17 Jun 2008 10:52:21 -0600
Message-ID: <911589C97062424796D53B625CEC0025E46165@USCOBRMFA-SE-70.northamerica.cexp.com>
References: <7vlk157woq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>, <tytso@mit.edu>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 18:54:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8eQq-0003EK-CG
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 18:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213AbYFQQwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 12:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754030AbYFQQwY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 12:52:24 -0400
Received: from mx02.cexp.com ([170.131.136.83]:11353 "EHLO mx02.cexp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138AbYFQQwY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2008 12:52:24 -0400
Received: from uscobrmfa-se-05 (uscobrmfa-se-05.cexp.com [170.131.144.36])
	by mx02.cexp.com (Postfix) with ESMTP id 10AC4220F37
	for <git@vger.kernel.org>; Tue, 17 Jun 2008 10:52:23 -0600 (MDT)
Received: from USCOBRMFA-SE-70.northamerica.cexp.com ([10.128.26.36]) by USCOBRMFA-SE-52.northamerica.cexp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Jun 2008 10:52:22 -0600
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <7vlk157woq.fsf@gitster.siamese.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3/RFC] Remove the use of '--' in merge program invocation
Thread-Index: AcjQDeN3+mfgXNn0RVmPqryQ6K/O9gAjIl6w
X-OriginalArrivalTime: 17 Jun 2008 16:52:22.0699 (UTC) FILETIME=[83550FB0:01C8D09A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85314>



From: Junio C Hamano [mailto:gitster@pobox.com]
> 
> Patrick Higgins <patrick.higgins@cexp.com> writes:
> 
> > My only concern is if 'git ls-files -u' ever returns absolute paths,
> > then this will not work.
> 
> What do you mean by "absolute paths"?  The path git proper 
> deals with is
> always relative to the root of the repository's work tree, so 
> you won't be
> seeing "/home/patrick/src/Makefile" from ls-files if that is 
> what you are
> worried about.

Yes, that's what I was worried about. Glad to hear that won't ever happen.
