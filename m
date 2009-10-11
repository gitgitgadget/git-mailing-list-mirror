From: Eugene Sajine <euguess@gmail.com>
Subject: Re: gitweb - bare repos integration - owner info in description file
Date: Sat, 10 Oct 2009 21:45:06 -0400
Message-ID: <76c5b8580910101845h43a607f0sd4184da302a19963@mail.gmail.com>
References: <76c5b8580910091350o5cd90d3dobe2a21c18fa56dfd@mail.gmail.com>
	 <m3ab00gr25.fsf@localhost.localdomain>
	 <76c5b8580910091532yd6c6fc4ib942a29c827f3a6c@mail.gmail.com>
	 <200910102045.13374.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 03:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwnaX-0005Cu-8d
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 03:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792AbZJKBpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 21:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755798AbZJKBpn
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 21:45:43 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:49109 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605AbZJKBpm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 21:45:42 -0400
Received: by yxe17 with SMTP id 17so1603934yxe.33
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 18:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Wp0QETtxYSkRZjiolPPAAosKVWq5hgIy8HqkLhAnd8w=;
        b=eqayCpeuYxuKeolltSCb0iE5doABozul51OenKkfG9I1+/sNS8NPCdIHRNtgDCxucb
         iMWM86rnPPuKnBlIkM0J+55rlpsD8JJcCjxf4G8DrD0yQuFfk2UrqGSBrl2nLFM7F2ER
         K5qHFB8U1fa1vj33yuGMOMWfBvyUFO6uLXPvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pzwlfhUsDuU51uGTQTA6noKhA4zFg0Kxi7AMPfi86pOttnEixzGD+DnzxYHjBTth3c
         evSF02jXif7cBPgzA92vXJyIq7w4SVyNgDlFtIRC4L0xi8TWcP6dsPckTuNRLeh5+SoV
         ur2RAGIGO4uJOnftC2h5mAmS5ZyNkXFA3ygP0=
Received: by 10.91.28.2 with SMTP id f2mr2579122agj.16.1255225506140; Sat, 10 
	Oct 2009 18:45:06 -0700 (PDT)
In-Reply-To: <200910102045.13374.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129900>

>
> The project description, project owner and (clone) url are used by
> gitweb only, so I don't see why git-clone has to feature-creep to
> set them.
>


Well my logic is simple. Gitweb is a part of git bundle. If you don't
want to use gitweb you're free to use git clone as you want. I don't
see  why not to provide some usability features to it. For me it is
quite obvious that it will be more comfortable to setup gitweb if this
would be in  place. Instead of putting info in few different places
manually, why not to give people a possibilty to do that using one
command?

This is usability feature, but i feel that for me as a person who will
support big ceantral bare repo hosting server, this would save huge
time and efforts...

Thanks,
Eugene
