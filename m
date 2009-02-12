From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: gitk and tags
Date: Thu, 12 Feb 2009 18:41:59 +0100
Message-ID: <adf1fd3d0902120941r6c0be562r27a67e978c7cddd7@mail.gmail.com>
References: <OF13533D2E.931134C6-ONC125755B.005E1480-C125755B.005EAB59@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Thu Feb 12 18:43:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXfb1-00040h-VT
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 18:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758086AbZBLRmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 12:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757966AbZBLRmE
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 12:42:04 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:33844 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757913AbZBLRmC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 12:42:02 -0500
Received: by fxm13 with SMTP id 13so2381034fxm.13
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 09:42:00 -0800 (PST)
Received: by 10.102.228.10 with SMTP id a10mr521470muh.26.1234460519908; Thu, 
	12 Feb 2009 09:41:59 -0800 (PST)
In-Reply-To: <OF13533D2E.931134C6-ONC125755B.005E1480-C125755B.005EAB59@transmode.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109634>

2009/2/12 Joakim Tjernlund <Joakim.Tjernlund@transmode.se>:
> Is there any way to make gitk display tags when specifying a path?
> example: gitk drivers/usb/gadget
> will show me all commits that touches this directory but I can't make gitk
> show
> me where the tags are so I can see which commits made it into what
> release.

With a recent git you can say:

gitk --simplify-by-decoration drivers/usb/gadget

it will show the commits modifying the file and with a ref (tag or branch).

With the command line you can use:

git tag --contains <commit> # only in git v1.6.2-rc0

it lists all the tags that contain the given commit,

or

git describe --contains <commit>

that tells which is the nearer tag that contains the given commit.

HTH,
Santi
