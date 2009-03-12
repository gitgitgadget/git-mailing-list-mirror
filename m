From: John Tapsell <johnflux@gmail.com>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 14:14:51 +0000
Message-ID: <43d8ce650903120714g782b98e8t81340546547fe98d@mail.gmail.com>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com>
	 <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de>
	 <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com>
	 <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302>
	 <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com>
	 <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 15:17:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhlhy-0007XO-4j
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 15:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452AbZCLOOz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 10:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755355AbZCLOOz
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 10:14:55 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:1921 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbZCLOOy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 10:14:54 -0400
Received: by yx-out-2324.google.com with SMTP id 8so491033yxm.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=u4xWTtIgu0uZiualJrvTUy4WehjmPXE2zjw/lhOyTZE=;
        b=HudC0Ty5O/7oSNXNyIvGFHKgkUFfdEJAWdqvTJHI1JrCwpEHgD7Z1BEaITqg0abIeo
         B8Cc2UwDXqceSPdyBAwYcNIOu9pcP0Yplzyq47GPan3BKRD9EVKhPWz7czqKP5Sflsmj
         frhFDvEM9by89ISMM7IH5+qU+U0zqmWvcWMW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SmTQ93ariOQoGoHXsaCllshp9ZKhVwHHXJq2qk5BexEAJViNDyF78u4R9zJEOc0S+P
         EAGrheBrn6M5obEZc7oRIuZb0ms0y5YSYBeDilwBTCEgJXe4QPT/d4Okb02qgD/spuyL
         FJ16OWL7hrChXZUQU08BYBQe9qhvDCmtf/d0U=
Received: by 10.142.234.16 with SMTP id g16mr4310775wfh.264.1236867291883; 
	Thu, 12 Mar 2009 07:14:51 -0700 (PDT)
In-Reply-To: <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113071>

2009/3/12 Sverre Rabbelier <srabbelier@gmail.com>:
> Heya,
>
> On Thu, Mar 12, 2009 at 14:18, John Tapsell <johnflux@gmail.com> wrot=
e:
>> Is probably a mistake by the user. =C2=A0We should warn the user and=
 point
>> them in the right direction.
>
> The point is that we _already_ warned the user (like Dscho pointed
> out), and that(as you pointed out), it didn't work :P.

Just doing:

git branch -b origin/master origin/master

gives no error or warning at all.

John

>
> --
> Cheers,
>
> Sverre Rabbelier
>
