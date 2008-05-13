From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [RFC/PATCH] gitweb: Paginate project list
Date: Tue, 13 May 2008 15:11:02 -0400
Message-ID: <1210705862.1313.9.camel@gaara.bos.redhat.com>
References: <200805011220.58871.jnareb@gmail.com>
	 <200805130855.08133.jnareb@gmail.com>
	 <8c5c35580805130939m1a1ef8e0yd72402f3c79190ea@mail.gmail.com>
	 <200805131904.38317.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>,
	John Hawley <warthog19@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 21:12:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvzv1-0007qx-5I
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 21:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071AbYEMTLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 15:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756047AbYEMTLU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 15:11:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34500 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754828AbYEMTLT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 15:11:19 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4DJB7LU019882;
	Tue, 13 May 2008 15:11:07 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4DJB6qi002328;
	Tue, 13 May 2008 15:11:06 -0400
Received: from [10.16.3.198] (dhcp-100-3-198.bos.redhat.com [10.16.3.198])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4DJB54Q028042;
	Tue, 13 May 2008 15:11:06 -0400
In-Reply-To: <200805131904.38317.jnareb@gmail.com>
X-Mailer: Evolution 2.22.0 (2.22.0-4.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82037>

On Tue, 2008-05-13 at 19:04 +0200, Jakub Narebski wrote:

> I wonder how Freedesktop.org does it: it offers both gitweb and cgit
> interfaces, if I remember correctly...

I have a cron script in my homedir that scans the places we have repos
and generates the list of repos.  This generates a list of repo
description in the cgit config file format, which is included in the
cgit config file main.  It runs every hour or so.

Kristian
