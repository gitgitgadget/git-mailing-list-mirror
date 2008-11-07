From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 1/2] diffcore-rename: support rename cache
Date: Fri, 7 Nov 2008 23:21:28 +0100
Message-ID: <20081107222128.GB4030@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1226068533-10152-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguy???n =?iso-8859-1?Q?Th=E1i?= Ng???c Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 23:23:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZjQ-00040V-Ay
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbYKGWVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2008 17:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbYKGWVv
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:21:51 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:35315 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbYKGWVv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:21:51 -0500
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id CFB62B0149;
	Fri,  7 Nov 2008 23:21:49 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id B7C6CB0146;
	Fri,  7 Nov 2008 23:21:49 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id E110A1F06A; Fri,  7 Nov 2008 23:21:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226068533-10152-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100350>

On Fri, Nov 07, 2008 at 09:35:32PM +0700, Nguy???n Th=E1i Ng???c Duy wr=
ote:
> This patch teaches diffcore_rename() to look into
> $GIT_DIR/rename-cache and make use of it to recreate diff_filepair.
> With proper cache, there should be no available entry for estimation
> after exact matching.

This is something I have thought about in the past, good to see that
implemented :)

> Rename caching is per commit. I don't think abitrary tree-tree cachin=
g
> is worth it.

That could be a nice complement to my directory-rename patch.
