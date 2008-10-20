From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Archiving tags/branches?
Date: Mon, 20 Oct 2008 07:35:46 -0700 (PDT)
Message-ID: <m3prlvibb7.fsf@localhost.localdomain>
References: <48F93F52.4070506@pcharlan.com>
	<200810181315.49265.johan@herland.net> <20081018130204.GB3749@neumann>
	<200810181532.59883.johan@herland.net> <48FC26DA.10508@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"SZEDER Gabor" <szeder@ira.uka.de>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 22:34:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrvsU-0007L1-JN
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 16:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbYJTOfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 10:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbYJTOfu
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 10:35:50 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:11677 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbYJTOft (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 10:35:49 -0400
Received: by ik-out-1112.google.com with SMTP id c30so1176413ika.5
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :user-agent:message-id:lines:mime-version:content-type:date;
        bh=lbfynOsjjiSsG4/pX88BSUCMyOGwdtoGHMXTNAeIwk0=;
        b=C3t5YS1KoLeyWy6w+iNYVDoTnOUzQ4rzd8Iuw5Mi4t5ClmPq+rMBN77F5eMKdUXrl3
         tdU0RXOPbvAV8HJ4PcWKf2DRP6onArgmGNACWTvUME4cb7FRBUQIwPcuTCf/eBR2RQek
         EbbZuTGuJ9yc/OG3A0ZCuCkX6CviOvuPfBWsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :user-agent:message-id:lines:mime-version:content-type:date;
        b=Izyj29breNzmG0PgNlkmM2Hb3rZ+6WmkvJTM/TGgpjFGmk4CoKKSOKmNhtBFp2QM9D
         Mxze4oBUY0WIfa+6ml4q2wk7HJfYlqw37HhLv3CS3oQn1+cGAR1zRSV30jHoOByozzuV
         ESOZ62HjMwptpkOTv/S6S3kJ33LfE+5HwMRVA=
Received: by 10.210.90.8 with SMTP id n8mr2240436ebb.67.1224513347326;
        Mon, 20 Oct 2008 07:35:47 -0700 (PDT)
Received: from localhost.localdomain (abwi157.neoplus.adsl.tpnet.pl [83.8.232.157])
        by mx.google.com with ESMTPS id 7sm10164770eyb.1.2008.10.20.07.35.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Oct 2008 07:35:46 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9KEZhv7027205;
	Mon, 20 Oct 2008 16:35:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9KEZetW027201;
	Mon, 20 Oct 2008 16:35:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <48FC26DA.10508@pcharlan.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98702>

Pete Harlan <pgit@pcharlan.com> writes:

> Johan Herland wrote:

> > BTW, the best way IMHO to archive old refs is to clone your repo
> > (with all tags/branches) to a backup disk, and then regularly push
> > (git push --all && git push --tags) your new tags/branches to this
> > backup. You are now free to delete these tags/branches from your
> > work repo (they will not be deleted from the backup unless you use
> > "git push --mirror"). And if you ever need to retrieve an old
> > tag/branch, it's just a matter of pulling it from the backup
> > repo. Nice, clean, flexible, and requires no changes to git.
> 
> Thank you; that indeed seems to work and solves the problem of managing
> refs/archived-tags manually.
> 
> Using a secondary repo solely to overcome a flat tag/branch namespace
> feels hackish.  Perhaps git will benefit someday from work in this area,
> but until I come up with a patch your suggestion should work fine.  Just
> knowing I didn't overlook an existing feature helps a lot.

I don't quite understand what you mean by _flat_ namespace for tags
and branches.

First, it is not unusual to have hierarchical branch names, at least
for short-term topic branches. For example in git.git history (and in
"What's cooking..." announcements on git mailing list) you can find
branch names such as rs/alloc-ref, nd/narrow, tr/workflow-doc.
Additionally remote-tracking branch names have inherently hierarchical
names: refs/remotes/<remote>/<remote branch>.  While tag names usually
are of the type x.y.z, it is not mandated by some technological
limitation.

Second, you can always put your archived refs in another namespace,
beside 'heads', 'tags', and 'remotes'. I for example use
refs/tags/Attic for lightweigth tags to some interesting abandoned
experiments, but it could have been refs/deleted/tags, or
refs/Attic/tags.

Last, please remember that there exists something like packed refs
format (see git-pack-refs(1)... oops, it dies not describe
.git/packed-refs format, unfortunately).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
