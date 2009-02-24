From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: autocrlf=input and safecrlf (was Re: CVS import [SOLVED])
Date: Tue, 24 Feb 2009 10:25:12 +0100 (CET)
Message-ID: <14283.77.61.241.211.1235467512.squirrel@hupie.xs4all.nl>
References: <20090220152849.GA3826@coredump.intra.peff.net>
    <32886.77.61.241.211.1235147143.squirrel@hupie.xs4all.nl>
    <20090220172918.GB4636@coredump.intra.peff.net>
    <499F3B9B.3020709@pelagic.nl>
    <20090223000840.GA20392@coredump.intra.peff.net>
    <2944.77.61.241.211.1235371848.squirrel@hupie.xs4all.nl>
    <20090223065615.GA24807@coredump.intra.peff.net>
    <1570.77.61.241.211.1235372943.squirrel@hupie.xs4all.nl>
    <20090223071056.GA29241@coredump.intra.peff.net>
    <59288.77.61.241.211.1235374197.squirrel@hupie.xs4all.nl>
    <20090224061134.GF4615@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Ferry Huberts" <ferry.huberts@pelagic.nl>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 10:26:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbtYq-0002Dh-47
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbZBXJZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754137AbZBXJZP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:25:15 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:56148 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754092AbZBXJZO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 04:25:14 -0500
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id 454F558BDBB; Tue, 24 Feb 2009 10:25:12 +0100 (CET)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Tue, 24 Feb 2009 10:25:12 +0100 (CET)
In-Reply-To: <20090224061134.GF4615@coredump.intra.peff.net>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111249>


> So yes, in some sense it is safecrlf that is broken. I'm just concerned
> about tweaking the user's options behind their back. The import can
> happen differently than they expected no matter which of safecrlf or
> autocrlf you tweak. So I think you are better off to complain and die.

The plan was:
- when creating a new git repo for cvs import: setup safecrlf=false
- when importing into an existing repo: check whether the safecrlf
  setting is set to false and crash and burn when not :-)
  (complain before going up in flames)
