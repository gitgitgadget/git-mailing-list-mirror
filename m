From: Scott Chacon <schacon@gmail.com>
Subject: Re: SVN support at GitHub (was Re: Does recent 'smart' HTTP feature 
	help git-svn thru unfriendly corp. firewalls too?)
Date: Wed, 5 May 2010 08:08:21 -0700
Message-ID: <w2md411cc4a1005050808q96802cfavbfd8ace700de1773@mail.gmail.com>
References: <t2td43c95441005050710rb5123219v9ca23aebc01e40ad@mail.gmail.com>
	 <20100505141636.GG11053@spearce.org>
	 <i2yd43c95441005050720rccceadcex88a2ce6730d96a5d@mail.gmail.com>
	 <i2ld411cc4a1005050732nf1e4a91fv6c25142936f7aef6@mail.gmail.com>
	 <vpqaaseqty8.fsf_-_@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Norman <mwnorman@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 05 17:08:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9gDC-0007RB-C3
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 17:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760397Ab0EEPIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 11:08:25 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:62045 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760047Ab0EEPIY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 11:08:24 -0400
Received: by wwd20 with SMTP id 20so521919wwd.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 08:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=qxCVJRbu3w6gV3xJpVhHZYNfr290+1a1knTVkD5nZpk=;
        b=DGl22nuXfiwVAtEAOVOPDhX/NLko8RCnmIjYicdWfDuLKtqQWcoOQGz1VC2PXLO5SX
         99CQTPXU85VNFE0Nt/Z6chPkHAuTBs2jxRX8/W4TVuJ4okyjBJztpx0HZamsXhjHK0z0
         ThVNtBP23MupK/67buSChmk6BVS2MOXn/r4ig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=INWnN7+mmmsW0xjGi/Mj7fb/jH/Zd4vq5UYi/cy8b/mz2UQh8qc7Kqyf2p7Ot/l862
         q42Em7qzmC20oqLY7Hlqp80W78ww1hHpRpN0kiDx7pERWos+Lga0bpnLJyOujOzawR13
         XTTjMnbwc25h0VPe8LP8Hlvc1KKzQmWqs0+/Y=
Received: by 10.216.86.3 with SMTP id v3mr6248261wee.190.1273072101207; Wed, 
	05 May 2010 08:08:21 -0700 (PDT)
Received: by 10.216.3.13 with HTTP; Wed, 5 May 2010 08:08:21 -0700 (PDT)
In-Reply-To: <vpqaaseqty8.fsf_-_@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146405>

Hey,

On Wed, May 5, 2010 at 7:55 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Scott Chacon <schacon@gmail.com> writes:
>
>> You can use GitHub for native SVN and Git access, both over http -
>> that will allow you to use Git as the main repository as it should be.
>> :)
>
> Wow, that's neat!
>
> Is it a private GitHub thing, or some open source code that other
> people can install on their own server?
>

Right now our version is very tied to our weird infrastructure, and
thus would not be generally useful, but I would like to fix and open
source it someday.  Currently it's not much different than the HeeChee
project, however, which does largely the same thing, but for both Hg
and Git.  If you're interested, I would check that out:

http://bitbucket.org/andrewgodwin/heechee/

Scott


> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>
