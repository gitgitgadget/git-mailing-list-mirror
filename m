From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: Automated/Daily build systems supporting git?
Date: Tue, 08 Apr 2008 11:22:26 -0400
Message-ID: <1207668146.5885.5.camel@gaara.boston.redhat.com>
References: <1207666672.5698.4.camel@pitcairn.cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 17:23:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjFfP-000882-Io
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 17:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbYDHPWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 11:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbYDHPWg
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 11:22:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51730 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbYDHPWf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 11:22:35 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m38FMWrs021834;
	Tue, 8 Apr 2008 11:22:32 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m38FMWeU028327;
	Tue, 8 Apr 2008 11:22:32 -0400
Received: from [192.168.1.104] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m38FMW3F021934;
	Tue, 8 Apr 2008 11:22:32 -0400
In-Reply-To: <1207666672.5698.4.camel@pitcairn.cambridgebroadband.com>
X-Mailer: Evolution 2.22.0 (2.22.0-4.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79003>

On Tue, 2008-04-08 at 15:57 +0100, Alex Bennee wrote:
> Hi,
> 
> I'm currently doing some investigation into automated/daily build
> systems to track the health of a source tree. There seem to be a number
> about but as I'm also looking to move the CVS tree over to git I was
> wondering if the denziens of the list knew of any they could recommend?
> 
> Ideally it would be an open source system. For bonus points something
> that could auto bisect and point at culprit commits would be great :-)
> 
> If there are any systems that don't yet support git but people feel are
> clean systems capable of having support added I would also be all ears.

We have a jhbuild tinderbox setup for the X modules on freedesktop.org,
which builds out of git:

  http://tinderbox.freedesktop.org/

Which Chris Ball set up.  I don't know the details of the setup, except
that it probably involves a cronscript, the jhbuild tinderbox command
(http://www.gnome.org/~jamesh/jhbuild.html#command-reference-tinderbox)
and uses the jhbuild moduleset we maintain over here:

  http://cgit.freedesktop.org/xorg/util/modular

Look for the xorg.modules file.

cheers,
Kristian
