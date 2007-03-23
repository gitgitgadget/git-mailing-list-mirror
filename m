From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Fri, 23 Mar 2007 14:57:38 +0100
Organization: At home
Message-ID: <eu0m6t$hln$1@sea.gmane.org>
References: <20070321120643.GI20583@mellanox.co.il> <7v648u38ws.fsf@assigned-by-dhcp.cox.net> <20070322043604.GA6303@mellanox.co.il> <7vd531yicx.fsf@assigned-by-dhcp.cox.net> <20070322062805.GD6303@mellanox.co.il> <7vaby5wxyn.fsf@assigned-by-dhcp.cox.net> <20070322074051.GA29341@mellanox.co.il> <7vlkhpvgc7.fsf@assigned-by-dhcp.cox.net> <20070322083757.GC29341@mellanox.co.il> <7vr6rhtvr0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 14:55:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUkEc-0006Or-BS
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 14:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422890AbXCWNzK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Mar 2007 09:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422906AbXCWNzK
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 09:55:10 -0400
Received: from main.gmane.org ([80.91.229.2]:43281 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422890AbXCWNzI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 09:55:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HUkEH-0002ZZ-MA
	for git@vger.kernel.org; Fri, 23 Mar 2007 14:54:56 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 14:54:53 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 14:54:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42930>

Junio C Hamano wrote:

> +The commit message is formed by the title taken from the
> +"Subject: ", a blank line and the body of the message up to
> +where the patch begins. =A0Excess whitespaces at the end of the
> +lines are automatically stripped.

Does this mean that git-am cannot make a log message that doesn't
follow git formatting commit message guidelines, namely short one-line
description, then longer description and signoff? It means that
you cannot get log message which starts with paragraph (no emty line
after first line of commit message)?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
