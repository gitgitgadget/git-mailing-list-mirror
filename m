From: Jeff King <peff@peff.net>
Subject: Re: problems with importing from cvs archive
Date: Sun, 2 Dec 2007 12:07:41 -0500
Message-ID: <20071202170741.GB29781@coredump.intra.peff.net>
References: <20071202064613.GB25351@venus> <C4B8CB94-3B39-4C14-9134-DE43684A3AB7@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ed S. Peschko" <esp5@pge.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Veillette 
	<jean_francois_veillette@yahoo.ca>
X-From: git-owner@vger.kernel.org Sun Dec 02 18:08:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IysIY-0008KJ-NV
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 18:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbXLBRHp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2007 12:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbXLBRHp
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 12:07:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4769 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbXLBRHo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 12:07:44 -0500
Received: (qmail 22068 invoked by uid 111); 2 Dec 2007 17:07:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Dec 2007 12:07:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Dec 2007 12:07:41 -0500
Content-Disposition: inline
In-Reply-To: <C4B8CB94-3B39-4C14-9134-DE43684A3AB7@yahoo.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66796>

On Sun, Dec 02, 2007 at 10:14:07AM -0500, Jean-Fran=E7ois Veillette wro=
te:

> Le 07-12-02 =E0 01:46, Ed S. Peschko a =E9crit :
>
>> All,
>>
>> I'm trying to use git-cvsimport to import from a CVS archive, using:
>>
>> git-cvsimport -d $CVSROOT
>
> I was able to go further just by adding the verbose mode ( -v ) :
> git cvsimport -v -d ...

There were some serious problems with the argument parsing of
git-cvsimport with respect to finding the correct module from the git
config or from your CVS working directory. This should all be fixed in
v1.5.3.7; please let me know if you still have a problem with that
version.

-Peff
