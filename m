From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Feature request: relative paths
Date: Thu, 6 May 2010 10:46:07 +0200
Message-ID: <20100506084607.GA9921@atjola.homenet>
References: <19426.23330.525936.981066@winooski.ccs.neu.edu>
 <20100506083113.GA25993@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eli Barzilay <eli@barzilay.org>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 10:47:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9wjT-0003SD-CW
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 10:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756335Ab0EFIqS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 04:46:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:49413 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756303Ab0EFIqO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 04:46:14 -0400
Received: (qmail invoked by alias); 06 May 2010 08:46:11 -0000
Received: from i59F54DBC.versanet.de (EHLO atjola.homenet) [89.245.77.188]
  by mail.gmx.net (mp041) with SMTP; 06 May 2010 10:46:11 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+HiR1zDuaHiQAXSXHl48tkILxBYrt0Hu/pdkSlpb
	oIX+M2Y/E8vaGE
Content-Disposition: inline
In-Reply-To: <20100506083113.GA25993@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146461>

On 2010.05.06 03:31:13 -0500, Jonathan Nieder wrote:
> Eli Barzilay wrote:
>=20
> > An svn feature that I used a lot is `svn cat some-file' -- and with
> > git I can get close to that with `git show :some-file'
>=20
> git show -- some-file

That's the same as "git show HEAD -- some-file" though, which shows a
commit with path-limited diff output. While ":some-file" (most likely)
identifies a blob, so "git show :some-file" shows the contents stored i=
n
that blob.

Bj=F6rn
