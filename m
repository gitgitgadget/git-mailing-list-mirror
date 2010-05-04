From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] diff: add a 'path' meta header for non-renames and 
	non-copies
Date: Tue, 4 May 2010 21:30:53 +0200
Message-ID: <AANLkTilsk7Hh0oN72SfOlRK92qQhjVa-rNYUtVHocEj0@mail.gmail.com>
References: <1272852221-14927-1-git-send-email-eli@cloudera.com>
	 <1272868072-12120-1-git-send-email-bert.wesarg@googlemail.com>
	 <7viq75tpaw.fsf@alter.siamese.dyndns.org>
	 <z2m36ca99e91005030037jb880e65w73efa551a53d7be6@mail.gmail.com>
	 <7v1vdtt0d7.fsf@alter.siamese.dyndns.org>
	 <m2i36ca99e91005031555x4bb2df54yb47058d9f7d5342c@mail.gmail.com>
	 <7v8w80sb5b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eli Collins <eli@cloudera.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 04 21:36:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9NvE-0005Ft-Df
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 21:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786Ab0EDTgc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 15:36:32 -0400
Received: from mail-iw0-f203.google.com ([209.85.223.203]:53255 "EHLO
	mail-iw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab0EDTgb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 15:36:31 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 May 2010 15:36:31 EDT
Received: by iwn41 with SMTP id 41so5129426iwn.20
        for <git@vger.kernel.org>; Tue, 04 May 2010 12:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=//d/H2gUeK0t74uwOAU69XJbuCwOAxUvsBJXzM/Edw0=;
        b=sydkmXrn0wjxryqcumKk1+zvYgqxF5JY3SpBiTCJgSX2uqq6+4WLaEsg43UL2g8icN
         yQE62MXNjOM/7vF2ud7cuj3Y7ZKAmluGprrHrwY7iv59CT8dMsiK17YtaTJt98KiA/am
         kfwDEuQBmORgsot3A2Q+Y9QKJCOm515FZnoac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lz6yZePloJo4tIhsz+J23Ck7/vT1725tsncHw8w3SeQCQzOsWvGAUX9fMe9VN/Pc/H
         kuQ4p8nEBotBo3Ws2J+paKAoaAOEP8lZ9U1b6oh4rlPPSvUyY2f0KxIl71mawyMuoWOR
         DEIQVtHH3IgujIhfcYkP9fXPk90Ol8aoqqHfs=
Received: by 10.231.183.133 with SMTP id cg5mr2738999ibb.12.1273001453261; 
	Tue, 04 May 2010 12:30:53 -0700 (PDT)
Received: by 10.231.39.205 with HTTP; Tue, 4 May 2010 12:30:53 -0700 (PDT)
In-Reply-To: <7v8w80sb5b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146337>

On Tue, May 4, 2010 at 03:34, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> ... do you have any other
>> thoughts on adding a <path> extended header for non-renames and
>> non-copies?
>
> Other than "Why do we even need it?", no. =C2=A0We actually have been=
 careful
> when designing the output format to make sure that necessary informat=
ion
> appears.
>
> See also this thread:
>
> =C2=A0 =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/3=
990/focus=3D4002
>
> I wasn't too opposed to having a separate "Index: " line (or Anton's
> "name") like CVS does, but the conclusion of the thread was that it i=
s not
> necessary.
>

Thanks for the pointer. The discussion revolves around technical
arguments and the conclusion that this extra information is not
necessary is reasonable. My intention for this information comes only
from the usability and convenience side: I want a path without any
prefix which I can select in the terminal and use this to open the
file. Thats why it is only an option for the UI interface.

Bert
