From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git-add -u: match the index with working tree.
Date: Fri, 20 Apr 2007 12:49:30 +0200
Message-ID: <20070420104930.GB13560@diana.vm.bytemark.co.uk>
References: <11770585393395-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 12:49:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeqgL-0000rr-2t
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 12:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767058AbXDTKte convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 Apr 2007 06:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767059AbXDTKte
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 06:49:34 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3294 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767058AbXDTKtd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 06:49:33 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HeqgE-0003nX-00; Fri, 20 Apr 2007 11:49:30 +0100
Content-Disposition: inline
In-Reply-To: <11770585393395-git-send-email-junkio@cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45083>

On 2007-04-20 01:42:18 -0700, Junio C Hamano wrote:

> This is a shorthand of what "git commit -a" does in preparation
> for making a commit,
[snip]
> -"git-add [-n] [-v] [-f] [--interactive | -i] [--] <filepattern>...";
> +"git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--] <filepattern>=
=2E..";

Any particular reason for choosing a different letter than the
-a/--all that git commit uses?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
