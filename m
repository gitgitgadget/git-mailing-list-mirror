From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 10:06:39 +0100
Message-ID: <fabb9a1e1002120106n3c7e8bcje04bfeb996940222@mail.gmail.com>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com> 
	<20100212080620.GA31719@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Feb 12 10:13:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfraY-0007qc-1G
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 10:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945Ab0BLJNU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 04:13:20 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:37325 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0BLJNS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 04:13:18 -0500
Received: by qw-out-2122.google.com with SMTP id 5so46291qwi.37
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 01:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=j88Je/pSQ8YgBWuBSGeoqivFtnZP5AG/TDIslFpuXX8=;
        b=ZmGJmie3XHua+rgBpDQZx4pFPa6igbuK1SqepG7SGR5oCFyrsDcXUU78ITR9EzA2Ax
         h+hs02kOm3PDuhIOia+3WT7Ol64ViM0aGdHIYhk0j4SZHGQrvZcMxm/mPcIRZMcTK5Ba
         AouB/oluQSGp3UQBnOb0Rw0N2ak+dE6ybDNcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gkGkyahAw4vQpPPfk/CPBk1qb/7olJXugilVUsM5Qowg9pLOMlR81i/17Ir9jwwjzF
         eAtSH+sJUpKLIXbRxBtmYs1H6hQGpgxJIAovneKqCcqyOqkMv4vO2NMPs+cnlgL8ZBIJ
         VdnUQcRD21x6BCzbfuypJk8ViISkI/QP7+zTw=
Received: by 10.224.80.66 with SMTP id s2mr536212qak.293.1265965619108; Fri, 
	12 Feb 2010 01:06:59 -0800 (PST)
In-Reply-To: <20100212080620.GA31719@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139666>

Heya,

On Fri, Feb 12, 2010 at 09:06, Eric Wong <normalperson@yhbt.net> wrote:
> I can't commit to anything, but they're welcome to email me/the list =
for
> guidance.

Can't ask for more :).

> =A0The git-vcs-* stuff is interesting and a good reason to refactor/r=
edo
> =A0parts of git-svn to work with it. =A0It's been overdue for a
> =A0refactoring/cleanup for _years_ now.

Do you think that the code can be sane again if we use git-svn as a
base? Wouldn't it be better to start from scratch and use git-svn only
as a reference as to how to interact with svn?

> I can't say SVN (nor the Perl support libraries) are pleasant to work
> with. =A0Things to keep in mind:

Perhaps then it would indeed be better to just work with the C
bindings, if they are equally painful.

> I'm sure I'm missing some things here that my mind just blocked
> out entirely...

Do you have any idea how we are wrt licensing issues? II[U|R]C the svn
bindings are APLv2 licensed which would be problematic if we try to
use it in git?

--=20
Cheers,

Sverre Rabbelier
