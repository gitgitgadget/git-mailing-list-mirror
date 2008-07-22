From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Test that we can add a new file to a non-topmost patch with refresh -p
Date: Tue, 22 Jul 2008 09:14:38 +0200
Message-ID: <20080722071438.GA16807@diana.vm.bytemark.co.uk>
References: <20080718084127.GA7042@diana.vm.bytemark.co.uk> <20080718170225.10086.17504.stgit@yoghurt> <20080718180109.GA14825@diana.vm.bytemark.co.uk> <b0943d9e0807211501g68d1cffeh12bcb34df0f28dae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 08:53:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLBkh-0007aU-5R
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 08:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbYGVGwj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jul 2008 02:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbYGVGwj
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 02:52:39 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2429 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbYGVGwi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 02:52:38 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KLC50-0004NT-00; Tue, 22 Jul 2008 08:14:38 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0807211501g68d1cffeh12bcb34df0f28dae@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89449>

On 2008-07-21 23:01:17 +0100, Catalin Marinas wrote:

> I don't think we should spend time on fixing the current code as you
> already have a new implementation. Maybe we could add a simple test
> and refuse refreshing other than the topmost patch in case of files
> added to the index.

Yes, I guess that's OK. Hmm, how do we check that cheaply?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
