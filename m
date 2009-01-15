From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Add --file option to pick
Date: Thu, 15 Jan 2009 09:26:14 +0100
Message-ID: <20090115082614.GA24890@diana.vm.bytemark.co.uk>
References: <20090114225930.11098.2144.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 09:27:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNNZq-0005dM-8j
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 09:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203AbZAOI0W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 03:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755535AbZAOI0W
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 03:26:22 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1331 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486AbZAOI0V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 03:26:21 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LNNYM-0006Z4-00; Thu, 15 Jan 2009 08:26:14 +0000
Content-Disposition: inline
In-Reply-To: <20090114225930.11098.2144.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105772>

On 2009-01-14 22:59:30 +0000, Catalin Marinas wrote:

> +    opt('-f', '--files', action =3D 'append',
> +        short =3D 'Only fold the given files'),

The long form should probably be "--file", since you only list one
file for every flag (and since you call it "--file" in the last hunk).
And the help text could be something like

  Only fold the given file (for multiple files, use -f more than once)

> +                raise CmdException, 'Patch folding failed'

This is not important, but I believe the recommended syntax for
raising exceptions nowadays is

  CmdException('Patch folding failed')

since that's what'll continue to work in Python 3, or something like
that. (I see you already use it in the multi-line case in the other
patch, where this syntax is clearly the better choice.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
