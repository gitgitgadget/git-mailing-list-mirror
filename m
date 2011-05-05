From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.5.1
Date: Thu, 5 May 2011 19:40:40 +0200
Message-ID: <BANLkTi=7=gnirqkV=ygf_FOytdAT3L0iNA@mail.gmail.com>
References: <7vfwouc4jx.fsf@alter.siamese.dyndns.org>
	<BANLkTikV0-efkU+V90i=hPkMLYXi2Puw4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 19:41:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI2Xw-00071B-HD
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 19:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536Ab1EERkp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 13:40:45 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51861 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422Ab1EERkl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 13:40:41 -0400
Received: by vxi39 with SMTP id 39so2503839vxi.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 10:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZN0b38B7awGN73u8w9fQFQiHMe9FLRmZFyyqg9taw1s=;
        b=DxBq/mPSrCrY8YiqQab9ANTWIBTo561UXOQ4RRU3Mul0H5GHRxajRYGnLHKB3FCbyG
         LrroFZiYmSxNJ9f9IxZ2cTpai9fHtWYBAeqMbMPlUDGtjq6CAZ8FnOLI0dtQDXlk6fP8
         g8yTHhJferWcsKt3zNwMDvufk0uz5GQl9UlcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sPhvZAxGn6pR3eRg3JQycBZmKfUOMatw42Y0Q0fVDuA/NAD1AAJQRadCAzl2JUVi5a
         NLHY3ROFTZHIAPp8Tx6msx9qeeGdIqIzeNBcVMw+6RTaataoO/DPZ5iLI2tE5d3L2KQn
         02PAJ2eN4cEE789VewnKxViUQiBDSszrmyOEY=
Received: by 10.220.20.81 with SMTP id e17mr649570vcb.85.1304617240217; Thu,
 05 May 2011 10:40:40 -0700 (PDT)
Received: by 10.220.201.135 with HTTP; Thu, 5 May 2011 10:40:40 -0700 (PDT)
In-Reply-To: <BANLkTikV0-efkU+V90i=hPkMLYXi2Puw4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172858>

On Thu, May 5, 2011 at 1:13 PM, Sverre Rabbelier <srabbelier@gmail.com>=
 wrote:
> Heya,
>
> On Thu, May 5, 2011 at 03:35, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> =A0* "git stash apply" used to refuse to work if there was any chang=
e in
>> =A0 the working tree, even when the change did not overlap with the =
change
>> =A0 the stash recorded.
>
> Does this mean that I won't get the "you have unstaged changes, pleas=
e
> add them" message anymore for the non-overlapping case? If so, nice!

I think this also partially fixes problem with git-svn and concurrency =
described
here: http://article.gmane.org/gmane.comp.version-control.git/171481

git-svn now works correctly if during dcommit someone else made a chang=
e to
svn repository but the change did not touch dcommited file.

It still stops and looses history if change was in the same file.

Thanks,

--=20
Piotr Krukowiecki
