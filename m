From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Sat, 07 Oct 2006 13:27:39 +0200
Organization: At home
Message-ID: <eg82tq$2uq$1@sea.gmane.org>
References: <20061006212616.GA5175@lumumba.uhasselt.be> <20061006220542.GA5890@lumumba.uhasselt.be> <BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE> <BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE> <7viriwsa75.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Oct 07 13:27:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWAKj-0004KB-05
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 13:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWJGL1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 7 Oct 2006 07:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWJGL1E
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 07:27:04 -0400
Received: from main.gmane.org ([80.91.229.2]:7602 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750922AbWJGL1C (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 07:27:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GWAKX-0004HG-83
	for git@vger.kernel.org; Sat, 07 Oct 2006 13:26:57 +0200
Received: from host-81-190-22-223.torun.mm.pl ([81.190.22.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 13:26:57 +0200
Received: from jnareb by host-81-190-22-223.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 13:26:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-223.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28473>

Junio C Hamano wrote:

> I think it is prudent to protect the client from a broken server
> and it is independent from "fixing" the server side. =A0It would
> perhaps make sense to make this overridable somehow but I am not
> sure how -- .git/config is too global (the problem would be per
> remote site), and having the user to set environment variable
> only when going to specific server is too cumbersome to be
> useful. =A0This ideally should be a per-remote configuration
> item.

Perhaps use undocumented (hint, hint! for whoever did code this)
per-user ~/.gitconfig?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
