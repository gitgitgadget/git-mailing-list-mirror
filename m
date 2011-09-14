From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Setting up Git Server
Date: Wed, 14 Sep 2011 10:09:59 +0200
Message-ID: <CAGK7Mr7H7w+wi=BVws91DEN6XhPKcia7Qe_86L-RHDwnP1vBpQ@mail.gmail.com>
References: <CAOZxsTqFfOR+Eb3rqz5hZSJRTe=a1N-CEM--GGGGO2yayT-HLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Joshua Stoutenburg <jehoshua02@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 10:10:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3kYG-0001Rd-2M
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 10:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab1INIKb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 04:10:31 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37902 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab1INIK3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 04:10:29 -0400
Received: by qyk30 with SMTP id 30so3572044qyk.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ArRrCdXLoJ4y3xdhPseUBZlqm2PzJ+YeoHgOHGnutto=;
        b=u7YjkI3Wnez1r8nRZtTMxUcSnT+fZl3U711PV82cvrlOEktX72qdoQlvZHGC4Nb3dz
         rAUC3so6xR0/uH4e3evoIjPpPhXb79ImUAabdzPUrmEhcDbMf4nFTuHi7qMnCa9a8L6m
         X5wF9fQ2tBRq494kxBQZD260n6uNGbXcrqqAk=
Received: by 10.229.247.70 with SMTP id mb6mr4414930qcb.121.1315987829207;
 Wed, 14 Sep 2011 01:10:29 -0700 (PDT)
Received: by 10.229.185.204 with HTTP; Wed, 14 Sep 2011 01:09:59 -0700 (PDT)
In-Reply-To: <CAOZxsTqFfOR+Eb3rqz5hZSJRTe=a1N-CEM--GGGGO2yayT-HLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181344>

> I will want to access the git server over the internet. =A0I want to
> easily control git users, groups, and permissions apart from the linu=
x
> user system, specifying who can access what repositories.

Have a look at gitolite (https://github.com/sitaramc/gitolite).
It's not very hard to setup and then it's pretty easy to work with. It
can also be integrated with stuffs like redmine.

Philippe
