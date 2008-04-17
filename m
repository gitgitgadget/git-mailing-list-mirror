From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: Man pages lack of exit status information
Date: Thu, 17 Apr 2008 10:38:44 +0200
Message-ID: <38b2ab8a0804170138u717fb753me45ead12720c9e3d@mail.gmail.com>
References: <38b2ab8a0804170045xa542274pa9f1e434f428b1cd@mail.gmail.com>
	 <BE732D9B-D2C2-4578-BC9D-52473C37EA74@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 10:39:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmPeU-0005lD-MH
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 10:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755650AbYDQIip convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 04:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755604AbYDQIip
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 04:38:45 -0400
Received: from rv-out-0708.google.com ([209.85.198.247]:28792 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755222AbYDQIio convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2008 04:38:44 -0400
Received: by rv-out-0506.google.com with SMTP id k29so1342779rvb.1
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oy6nyx/silD7RPKqVgDkdVgWaUaUwjAA7ou2CZEexf0=;
        b=FH18RrLbVvhGtbBY8j/oqt/kK7SOVkNpjq0kddb8TFra7b/fv+7nqGcCqQ9F9vZmwRCUtDDlXo6SovXA5dVKPDn76TUcumXcEyOXML+iRi9557VEDDJoFv0pG5APWgrSB3eUOAA35xytdlbDYIyslKzTu3cJ1qDiwPC1VVzUeEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=elMbdBv6nU4m68Zy1zx3ocLqRXlPFcQf6BXT9FpmHn55X8AwU0LH7eUUOOlwlTh2NCav2Eg0Wy2I8/Q5fB3GeEuyuZdP/sLAve/6gFEuBQUQLWiU/h9eb3rD4e9OrWaoiDInRijPMpxQLwYu1ctY4bYYrLd9P8T6F03xedGFRCg=
Received: by 10.141.171.6 with SMTP id y6mr577379rvo.174.1208421524026;
        Thu, 17 Apr 2008 01:38:44 -0700 (PDT)
Received: by 10.140.135.21 with HTTP; Thu, 17 Apr 2008 01:38:43 -0700 (PDT)
In-Reply-To: <BE732D9B-D2C2-4578-BC9D-52473C37EA74@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79775>

On Thu, Apr 17, 2008 at 10:17 AM, Wincent Colaiuta <win@wincent.com> wr=
ote:
> El 17/4/2008, a las 9:45, Francis Moreau escribi=F3:
> > I checked on a couple of git commands' man pages and I couldn't fin=
d
> > the exit status of these commands.
> >
> > For example: git-status, git-diff man pages don't tell anything.
> >
> > Am I missing something ?
> >
>
>  The "git-diff" man page documents this under the --exit-code option.=
 It
> probably would be nice to have an "EXIT STATUS" section added to the =
man
> pages of those commands for which it would be interesting (like "git-=
diff")
> and perhaps to the main "git" man page as well (with general info).
>
>  If there is interest in this I'll whip up a doc patch.
>

I think it makes sense to have such section specially since git plumbin=
gs are
also designed to be used in higher level scripts.

I really use to searching for RETURN VALUE section in man pages when I =
need
what a command returns. And it's a pain to have to read the whole man p=
age for
finding such important information.

Thanks
--=20
=46rancis
