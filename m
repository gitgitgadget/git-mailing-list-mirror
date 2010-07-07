From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git rebase bug?
Date: Wed, 7 Jul 2010 20:00:04 +0200
Message-ID: <20100707180004.GA3165@atjola.homenet>
References: <20100707150545.GA24814@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jul 07 20:00:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWYuv-0001VM-Ag
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 20:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536Ab0GGSAL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 14:00:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:35691 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753424Ab0GGSAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 14:00:09 -0400
Received: (qmail invoked by alias); 07 Jul 2010 18:00:07 -0000
Received: from i59F57B68.versanet.de (EHLO atjola.homenet) [89.245.123.104]
  by mail.gmx.net (mp036) with SMTP; 07 Jul 2010 20:00:07 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19WRzRV8gFW15QCd+CTFz7qvbwp6hIRt2Aau4oyuC
	i4ULI8l/AU1IwS
Content-Disposition: inline
In-Reply-To: <20100707150545.GA24814@glandium.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150488>

On 2010.07.07 17:05:45 +0200, Mike Hommey wrote:
> See how the security/manager/ssl/public/nsIBadCertListener.idl file t=
hat
> was created by the original patch is created as
> xulrunner/examples/simple/content/contents.rdf.

The "problem" is that nsIBadCertListener.idl wasn't actually created by
the cherry-picked commit, but was modified. It was an empty file before=
,
created in 4292283190983fa91b875e22664a79a3aa9ea45d.

And as nsIBadCertListener.idl is missing from the xulrunner/2.0 branch,
git does the usual rename detection, finding another empty file and end=
s
up patching that one instead.

Bj=F6rn
