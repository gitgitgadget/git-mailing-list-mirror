From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: git fetch -v not at all verbose?
Date: Thu, 21 Jan 2010 18:10:17 +0200
Message-ID: <20100121161016.GA16300@redhat.com>
References: <20100121004756.GA18213@onerussian.com> <20100121050850.GA18896@Knoppix> <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com> <20100121155136.17b59e8f.rctay89@gmail.com> <20100121140054.GH18213@onerussian.com> <20100121224100.624c9c9d.rctay89@gmail.com> <20100121155637.GA19078@spearce.org> <20100121160707.GA31276@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 17:14:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXzfy-0000ho-NP
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 17:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515Ab0AUQOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 11:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470Ab0AUQOW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 11:14:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:5486 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab0AUQOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 11:14:21 -0500
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o0LGDMcF020989
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 21 Jan 2010 11:13:22 -0500
Received: from redhat.com (vpn2-8-112.ams2.redhat.com [10.36.8.112])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id o0LGDJvq001628;
	Thu, 21 Jan 2010 11:13:20 -0500
Content-Disposition: inline
In-Reply-To: <20100121160707.GA31276@glandium.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137662>

Hi!
On many of my trees (with linux kernel), git fetch is slower than git clone.
Even more annoyingly, it would hang sometimes for tens of minutes without any
output, even if -v is supplied.

stracing it shows a ton of lines like the following:
16324 read(10, "ACK 4bbdfe65d23014f539fec4227260"..., 51) = 51
16324 read(10, "0037", 4)               = 4
16324 read(10, "ACK 322c06560fa314b04a6302ea03c0"..., 51) = 51
16324 read(10, "0037", 4)               = 4
16324 read(10, "ACK 848ea2043b128b5947851866a114"..., 51) = 51
16324 read(10, "0037", 4)               = 4

Is there some way to make got fetch show progress at this stage,
or even better, can it be made faster somehow?

Thanks!

-- 
MST
