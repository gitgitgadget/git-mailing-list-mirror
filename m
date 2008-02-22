From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/2] Test the 'stg rename' command
Date: Fri, 22 Feb 2008 08:48:54 +0100
Message-ID: <20080222074854.GD6630@diana.vm.bytemark.co.uk>
References: <20080218140005.GA18668@diana.vm.bytemark.co.uk> <200802212243.18922.onno@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Onno Kortmann <onno@gmx.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 08:49:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSSf6-00007F-7a
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 08:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853AbYBVHtD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 02:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbYBVHtB
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 02:49:01 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3866 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbYBVHtA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 02:49:00 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JSSeM-0001sm-00; Fri, 22 Feb 2008 07:48:54 +0000
Content-Disposition: inline
In-Reply-To: <200802212243.18922.onno@gmx.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74702>

On 2008-02-21 22:43:18 +0100, Onno Kortmann wrote:

> +test_expect_success 'Rename with two arguments' '
> +   stg new -m baz
> +   stg rename bar foo
> +'

You want "&&" at the end of every line but the last one, otherwise
errors in any line but the last won't be caught. I'll add that, if you
don't mind.

> +test_expect_success 'Rename to existing name' '
> +   ! stg rename foo baz
> +'

You remembered to use test_expect_success and ! instead of
test_expect_failure -- good!

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
