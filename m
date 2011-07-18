From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git-ftp: retry, sftp support
Date: Mon, 18 Jul 2011 06:51:33 -0400
Message-ID: <CACPiFCJHx7Nb2N+FfL6Cu4ULEqwhJxY4-GUNWLA2ds8zL8WfwA@mail.gmail.com>
References: <CACPiFCL22yr096_nNfjvfP_bkJRC7HA65GUF12wedzV=cz-_kg@mail.gmail.com>
 <m3vcv0yqb4.fsf@localhost.localdomain> <CACPiFCK4B96cTAz8JEBMOpktZG2R5HsYA2YgEdRuqO55XTOVcg@mail.gmail.com>
 <138AFDD9-CE91-4019-BAF3-B6F301D4225E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?ISO-8859-1?Q?Ren=E9_Moser?= <mail@renemoser.net>,
	Git Mailing List <git@vger.kernel.org>
To: Timo Besenreuther <timo.besenreuther@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 12:51:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QilQd-0006lL-4f
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 12:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756389Ab1GRKvy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 06:51:54 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54916 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756369Ab1GRKvx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 06:51:53 -0400
Received: by vxh35 with SMTP id 35so1512962vxh.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4fHvmT26PprHA2sVTtHWA1NZq6IEvucSrdG5PmWscrE=;
        b=gV9+tn/6HI4erircrQ8+7bXof19+R+msGelPYXOL8d/ypHKmUnvTVPnEtuFaFrf6Ze
         ZErql3M4vUO9jaLieMOr2zxZCbTZ+qeemhIxTOtOPDsfDDrCx7CHaNF1iMsFGkp127Ri
         i1P8V6iANBIoCp8aHZ4e27EQ+FcNCWUyus+Xc=
Received: by 10.52.108.71 with SMTP id hi7mr6024497vdb.324.1310986313126; Mon,
 18 Jul 2011 03:51:53 -0700 (PDT)
Received: by 10.220.200.132 with HTTP; Mon, 18 Jul 2011 03:51:33 -0700 (PDT)
In-Reply-To: <138AFDD9-CE91-4019-BAF3-B6F301D4225E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177366>

On Mon, Jul 18, 2011 at 4:58 AM, Timo Besenreuther
<timo.besenreuther@gmail.com> wrote:
> git-ftp is a bash tool written by Rene Moser (github resmo) to sync a=
 git repo with an FTP server.
> It is not in git core. I just added some minor improvements. My githu=
b repo is just a fork.

Yup - I know it's not in git core, but I enjoy using it, so wanted to
raise awareness of it, as well of https://github.com/ezyang/git-ftp

Have you seen the patches? Mergeable?



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
