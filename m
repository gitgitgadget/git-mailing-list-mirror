From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit: stgit mail configuration options
Date: Mon, 10 Nov 2008 11:19:58 +0100
Message-ID: <20081110101958.GA14955@diana.vm.bytemark.co.uk>
References: <871vxptasf.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Nov 10 11:22:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzTuK-0008Pi-Tr
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 11:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbYKJKU3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 05:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbYKJKU3
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 05:20:29 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2819 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbYKJKU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 05:20:29 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KzTsE-000439-00; Mon, 10 Nov 2008 10:19:58 +0000
Content-Disposition: inline
In-Reply-To: <871vxptasf.fsf@krank.kagedal.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100511>

On 2008-11-06 11:21:20 +0100, David K=E5gedal wrote:

> The "stg mail" command uses a couple of configuration options that
> are completely undocumented, and don't fit well together.

I agree that they definitely need documenting.

As for renaming them and/or changing their types, that's probably a
good idea too. And once they are documented, we could e.g. rename and
only mention the new name in the docs, but keep the old name as well
for backward compatibility.

One interesting twist would be to fix StGit's config parser so that it
can automatically generate a man page listing all the config options
it recognizes. It needs updating anyway for other reasons (I believe
it still calls git-config several times instead of just once), and
this could be done at the same time.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
