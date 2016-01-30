From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v3 2/6] path.c: new (identical) list for worktree v1
Date: Sat, 30 Jan 2016 16:45:17 +0200
Message-ID: <20160130144517.GC4978@wheezy.local>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	max@max630.net, git@drmicha.warpmail.net, Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 15:45:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPWmI-0000Xi-9M
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 15:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083AbcA3OpY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2016 09:45:24 -0500
Received: from p3plsmtpa07-08.prod.phx3.secureserver.net ([173.201.192.237]:58721
	"EHLO p3plsmtpa07-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757075AbcA3OpW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2016 09:45:22 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-08.prod.phx3.secureserver.net with 
	id CElH1s00J5B68XE01ElLaA; Sat, 30 Jan 2016 07:45:22 -0700
Content-Disposition: inline
In-Reply-To: <1453808685-21235-3-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285116>

On Tue, Jan 26, 2016 at 06:44:41PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> Worktree v1 may have different .git file split than v0. Add support
> code to change common file list based on extensions.worktree. The lis=
t
> for now is identical to v0.

In the end this turned out to be needed only for "common"
which is not strictly necessary, as Junio pointed out, and
anyway could be done for v0 as well because "common" is not
used to be used before. So probably it is not needed at all.
