From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 11:39:43 +0200
Message-ID: <20100423093943.GB30346@atjola.homenet>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock>
 <87wrvzs590.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
 <87sk6n4426.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 23 11:39:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5FMY-0006KE-KD
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 11:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756850Ab0DWJjs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 05:39:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:50660 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754445Ab0DWJjs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 05:39:48 -0400
Received: (qmail invoked by alias); 23 Apr 2010 09:39:45 -0000
Received: from i59F554BA.versanet.de (EHLO atjola.homenet) [89.245.84.186]
  by mail.gmx.net (mp063) with SMTP; 23 Apr 2010 11:39:45 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19uuB0c9PRuvEwgGKm0O4tOikvI1ziJb5WYTcC7GT
	E2/TviRlnnjPBR
Content-Disposition: inline
In-Reply-To: <87sk6n4426.fsf@frosties.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68000000000000005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145606>

On 2010.04.22 22:37:05 +0200, Goswin von Brederlow wrote:
> Is there a risk? You do get an editor with all the files affected lis=
ted
> giving you a big fat warning what you are about to commit.

And if I happen to have two unrelated changes in a single file that's
worth nothing at all. For example, I might have changed the condition
that causes some message to be shown, and discovered a typo in the
message itself and fixed it along the way. That needs two commits, but
the list of modified files doesn't tell that.

Only "commit -v" would help there, showing the diff in the editor. But
reviewing the diff in the editor is a PITA and I lose the whole review
progress if I find something I don't want to commit and have to abort.
Using "git add [-i|-p|-e]", git helps me to keep track of the changes I
already reviewed and decided to commit.

Bj=F6rn
