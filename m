From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/2] Handle branch names with slashes
Date: Tue, 16 May 2006 09:45:04 +0200
Message-ID: <20060516074504.GA27234@diana.vm.bytemark.co.uk>
References: <20060515105810.GA27077@diana.vm.bytemark.co.uk> <20060516063541.GA11218@backpacker.hemma.treskal.com> <7v64k6ea8r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 16 09:45:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfuFH-0002Wt-8T
	for gcvg-git@gmane.org; Tue, 16 May 2006 09:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWEPHpZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 May 2006 03:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWEPHpZ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 03:45:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:8721 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751657AbWEPHpX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 03:45:23 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FfuEq-0003ON-00; Tue, 16 May 2006 08:45:04 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64k6ea8r.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20110>

On 2006-05-15 23:48:04 -0700, Junio C Hamano wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > I had to change the patch@branch/top command-line syntax to
> > patch@branch%top, in order to get sane parsing. The /top variant
> > is still available for repositories that have no slashy branches;
> > it is disabled as soon as there exists at least one subdirectory
> > of refs/heads. Preferably, this compatibility hack can be killed
> > some time in the future.
>
> I wonder if using double-slashes is an easier alternative to type
> than '%', like "patch@branch//top". That way, you do not have to
> forbid per-cent sign in branch names.

Good argument. And // does look slightly better than %, too. But I'll
wait a few days this time, or else someone will surely come along with
an even better idea. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
