From: Mike Hommey <mh@glandium.org>
Subject: Re: Silly revert question workflow...
Date: Thu, 6 Mar 2008 07:37:31 +0100
Organization: glandium.org
Message-ID: <20080306063731.GA8537@glandium.org>
References: <47CF8F4E.5010809@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gonzalo =?iso-8859-15?Q?Garramu=F1o?= <ggarra@advancedsl.com.ar>
X-From: git-owner@vger.kernel.org Thu Mar 06 07:33:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX9fy-00033Z-P5
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 07:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704AbYCFGdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 01:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756534AbYCFGdV
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 01:33:21 -0500
Received: from vuizook.err.no ([194.24.252.247]:38498 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755609AbYCFGdV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 01:33:21 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JX9fE-0008Dx-BD; Thu, 06 Mar 2008 07:33:18 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JX9jP-0002El-P6; Thu, 06 Mar 2008 07:37:31 +0100
Content-Disposition: inline
In-Reply-To: <47CF8F4E.5010809@advancedsl.com.ar>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76344>

On Thu, Mar 06, 2008 at 03:29:34AM -0300, Gonzalo Garramu=F1o wrote:
>
> I'm wondering if there's any easy way to basically "fix" the last com=
mit =20
> from the history.  To explain a little bit...
>
> Being the silly guy I am, one of the very common things I do is that =
I =20
> may be working on two features simultaneously.
> Then one feature is done, I will do a check-in and then seconds later=
 =20
> I'll realize that I forgot to add, say, another .h file that was also=
 =20
> modified and that I thought was not needed for that commit.
> Sure enough, without that .h file the tree as checked in is really in=
 an =20
> uncompilable state.
>
> git revert allows me to revert the commit and do it again.  But it st=
ill =20
> leaves a commit in the history tree that is uncompilable.

You are looking for git commit --amend

Mike
