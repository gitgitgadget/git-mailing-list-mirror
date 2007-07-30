From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Recent strbuf/builtin-commit-tree/wt-status patch series
Date: Mon, 30 Jul 2007 17:48:32 -0400
Message-ID: <1185832112.11086.19.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 23:48:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFd6Z-0008IU-C7
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 23:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967765AbXG3Vsk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 17:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967849AbXG3Vsk
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 17:48:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56990 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965101AbXG3Vsj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 17:48:39 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULmcDH026928
	for <git@vger.kernel.org>; Mon, 30 Jul 2007 17:48:38 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULmclo031554
	for <git@vger.kernel.org>; Mon, 30 Jul 2007 17:48:38 -0400
Received: from [192.168.1.102] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULmbUd022435
	for <git@vger.kernel.org>; Mon, 30 Jul 2007 17:48:37 -0400
X-Mailer: Evolution 2.11.4 (2.11.4-1.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54280>

Hi,

I forgot -n to format-patch, sorry.  The ordering I have here is

        [PATCH] Add test case for basic commit functionality.
        [PATCH] Enable wt-status output to a given FILE pointer.
        [PATCH] Add strbuf_printf() to do formatted printing to a
        strbuf.
        [PATCH] Make builtin-commit-tree use a strbuf instead of
        hand-rolled realloc buffer.
        [PATCH] Split out the actual commit creation from the option
        parsing etc.
        
and finally 

        [PATCH] Split out the actual commit creation from the option
        parsing etc.
        
It fell out of the series when I reordered some patches, so I sent it
separately.

This series is some infrastructure changes and the test case I've been
using for my work on builtin-commit.  They are all immediately
committable, and constitute most of the changes to git required by
builtin-commit.

cheers,
Kristian
