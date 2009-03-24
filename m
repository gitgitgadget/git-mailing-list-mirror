From: David Howells <dhowells@redhat.com>
Subject: Re: GIT BUG? GIT occasionally redownloads its entire data set
Date: Tue, 24 Mar 2009 09:15:29 +0000
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
Message-ID: <32484.1237886129@redhat.com>
References: <37fcd2780903231953pdfaa679r8a680f64ee692c8d@mail.gmail.com> <28707.1237855543@redhat.com> <7vskl34qc9.fsf@gitster.siamese.dyndns.org>
Cc: dhowells@redhat.com, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 10:17:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm2kx-00028J-BH
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 10:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758521AbZCXJPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 05:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758520AbZCXJPn
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 05:15:43 -0400
Received: from mx2.redhat.com ([66.187.237.31]:37242 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758510AbZCXJPm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 05:15:42 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n2O9FZxf016256;
	Tue, 24 Mar 2009 05:15:35 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n2O9FRl5009558;
	Tue, 24 Mar 2009 05:15:27 -0400
Received: from warthog.cambridge.redhat.com (kibblesnbits.boston.devel.redhat.com [10.16.60.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n2O9FU28022412;
	Tue, 24 Mar 2009 05:15:31 -0400
Received: from [127.0.0.1] (helo=redhat.com)
	by warthog.cambridge.redhat.com with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Lm2jJ-0008Rx-RW; Tue, 24 Mar 2009 09:15:29 +0000
In-Reply-To: <37fcd2780903231953pdfaa679r8a680f64ee692c8d@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114438>

Dmitry Potapov <dpotapov@gmail.com> wrote:

> It was fixed in Git 1.5.5 if I am not mistaken.

warthog>rpm -q git
git-1.5.4.3-3.fc8

It looks like I'm using a version of GIT that's just a little bit too old.

David
