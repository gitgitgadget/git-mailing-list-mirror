From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Separating "add path to index" from "update content in index"
Date: Fri, 22 Dec 2006 09:24:36 +0100
Organization: At home
Message-ID: <emg4j2$f8v$1@sea.gmane.org>
References: <89b129c60612191233s5a7f36f2hd409c4b9a2bbbc5c@mail.gmail.com> <7v64c7pmlw.fsf@assigned-by-dhcp.cox.net> <87wt4m2o99.wl%cworth@cworth.org> <7vmz5i6vqb.fsf@assigned-by-dhcp.cox.net> <87vek62n1k.wl%cworth@cworth.org> <7v1wmu5ecs.fsf@assigned-by-dhcp.cox.net> <87tzzp3fgh.wl%cworth@cworth.org> <slrneokplo.nsf.Peter.B.Baumann@xp.machine.xx> <7vbqlw92fw.fsf@assigned-by-dhcp.cox.net> <87d56cirs8.wl%cworth@cworth.org> <7vfyb87bxg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Dec 22 09:22:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxffe-0005pI-JP
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 09:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945972AbWLVIWY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Dec 2006 03:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945973AbWLVIWY
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 03:22:24 -0500
Received: from main.gmane.org ([80.91.229.2]:60798 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945972AbWLVIWX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 03:22:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GxffQ-0007zz-AI
	for git@vger.kernel.org; Fri, 22 Dec 2006 09:22:12 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 09:22:12 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 09:22:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35142>

Junio C Hamano wrote:

> And it is not just limited to adding the contents of a path that
> happened to be told git for the first time. =A0Adding the contents
> of a path that was known to git also happens only when it is in
> a presentable good state. =A0So running "git diff" and not seeing
> what I added before is a GOOD THING.

If I remember correctly the idea behind "intent to add" was to show
only that file was added (e.g. the "new file" line from extended diff
header) in "git diff" when file was added and not modified
(and no changes to "git diff HEAD").

Although I'm not sure if this wouldn't screw some use cases which
include something like "git diff > some-temporary-file"...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
