From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 21:43:24 +0100
Message-ID: <3f4fd2640908171343s6e2796a8le0455e02fd8386d9@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
	 <4A899495.8050902@gnu.org>
	 <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>
	 <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 22:43:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md93H-00019B-P4
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 22:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbZHQUnY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 16:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbZHQUnY
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 16:43:24 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:51382 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbZHQUnX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 16:43:23 -0400
Received: by vws2 with SMTP id 2so2696864vws.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 13:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IM7kOLZMUKXDUD7Et0TN+edaah/qphJQASenAHx/Ge8=;
        b=xwB+IsQdIJ48FhsLNCF5gk8VjLGQaFAM8/6La47MMj1KzmE82ituCXw9RVY7D6Y1aw
         FiFfpiPdvsC6HclxsZuCH2IBLe/MAe6qJJu4W7G/I8eC8ElbBZQYYKlUTPKF/v21h7ZF
         cgZUZSqXF7fgjK7gTJppFunmJGQTVJmzobbWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KqBILpbhUNGZAxHhc9va2DukUuvRSOhSv3tPRAEhMxOccZ4U7w3l6N3mpqmGJtqBqP
         ytcAxqVnZ9ghpJy34lpjtCCGOyUHEo0tsil+7Pv01QTiiCv74/WiMBzWwxv2tpuscVu/
         vyodVMyF7kBDbUMjEEzxILtZCknadaG3cxEkQ=
Received: by 10.220.127.196 with SMTP id h4mr5444529vcs.32.1250541804389; Mon, 
	17 Aug 2009 13:43:24 -0700 (PDT)
In-Reply-To: <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126275>

2009/8/17 Pau Garcia i Quiles <pgquiles@elpauer.org>:
> On Mon, Aug 17, 2009 at 9:53 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>
>> Of course, we could have a script that verifies that the .vcproj fil=
es
>> contain reference the appropriate files (which it would know about b=
y
>> being called from the Makefile and being passed the file names), may=
be
>> even be able to edit the .vcproj file if it is missing some. =A0Shou=
ld not
>> be too hard in Perl.
>
> You'll need to special-case for Visual C++ 2010, which is different
> and incompatible with previous versions. Hence my suggestion for
> CMake: appropriate project files would be generated for the tool the
> user chooses, be it VC++ 2005, VC++2010, gcc, Borland C++ or anything
> else.

The problem is that you'd still need the Visual Studio projects (one
each for 6, 7 (2002), 7.1 (2003), 8 (2005), 9 (2008) and 10 (2010) --
yes, there'll need to be one for each version of Visual Studio) as
people who use Visual Studio tend to primarily use the IDE. CMake
(which Windows users will need to download & install from somewhere)
will sit outside this -- unless you mean making the project files be
the "Makefile project" type and simply use it to invoke CMake and host
the source files to ease access to them from the IDE?

Also, not every posix system will have CMake installed (e.g. Linux
=46rom Scratch systems) and that's not including "exotic" systems like
Solaris and the *BSDs.

- Reece
