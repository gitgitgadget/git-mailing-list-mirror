From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: StGIT loses Git commit using "stg repair"; I miss "stg assimilate"
Date: Tue, 08 Jan 2008 00:11:57 +0100
Message-ID: <873at9z0w2.fsf@lysator.liu.se>
References: <200801072345.21585.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 00:12:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC18d-0007aX-0z
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 00:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbYAGXLm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2008 18:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbYAGXLl
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 18:11:41 -0500
Received: from main.gmane.org ([80.91.229.2]:58453 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955AbYAGXLl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 18:11:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JC181-0008SW-45
	for git@vger.kernel.org; Mon, 07 Jan 2008 23:11:33 +0000
Received: from 87.96.142.114 ([87.96.142.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 23:11:33 +0000
Received: from davidk by 87.96.142.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 23:11:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.96.142.114
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:hIFQQ8BEZqRpTwYZ3+KxVfVzMl8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69824>

Jakub Narebski <jnareb@gmail.com> writes:

> I have StGIT branch with no patches applied: all patches are on stack=
=2E
> I have accidentally added git commit on top of StGIT branch head.
> I tried to use "stg assimilate" to turn this commit into StGIT commit=
,=20
> applied, but new version of StGIT has only "stg repair". And the=20
> sequence

If you have no patches, there is nothing to assimilate or repair. Your
patch stack is considered to be on top of your new commit, so if you
push a patch it will appear on top of the commit you just created.

To turn your new commit into a patch, use "stg uncommit".

>  # stg repair
>  # stg rebase origin
>
> made me lose this git commit (well, up to reflog of course). This sho=
uld=20
> not happen! Why assimilate got removed?

repair does exactly what assimilate did in this case, so it would not
have helped you.

--=20
David K=C3=A5gedal
