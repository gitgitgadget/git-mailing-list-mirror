From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2009, #05; Sun, 22)
Date: Mon, 23 Nov 2009 07:24:31 +0100
Message-ID: <fabb9a1e0911222224m52164a45y9827f788aecb4fc5@mail.gmail.com>
References: <7vhbsl935q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 23 07:25:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCSMB-0001vd-PO
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 07:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbZKWGYr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 01:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbZKWGYq
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 01:24:46 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:43871 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbZKWGYq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 01:24:46 -0500
Received: by ewy19 with SMTP id 19so1511122ewy.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 22:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=rFoZcwzGoqlNYcx9rUtgF4LdkkuD9yFHAfW4uSE8FL0=;
        b=wzzLT2ifR+sKt8jdlNTf/WNmWHbUzTnXIgIDnN+w29YeYiWw4CoNqVRa3Kk20rjTSq
         eTim07AJ+JGEvk/wi10agKWwTDZ6bYeYMQ1sKsAcR7bMinBhBgWFgWEBUtXmFPikWHXm
         asyq00toszavWCc8tNE1OFyxjI7i+kUrE7nbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=sIelx8q78YY1atrrkMjno6Ay/2BAMb/pgblHWFtt/avrOB1avhpexw5mkcN1WkZhZU
         qmayafr+1ozVdUiPMt/jhwFxUn2JVX/jBdB5yt71YxUz1gtx6tIx4dOMSBUfVJ5GZA4/
         atKscQ758aJP+Xs7iA9+USsoWajgVmHwjdJbQ=
Received: by 10.216.86.200 with SMTP id w50mr1315352wee.173.1258957491112; 
	Sun, 22 Nov 2009 22:24:51 -0800 (PST)
In-Reply-To: <7vhbsl935q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133485>

Heya,

On Mon, Nov 23, 2009 at 07:16, Junio C Hamano <gitster@pobox.com> wrote=
:
> * sr/gfi-options (2009-09-06) 6 commits.
> =A0- fast-import: test the new option command
> =A0- fast-import: add option command
> =A0- fast-import: test the new feature command
> =A0- fast-import: add feature command
> =A0- fast-import: put marks reading in it's own function
> =A0- fast-import: put option parsing code in separate functions
>
> It seemed to be moving again soon, but nothing has happened yet...

To those following this series, I've done a reroll addressing Shawn's
comments, but am holding back on sending it out since I want to add
the import-marks and export-marks features as well (which were the
sole reason for this series in the first place, to me at least). It
should not be much work, but I have to redo the test cases as well, so
it will take a little while longer to finish.

--=20
Cheers,

Sverre Rabbelier
