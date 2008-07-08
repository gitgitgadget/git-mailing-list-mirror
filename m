From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Discard stderr output from git apply
Date: Tue, 8 Jul 2008 06:39:02 +0200
Message-ID: <20080708043902.GD2247@diana.vm.bytemark.co.uk>
References: <20080704063427.9515.68707.stgit@yoghurt> <b0943d9e0807071349u7c35d2fcr5025b2b282f290f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:40:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG4zo-0005gP-5B
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbYGHEjL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 00:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbYGHEjK
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:39:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3379 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbYGHEjI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:39:08 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KG4yk-0000id-00; Tue, 08 Jul 2008 05:39:02 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0807071349u7c35d2fcr5025b2b282f290f6@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87708>

On 2008-07-07 21:49:31 +0100, Catalin Marinas wrote:

> 2008/7/4 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > It prints error messages when it fails, and we don't need to see
> > them since we don't care exactly _why_ it failed.
>
> Are you sure we don't need this? I found it useful when running
> "import" to see why a patch failed.

Aww, you're right. Apply isn't just called from the simple merge fast
path, it's also used to apply patches. Who would've guessed? ;-)

I'll add a parameter to shut it up or not depending on the caller's
preferences.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
