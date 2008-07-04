From: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Subject: Puzzled by gitk patch representation for merge commits
Date: Fri, 04 Jul 2008 11:14:20 +0200
Message-ID: <g4kpmu$9ga$1@ger.gmane.org>
Reply-To: t2a2e9z8ncbs9qg@brefemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 04 11:16:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEhOt-0007YW-Hw
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 11:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbYGDJPW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jul 2008 05:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbYGDJPW
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 05:15:22 -0400
Received: from main.gmane.org ([80.91.229.2]:56946 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbYGDJPV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 05:15:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KEhNu-00059E-UE
	for git@vger.kernel.org; Fri, 04 Jul 2008 09:15:18 +0000
Received: from ngw.virtuallogix.com ([212.11.48.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 09:15:18 +0000
Received: from t2a2e9z8ncbs9qg by ngw.virtuallogix.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 09:15:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ngw.virtuallogix.com
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87378>

Hello,

I don't understand the graphical scheme that gitk uses when displaying=20
patches for merge commits. I would like to be able to explain this to=20
the people I'm trying to evangelize to git, because they are also=20
puzzled when they try to check with gitk what a merge has done to a=20
given file.

I can see that at least three graphical hints seem to be involved:
- font: regular/bold
- color: red/blue
(maybe there are more colors when the commit has more than two parents?=
)
- column for displaying the '+' or '-'

But I just don't see what is the respective semantics of these hints...

(I'm using git 1.5.5.1 if that matters.)

Thanks in advance,
J=E9r=F4me
