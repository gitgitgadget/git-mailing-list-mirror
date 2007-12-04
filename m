From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Use a strbuf for copying the command line for the
	reflog.
Date: Tue, 04 Dec 2007 10:46:16 -0500
Message-ID: <1196783176.2606.2.camel@hinata.boston.redhat.com>
References: <1196753147-20073-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 04 16:47:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzZzK-0000XB-9p
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 16:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbXLDPqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 10:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbXLDPqt
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 10:46:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44468 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889AbXLDPqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 10:46:49 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lB4FkMau011477;
	Tue, 4 Dec 2007 10:46:22 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lB4FkLu9017640;
	Tue, 4 Dec 2007 10:46:21 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lB4FkLxd004311;
	Tue, 4 Dec 2007 10:46:21 -0500
In-Reply-To: <1196753147-20073-1-git-send-email-krh@redhat.com>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67059>

Doh, I forgot -n to git-format-patch again for this two patch series.
Maybe git-format-patch should default to -n when there's more than one
patch?  Anyway, it should have been:

[PATCH 1/2] Use a strbuf for copying the command line for the reflog.
[PATCH 2/2] Rewrite builtin-fetch option parsing to use parse_options().

cheers,
Kristian
