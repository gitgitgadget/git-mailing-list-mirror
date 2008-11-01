From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Git/Mercurial interoperability (and what about bzr?)
Date: Sat, 01 Nov 2008 12:10:55 +0100
Message-ID: <87hc6rog5c.fsf@mid.deneb.enyo.de>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org>
	<alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	<Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se>
	<E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl>
	<20081028191234.GS24201@genesis.frugalware.org>
	<20081028213144.GC10862@mit.edu> <87ljw3zx8i.fsf@mid.deneb.enyo.de>
	<m3prlffzk2.fsf@localhost.localdomain>
	<87abcjpvy2.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 12:12:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwEOr-0007yi-7o
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 12:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbYKALK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 07:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbYKALK7
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 07:10:59 -0400
Received: from mail.enyo.de ([212.9.189.167]:48973 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbYKALK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 07:10:58 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1KwENb-0003eZ-TX; Sat, 01 Nov 2008 12:10:55 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1KwENb-000155-Hl; Sat, 01 Nov 2008 12:10:55 +0100
In-Reply-To: <87abcjpvy2.fsf@mid.deneb.enyo.de> (Florian Weimer's message of
	"Sat, 01 Nov 2008 11:44:21 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99732>

* Florian Weimer:

>> Now Mercurial has chosen to use in-tree '.hgtags' file to have global
>> tags transferable.  Never mind the fact that it had to treat this file
>> in special way to have it non-versioned
>
> Oops, thought this file was versioned.  Things like
>
>   <http://tycoon.hpl.hp.com/changeset/932:931d181e9f58/.hgtags>
>
> suggest it was at some point.

Okay, checked it--.hgtags files are in fact versioned.  So my
suggestion to preserve the .hgtags file on the Git side remains.
