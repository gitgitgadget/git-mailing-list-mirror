From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: gitk patch display corner-case bug
Date: Sun, 19 Feb 2006 15:38:57 +0100
Message-ID: <20060219143857.GA5268@diana.vm.bytemark.co.uk>
References: <20060218233618.GA29025@diana.vm.bytemark.co.uk> <17400.20764.131417.903578@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 15:39:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FApiJ-0003Sj-FQ
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 15:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWBSOi7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 19 Feb 2006 09:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWBSOi7
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 09:38:59 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:55048 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932569AbWBSOi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 09:38:58 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FApiD-0001Pc-00; Sun, 19 Feb 2006 14:38:57 +0000
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17400.20764.131417.903578@cargo.ozlabs.ibm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16438>

On 2006-02-19 22:06:04 +1100, Paul Mackerras wrote:

> Karl Hasselstr=F6m writes:
>
> > Totally correct except that it omitted the line consisting of only
> > three dashes.
>
> Could you check that the missing line is present in the output from
> git-rev-list --header --parents --topo-order please?

I'm not sure I follow you. The affected commit is listed first by
"git-rev-list --header --parents --topo-order 51cb39db", but that
commad doesn't show diffs, so the missing line is not there.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
