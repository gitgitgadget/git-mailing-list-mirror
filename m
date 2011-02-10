From: "Hillel (Sabba) Markowitz" <sabbahillel@gmail.com>
Subject: Question about git svn handling svn external
Date: Thu, 10 Feb 2011 11:44:28 -0500
Message-ID: <AANLkTi=TsWQh95MgFCW6ap05-NheVga4et_6h2w1A0VB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 10 17:44:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnZdU-0001kI-Hf
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 17:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756561Ab1BJQoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Feb 2011 11:44:30 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52555 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab1BJQoa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Feb 2011 11:44:30 -0500
Received: by ewy5 with SMTP id 5so877327ewy.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 08:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=bXoGUC9iEPy7P2L649JBPkzrazvjzVNvdTOXmLHq22M=;
        b=V2VpYUUM8BgUbgKGh8nzswV9wFM+jClsNcXtftfO5iams1B5kX6ef5gCy+ARr38lrP
         Fri131it16iq72OtzT/FcIBSn/o93TUyz+UG3dyZBiJnF2Ga33Nzq+TnfUNBfCO2NGAh
         TpYtASBMPlzsjhfDCxJ3GCbaOujASEsG7Kfqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=yDrK/fViERApvg3VlsPyMRqZZWRby8BCmlx6MPn87eVl6MnpHVlDDCucv9+sYacfRo
         IvQMiqwWPRAjfXOO7knfbX0dLYr74koGTg0MwTckzqPqMQdISrmUMIVM5YGo/SbSUJCh
         C9I61igFMEzi0xVLiztvrs62USmxgA8FCwNog=
Received: by 10.213.108.204 with SMTP id g12mr3859816ebp.99.1297356268150;
 Thu, 10 Feb 2011 08:44:28 -0800 (PST)
Received: by 10.213.28.71 with HTTP; Thu, 10 Feb 2011 08:44:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166488>

I use a python script which calls git svn clone based on a text file
built from the svn externals of the form

dir1 url1
dir2 url2

to create a git project. Each subdirectory of course will have its own
=2Egit and point back to the original svn repository so that I can
change a particular subdirectory.

=46or example, I have dirn from urln/trunk built and I want to change i=
t
to urln/branches/mybranch.

Is there a good way of doing this without deleting everything under it?

If I wipe out the dirn directory, I would wipe out the externals that
came in with urln and I would have to pick up all the entries that
follow. I do not want to pick up the external pointer from svn as I
might not actually be using all of those. I want to only bring in the
entries from the configuration file.  Of course, it would be more
useful if someone has already done it.

The project that I am on would like to use python for this, but if
someone has already written something, the language would not matter.



--
=C2=A0 =C2=A0 =C2=A0=C2=A0 Sabba=C2=A0 =C2=A0=C2=A0 -=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =D7=A1=D7=91=D7=90 =D7=94=D7=9C=D7=9C=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 -=C2=A0 =C2=A0=C2=A0 Hillel
Hillel (Sabba) Markowitz | Said the fox to the fish, "Join me ashore"
=C2=A0SabbaHillel@gmail.com | The fish are the Jews, Torah is our water
http://sabbahillel.blogspot.com
