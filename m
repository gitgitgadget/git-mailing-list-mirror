From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v2 0/6] Split .git/config in multiple worktree setup
Date: Tue, 12 Jan 2016 00:43:50 +0200
Message-ID: <20160111224350.GA10955@wheezy.local>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
 <1451186079-6119-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, git@drmicha.warpmail.net, Jens.Lehmann@web.de,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 23:51:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIlJ3-0008Ul-Pr
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 23:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760239AbcAKWvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2016 17:51:16 -0500
Received: from p3plsmtpa07-06.prod.phx3.secureserver.net ([173.201.192.235]:47857
	"EHLO p3plsmtpa07-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759741AbcAKWvC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2016 17:51:02 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jan 2016 17:51:02 EST
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-06.prod.phx3.secureserver.net with 
	id 4mjn1s0015B68XE01mjslj; Mon, 11 Jan 2016 15:43:54 -0700
Content-Disposition: inline
In-Reply-To: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283731>

Hi.

On Sun, Dec 27, 2015 at 10:14:33AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> Upgrade support is manual (for now). When a new worktree is added, we
> can bump from version 0 (i.e. extensions.worktree is missing) to 1.
> But that's it. We can't safely bump 1 to 2 automatically.

Maybe, bumping should happen only if there is no worktree so
far. If there is already, then worktree left to be 0 or
whatever it is. Then it can be bumped directly to the last
supported version.

Otherwise sounds ok. I have checked how it works and did not
read the code carefully, since you it's not ready yet.

--=20
Max
