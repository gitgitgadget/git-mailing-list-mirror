From: =?utf-8?b?RnJhbsOnb2lz?= Dagorn <Francois.Dagorn@univ-rennes1.fr>
Subject: Re: git-receive-pack missing credentials ?
Date: Tue, 8 Nov 2011 10:50:34 +0000 (UTC)
Message-ID: <loom.20111108T114722-414@post.gmane.org>
References: <4EB7FA3A.8070908@univ-rennes1.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 11:50:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNjGa-0001am-3u
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 11:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab1KHKus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 05:50:48 -0500
Received: from lo.gmane.org ([80.91.229.12]:48048 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338Ab1KHKus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 05:50:48 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RNjGR-0001Ym-C8
	for git@vger.kernel.org; Tue, 08 Nov 2011 11:50:47 +0100
Received: from zag.istic.univ-rennes1.fr ([148.60.10.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 11:50:47 +0100
Received: from Francois.Dagorn by zag.istic.univ-rennes1.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 11:50:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 148.60.10.22 (Mozilla/5.0 (X11; Linux i686; rv:6.0) Gecko/20100101 Firefox/6.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185082>

It was an ExecCGI issue :

when adding "Options ExecCGI" on the
directory hosting git repositories, everything was ok.

=46ran=C3=A7ois
