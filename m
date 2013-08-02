From: =?UTF-8?B?SmVucyBNw7xsbGVy?= <blog@tessarakt.de>
Subject: Re: How to hierarchically merge from the root to the leaf of a branch
 tree? (Patch stack management)
Date: Fri, 02 Aug 2013 21:18:11 +0200
Message-ID: <kth0lc$48q$1@ger.gmane.org>
References: <ktc2sl$d4f$1@ger.gmane.org> <loom.20130801T092209-291@post.gmane.org> <ktfcq1$v8a$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 02 21:18:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Kru-0004PK-Fk
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 21:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753Ab3HBTS1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Aug 2013 15:18:27 -0400
Received: from plane.gmane.org ([80.91.229.3]:37953 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755746Ab3HBTS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 15:18:26 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1V5Krp-0004ET-6l
	for git@vger.kernel.org; Fri, 02 Aug 2013 21:18:25 +0200
Received: from p5dc8fd73.dip0.t-ipconnect.de ([93.200.253.115])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 21:18:25 +0200
Received: from blog by p5dc8fd73.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 21:18:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5dc8fd73.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0a2
In-Reply-To: <ktfcq1$v8a$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231536>

Am 02.08.2013 06:33, schrieb Jens M=C3=BCller:
> Am 01.08.2013 09:28, schrieb Jakub Narebski:
>> > There is also TopGit, which is feature-branch management tools (wh=
ich
>> > seems like what you want, from what you written below).
> Indeed, thank you very much for pointing me to it. I have not read th=
e
> whole documentation, but it sounds promising enough that I will try i=
t
> out with some real patches I have flying around and need to combine a=
nd
> do further development on.

Seems nice until now, but lacks some essential functionality ... For
example, you can add a dependency to a parent branch, but not remove it=
 ...
