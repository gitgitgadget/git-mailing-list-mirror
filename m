From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 2/2] Allow fetch-pack to decide keeping the fetched pack without exploding
Date: Tue, 23 Jan 2007 17:28:13 +0100
Message-ID: <87sle17lnm.fsf@morpheus.local>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0701230809440.32200@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Jan 23 17:28:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9OVf-0008PL-AD
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 17:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbXAWQ2c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 23 Jan 2007 11:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbXAWQ2c
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 11:28:32 -0500
Received: from main.gmane.org ([80.91.229.2]:45809 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964999AbXAWQ2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 11:28:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H9OVQ-0006CX-Do
	for git@vger.kernel.org; Tue, 23 Jan 2007 17:28:20 +0100
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 17:28:20 +0100
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 17:28:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:hbxKMHuBbPVaCJhPA1tVn82yInU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37546>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 23 Jan 2007, Johannes Schindelin wrote:
>>=20
>> P.S.: These patches make me dream of yet another diff format enhance=
ment:=20
>> code moves!
>
> It's basically impossible.
>
> Why? You need the context.=20

Yes, I think that a diff format for code moves wouldn't be useful.
What could potentially be useful is a graphical diff browser that can
e.g.  show two versions side-by-side and show code moves in that.  I
have a vague memory that the ClearCase merge tool did that.

But as long as the code moves are within a single file, that merge
tool could derive that move from an ordinary diff.

--=20
David K=C3=A5gedal
