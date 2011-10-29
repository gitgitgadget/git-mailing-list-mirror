From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2011, #11; Fri, 28)
Date: Sat, 29 Oct 2011 17:42:36 +0200
Message-ID: <CABPQNSYi7gJKbUb7y2hNvF9KXXyt8ShgJD8AoBhryGwAxp6ejw@mail.gmail.com>
References: <7vzkglrnmc.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 29 17:43:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKB4B-0006dz-Tb
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 17:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933458Ab1J2PnV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Oct 2011 11:43:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36745 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932484Ab1J2PnS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Oct 2011 11:43:18 -0400
Received: by gyb13 with SMTP id 13so4552699gyb.19
        for <git@vger.kernel.org>; Sat, 29 Oct 2011 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=dJExrdlFydZWQ391DzsWElkWfMMSb5cW0Y0dSaRVm5s=;
        b=LPBOvu3A/Z/mdP8DZjgxqSqooJn6CyjV8hqz/E2zdAj546buwgSgpVXgO1UcV3otfW
         rIZB1dGMsv8HIcTdoRzFWZu+qDLf1Xhe8hIGgghi+d8UxDIZHUL8iI5FWBokUUiSy51F
         Yd6Fjb/IkPkgX0eI+XMvpTJ2bMvchwzseUXD4=
Received: by 10.68.38.8 with SMTP id c8mr11157471pbk.42.1319902997070; Sat, 29
 Oct 2011 08:43:17 -0700 (PDT)
Received: by 10.68.71.135 with HTTP; Sat, 29 Oct 2011 08:42:36 -0700 (PDT)
In-Reply-To: <7vzkglrnmc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184456>

Cc'ing the msysgit list.

On Fri, Oct 28, 2011 at 8:12 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> * ef/mingw-upload-archive (2011-10-26) 3 commits
> =A0- upload-archive: use start_command instead of fork
> =A0- compat/win32/poll.c: upgrade from upstream
> =A0- mingw: move poll out of sys-folder
>
> Are msysgit folks OK with this series (I didn't see msysgit list Cc'e=
d on
> these patches)? If so let's move this forward, as the changes to the =
core
> part seem solid.
>

The msysgit list not being Cc'ed on the patches was a slip-up on my
behalf. I believe the changes are relatively uncontroversial from an
msysgit point of view, though. However, an ack/nack would be
appreciated ;)

Or does people prefer me re-sending the series, with the msysgit list C=
c'ed?
