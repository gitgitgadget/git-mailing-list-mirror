From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Any tricks for speeding up cvsps?
Date: Fri, 8 Feb 2008 10:48:12 +0100
Message-ID: <20080208094812.GA9666@diana.vm.bytemark.co.uk>
References: <47AC1FDC.9000502@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 10:49:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNPrH-0007vk-6U
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 10:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760813AbYBHJst convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2008 04:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760997AbYBHJst
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 04:48:49 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3174 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbYBHJsr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 04:48:47 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JNPq8-0002ef-00; Fri, 08 Feb 2008 09:48:12 +0000
Content-Disposition: inline
In-Reply-To: <47AC1FDC.9000502@glidos.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73059>

On 2008-02-08 09:24:44 +0000, Paul Gardiner wrote:

> I'm trying to convert a huge cvs repository. I've left cvsps running
> for days. First attempt, stderr filled my disc with warnings about
> tags that couldn't be associated with any one commit, without
> producing anything from stdout. I'm now redirecting stderr to
> /dev/null, but it still just sits there producing nothing. Is
> git-cvsimport infeasible for large repositories, or are there tricks
> I might use?

This topic comes up on the list every once in a while; try searching
the list archives.

I seem to recall that for heavy imports, the Subversion CVS importer
is popular. I don't know if it can give you a git repository directly,
or if you'll have to go via svn.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
