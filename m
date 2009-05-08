From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Fri, 8 May 2009 16:44:39 -0400
Message-ID: <32541b130905081344m634a78d5l984f4903ec1515eb@mail.gmail.com>
References: <32541b130904291907q4003ad86v4728c5b2ba0aacb7@mail.gmail.com> 
	<32541b130904301559w329bdd4bo6f2736a505b7235f@mail.gmail.com> 
	<20090501142811.GI15420@raven.wolf.lan> <32541b130905011217x7f339d41x696fedee7298e3a4@mail.gmail.com> 
	<20090502215852.GJ15420@raven.wolf.lan> <32541b130905040858v2a0b7a6br5b056a365fcb6855@mail.gmail.com> 
	<20090504211423.GK15420@raven.wolf.lan> <20090506185224.GM15420@raven.wolf.lan> 
	<32541b130905061223h7efddeecvcc52a369093a6b50@mail.gmail.com> 
	<20090506225042.GN15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 22:45:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2WwS-0001z3-0z
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 22:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbZEHUpA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2009 16:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754362AbZEHUpA
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 16:45:00 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:22909 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092AbZEHUo7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 16:44:59 -0400
Received: by yx-out-2324.google.com with SMTP id 3so974734yxj.1
        for <git@vger.kernel.org>; Fri, 08 May 2009 13:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=+xmWvdTWn/o6OdVZeHejfUD9WWm9GWQsMTQR/pkD544=;
        b=u5On2Aks1wYmpjRMBzWt01Bgn60FkicdZupVcK3Zer3W33rzFQuVh3KvHsVHTpNggt
         SUKiBIMbYu1kvuPIAxQgMR9WbTrFYjEoQKzAodsEN4/wZ4sXkIKqtU8LTHGaXxDWjW7M
         A2JKXhJnqu0JdUiZUNSci/eL/U8kox9RhQfQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=h7cSIJYXXNDxe/vGAjjJKbFxm5cQBbBTwrk28ABgK0OxO997z6ZTqhyezCNDzq3990
         S0SuT9ZnNXzL9IE0Kk/vn6bphyjAocnjTE2DOlfit0TnaRv9k7zOfgBxCnIm4MQubn7C
         i/UJTDmpHHY8YsvZGkgBNy4qmOp0T0oTOH2KE=
Received: by 10.151.143.10 with SMTP id v10mr619564ybn.345.1241815499066; Fri, 
	08 May 2009 13:44:59 -0700 (PDT)
In-Reply-To: <20090506225042.GN15420@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118628>

On Wed, May 6, 2009 at 6:50 PM, Josef Wolf <jw@raven.inka.de> wrote:
> The svn histories are about 1250 commits each. =A0The cherry-pickings=
 are
> about 350 commits each. =A0This gives histories running in parallel f=
or
> long distances. =A0Add to this gitk's tendency to change lanes at eve=
ry
> occasion: =A0There's no chance to get multiple screen shots (the inte=
resting
> branch/merge-points, as I described in the thread referenced above) i=
n
> sync. =A0There's many opportunities to get confused. =A0At least for =
me, as a
> newbie to git.

I agree that gitk's lane-changing can be a bit confusing.  Could you
try making a slightly modified version of your script, where you only
cherry-pick one or two commits in each direction?  That should be
functionally identical, but a much simpler diagram.

Avery
