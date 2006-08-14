From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Validation of a commit object?
Date: Mon, 14 Aug 2006 10:39:42 +0200
Message-ID: <81b0412b0608140139l2937669arbef1e303d1c739bb@mail.gmail.com>
References: <20060814062830.GF18667@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 10:39:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCXzA-0000nz-OH
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 10:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbWHNIjo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 04:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbWHNIjo
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 04:39:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:31710 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751956AbWHNIjo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 04:39:44 -0400
Received: by nf-out-0910.google.com with SMTP id a4so1651416nfc
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 01:39:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PBy1/tQBi2t4xq1Lwr5n2PiTgA+S6udVlH3NCGnVWIBuJoJY6ZB+UwqYZf0vLW1Ain+mlbxhVD793DzugCgr0p2b5bzDhRk1qCb7ME2euBQ6Mng2TzGFsHzaJpOgodmVchXdc/bgdMgl8rfJ4QwP5Nd+z/qAutdewr/2lAMxcfc=
Received: by 10.78.140.17 with SMTP id n17mr3156358hud;
        Mon, 14 Aug 2006 01:39:42 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Mon, 14 Aug 2006 01:39:42 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060814062830.GF18667@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25333>

On 8/14/06, Shawn Pearce <spearce@spearce.org> wrote:
> The reason I ask is I'm working on my (bastard) fast-import program
> for Jon's Mozilla CVS -> GIT conversion effort and I'm taking the
> author and committer lines blind from the Python code.  If the
> Python code gives me a bad line its going to go into the pack that
> way, with that possibly resulting in a totally corrupt repository.

Apart from timestamp, which is used in merge base and rev-list
calculations, it does not look like "a totally corrupt repository".
"Slightly corrupt", perhaps - you still can work with it, so long
the blobs, commits and trees make sense.
