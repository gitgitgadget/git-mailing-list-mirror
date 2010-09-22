From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Restore annotated tag?
Date: Wed, 22 Sep 2010 11:39:17 -0700
Message-ID: <20100922183917.GP32601@spearce.org>
References: <AANLkTinafiikD0Lzgw2gw1ti2pCK6cSTk5bQZFcCRJnS@mail.gmail.com> <20100922182353.GO32601@spearce.org> <AANLkTingnVMsRp8+r5-D=c-7mxfaMY1V06YXT2FQzAoL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 22 20:39:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyUE5-00053V-Se
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 20:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637Ab0IVSjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 14:39:21 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55376 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab0IVSjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 14:39:21 -0400
Received: by yxp4 with SMTP id 4so277356yxp.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 11:39:20 -0700 (PDT)
Received: by 10.150.133.17 with SMTP id g17mr1477372ybd.447.1285180760238;
        Wed, 22 Sep 2010 11:39:20 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id h8sm10738341ibk.15.2010.09.22.11.39.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Sep 2010 11:39:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTingnVMsRp8+r5-D=c-7mxfaMY1V06YXT2FQzAoL@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156821>

skillzero@gmail.com wrote:
> 
> One thing I noticed that I wasn't sure about is that I SSH'd into the
> server and ran git update-ref to restore the tag. That created the
> symbolic name in .git/refs/tags/NAME to point to that tag object. But
> what I noticed is that the only file listed in .git/refs/tags is the
> tag I restored. There are other tags in the repository (and a fresh
> clone gets them), but they don't show up in that directory.

The other tags are in the .git/packed-refs file.

> Is it
> going to be a problem that ran git update-ref on the server (which is
> a bare repository) rather than on a clone that I push?

No.

-- 
Shawn.
