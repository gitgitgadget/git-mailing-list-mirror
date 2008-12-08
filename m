From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Use separate column for zero in output of stg series -e.
Date: Mon, 8 Dec 2008 15:11:40 +0100
Message-ID: <20081208141140.GA4813@diana.vm.bytemark.co.uk>
References: <20081208135648.22274.71945.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, git@vger.kernel.org,
	mandolaerik@gmail.com, gustav@virtutech.com
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Dec 08 15:13:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9grW-0004O1-IZ
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 15:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbYLHOMF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2008 09:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbYLHOMD
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 09:12:03 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3941 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbYLHOMD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 09:12:03 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1L9gpo-0001HN-00; Mon, 08 Dec 2008 14:11:40 +0000
Content-Disposition: inline
In-Reply-To: <20081208135648.22274.71945.stgit@krank>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102546>

On 2008-12-08 14:57:32 +0100, David K=E5gedal wrote:

> This will make the output more regular and easier to parse. It no
> longer overwrites the +/-/! status flag with a zero for empty
> patches, and instead puts the zero before it.

Good idea -- I very much doubt there exists any script that will be
broken by the format change, since the current format is icky to
parse. And the implementation looks sane too.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
