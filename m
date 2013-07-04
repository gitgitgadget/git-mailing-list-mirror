From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: allow extra breadcrumbs to prefix the trail
Date: Thu, 4 Jul 2013 19:31:06 +0200
Message-ID: <CANQwDwffPANC-Kb-8sk=UH3EGkG=ON8-TiMRNNS5c5r+rKsW+Q@mail.gmail.com>
References: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk> <20130703215930.GT408@google.com>
 <CANQwDwcneUzzXS-Du-3Aca3-Vp8ycSzVqUv1rVRVhaNUWfeokw@mail.gmail.com>
 <alpine.LSU.2.00.1307040940400.26246@hermes-2.csi.cam.ac.uk>
 <CANQwDwd9siyeu5xqS5Un+=8ioEaDbpT30vBpgJCVNUEcszcv1g@mail.gmail.com>
 <alpine.LSU.2.00.1307041559140.26246@hermes-2.csi.cam.ac.uk>
 <CANQwDwfCYPBjGfmKOLju-Zey4WrVrXfaymJtu9g1OYvOUfBTcw@mail.gmail.com>
 <alpine.LSU.2.00.1307041646250.26246@hermes-2.csi.cam.ac.uk>
 <CANQwDwfNrqZvLNYS6kqZdgX-ab5fK3RmQqAN3qKTW2TGnaDaUg@mail.gmail.com> <alpine.LSU.2.00.1307041752030.26246@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu Jul 04 19:31:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UunNU-0006UO-ET
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 19:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662Ab3GDRb2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 13:31:28 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:44453 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756593Ab3GDRb1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jul 2013 13:31:27 -0400
Received: by mail-qa0-f47.google.com with SMTP id i13so4355268qae.13
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ElzUbeQAkcKRhd8B86bCEUsFqkOmJ5x9suTuBh6WLdc=;
        b=koVwQ17Pl0RxswsWFI1Aq4dTTobyxyx1f7CbmYDP1E7MMzla6TMB8p4Zo35q+5QhJ/
         XQJenM66zfuwNeIzw2/9CKKM4E5voiGYxNvFtQenttad3K2+Dh/x8Mxb2sosyJ/SoDa7
         QtxTVvF5gcdV1W8oIpfT3hRuoe1Y8w0Vw3MsSfnFM28xuhyvbAk3J0w08S5hNN47kGUd
         VEPc14f8QdzgZdwqJVvJAygR68aNUB5xJEXtHq5bhmD08FpXCddBIw/VliZez4QbG5Xm
         W5Qq4DbxHeMfGsd2jEPvFqzxhAdkCwja/g7b0UU/6svUTMpmy/6XfBFSmz22GVVsx/SD
         Ix/A==
X-Received: by 10.49.132.41 with SMTP id or9mr5306797qeb.18.1372959087041;
 Thu, 04 Jul 2013 10:31:27 -0700 (PDT)
Received: by 10.49.75.169 with HTTP; Thu, 4 Jul 2013 10:31:06 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.00.1307041752030.26246@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229601>

On Thu, Jul 4, 2013 at 7:08 PM, Tony Finch <dot@dotat.at> wrote:
> Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
>>
>> In what situation do you need those extra breadcrumbs useful? What
>> necessity / itch to scratch is behind idea of this patch?
>
> For an example, see https://git.csx.cam.ac.uk/x/ucs/git/git.git
>
> I have three items in @extra_breadcrumbs which point to the Universit=
y
> home page, my department home page, and my git server's home page; th=
ere
> are a number of gitolite accounts on the server each of which has a
> project listing which is where gitweb's home link points.

Of course those @external_breadcrumbs are really useful iff they are
repeated consistently in at least similar form in all those external pa=
ges...

> (I expect to change the link texts to make it less confusing when you
> happen to be looking at my department's account on the git server...)
--=20
Jakub Narebski
