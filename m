From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] bisect: use update-ref to update refs
Date: Wed, 28 Mar 2007 15:46:09 +0200
Organization: eudaptics software gmbh
Message-ID: <460A71A1.D1388D3@eudaptics.com>
References: <20070328123519.GA4472@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 15:46:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWYTe-0002cj-Un
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 15:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbXC1NqL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Mar 2007 09:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbXC1NqL
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 09:46:11 -0400
Received: from main.gmane.org ([80.91.229.2]:53816 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbXC1NqK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 09:46:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HWYTO-0005W8-1g
	for git@vger.kernel.org; Wed, 28 Mar 2007 15:45:58 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Mar 2007 15:45:57 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Mar 2007 15:45:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43372>

Uwe Kleine-K=F6nig wrote:
>         GIT_DIR=3D"$GIT_DIR" git-$command ...
>=20
> where the assignment to GIT_DIR should be superfluous?

git-sh-setup sets GIT_DIR, but does not export it. Therefore, this
assignment is *not* superfluous (its effect is to export GIT_DIR for
this command only).

-- Hannes
