From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Enumerating all objects in the Git object store
Date: Fri, 26 Mar 2010 21:11:47 +0100
Organization: Viscovery Software GmbH
Message-ID: <201003262111.48298.j.sixt@viscovery.net>
References: <a1138db31003260831q34967f69u9fc8de861f7931b1@mail.gmail.com> <4BACD86E.4020803@viscovery.net> <alpine.LFD.2.00.1003261324350.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Richards <paul.richards@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Mar 26 21:14:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFuq-0000Kk-RK
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 21:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab0CZUN4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 16:13:56 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:13402 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751426Ab0CZUNz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 16:13:55 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DE3D12C401B;
	Fri, 26 Mar 2010 21:13:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id BB5EF19F724;
	Fri, 26 Mar 2010 21:11:48 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <alpine.LFD.2.00.1003261324350.694@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143278>

On Freitag, 26. M=E4rz 2010, Nicolas Pitre wrote:
> On Fri, 26 Mar 2010, Johannes Sixt wrote:
> > Use 'git rev-list --objects --all' to find all objects connected to=
 all
> > refs (use something else than --all if you want to). Do *not* look =
at the
> > path that the tree and blob objects have attached - it is not autho=
rative
> > information.
>
> Really??

Yes, really. Consider the same content at two differen paths. Now what?=
=20
rev-list will only ever list the object once.

-- Hannes
