From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 3/4] Teach new infrastructure to diff two trees
Date: Tue, 29 Jan 2008 16:57:56 +0100
Message-ID: <20080129155756.GA10546@diana.vm.bytemark.co.uk>
References: <20080129031310.1177.83290.stgit@yoghurt> <20080129031558.1177.80102.stgit@yoghurt> <87y7a8k83s.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Jan 29 16:59:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJsrC-00016P-Vm
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 16:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764342AbYA2P6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2008 10:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764407AbYA2P6E
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 10:58:04 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4302 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764342AbYA2P6B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 10:58:01 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JJsqS-00036D-00; Tue, 29 Jan 2008 15:57:56 +0000
Content-Disposition: inline
In-Reply-To: <87y7a8k83s.fsf@lysator.liu.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71981>

On 2008-01-29 15:40:55 +0100, David K=E5gedal wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:

> > +from stgit.config import config
>
> But "config" isn't used in this patch.

You're right, it's not. It's actually used in patch 1/4, but because
that code is never called until patch 4/4, the interpreter didn't
catch the error.

Thanks, will fix.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
