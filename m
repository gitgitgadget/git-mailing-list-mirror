From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/3] Robustify rebase test: check patches are reapplied.
Date: Sun, 10 Jun 2007 10:40:45 +0200
Message-ID: <20070610084045.GA31274@diana.vm.bytemark.co.uk>
References: <20070606215922.18635.38379.stgit@gandelf.nowhere.earth> <20070606220142.18635.3961.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:42:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIzm-0004y6-UU
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762853AbXFJIl6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 10 Jun 2007 04:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762851AbXFJIl5
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:41:57 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3944 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762842AbXFJIl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:41:57 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HxIyb-0008B7-00; Sun, 10 Jun 2007 09:40:45 +0100
Content-Disposition: inline
In-Reply-To: <20070606220142.18635.3961.stgit@gandelf.nowhere.earth>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49680>

On 2007-06-07 00:01:42 +0200, Yann Dirson wrote:

> +	test `stg applied | wc -l` =3D 1

Unimportant note: I believe "stg applied" has a -c (count) flag for
precisely this purpose.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
