From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: add deprecated __git_complete_file ()
Date: Sat, 8 Jun 2013 02:24:52 +0200
Message-ID: <20130608002452.GE31625@goldbirke>
References: <1370632168-25298-1-git-send-email-artagnon@gmail.com>
 <7vobbhsll3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 02:25:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul6y5-0002XE-Je
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 02:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005Ab3FHAY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 20:24:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:58695 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab3FHAY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 20:24:58 -0400
Received: from localhost6.localdomain6 (g228010151.adsl.alicedsl.de [92.228.10.151])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0Lsfxh-1UNDCP1hgP-012Kd1; Sat, 08 Jun 2013 02:24:52 +0200
Content-Disposition: inline
In-Reply-To: <7vobbhsll3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:FBdOeA3OtWG49KlmlwlPXlkRVRf4coVy37B0RZ5WfI5
 +fLC3xKMU3Vcspot+nwWMzSVcUTmLm5r4/QcUcTl/TYbL+no7M
 nb2ZGzwriwo/LI47fizmefnbsKWiwHsNABw94/b7bqBXATIENF
 N/SWqvvME0GV/Ufof5eWgPZ2fCbtpQecbW+KmpAjMfk9jvBtmO
 208dGLuHlXOUdltUPzoaHKpQ6xClcIk/I9FHt1NJNmTjZVdz9y
 j93A5M/RJhplsX8SYUWrGIYufz+lKtCrqo+qFhvMlUBwX50NI6
 XcnL14MTshkkVnNNBOFGFlUsWnrQjXzIi1vX2N7Rndc9vILDKH
 dCmUc6YavCdHEF4y3lN5i6WJKrh0FatNQahZS0GwP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226770>

On Fri, Jun 07, 2013 at 01:38:16PM -0700, Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
> > 77c130 (completion: clarify ls-tree, archive, show completion,
> > 2013-06-02) removed __git_complete_file () because it had no callers
> > left in the file.  However, to avoid breaking user scripts that may
> > depend on this, add it back as a deprecated alias.
> >
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> > ---
> >  Based on pu.
> 
> Will queue; thanks.  With this, I think it will be safe to push the
> series in question to 'master'.

Safe?  Yes, at least scripts won't break because of the missing
function.

However, I still think it would be worth reverting at least the hunks
modifying the completion functions of ls-tree and archive.  Or better
yet, the whole series.
