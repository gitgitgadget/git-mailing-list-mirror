From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Can Git work for us if we are remotely hosted?
Date: Thu, 12 Aug 2010 14:08:35 -0400
Message-ID: <AANLkTin_qwk9FxkhVkvfQyc0AFXOKfKX-b+BzgXas_CW@mail.gmail.com>
References: <AANLkTin4JyZhmjm_1c4q7kjP0eXzA-_2eNsLzsnGASet@mail.gmail.com>
 <AANLkTi=GDj47jieVL4+0YD1X5pa+9g7=c2wRx_T3CDVS@mail.gmail.com> <AANLkTimxYgAwWWoJCxsQ_Rr-eGfWJWoL4Qscw3FBYk9_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Sultan Shakir <sshakirflhosp@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 20:09:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjcDA-0003MG-NY
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 20:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934024Ab0HLSI5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 14:08:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55869 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760571Ab0HLSI4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 14:08:56 -0400
Received: by wyb32 with SMTP id 32so1674335wyb.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=j3uSUkYErO1+5mNAtACqkoYqFnlFFZ7yUH3hXDVr6lA=;
        b=ZEHD+adms5GHqykvH5Gy/T32j68fGqzugInRXOQU6t6MnplioBRGNEC4xVWGIzQOIc
         qtbhcqzsIvNR/rv2vpV+LdYy8Dj90ZlusDtqkMkEmoZLam0VmDjU3LsuaTw2IB33wS30
         79rLd6Rwub9YvsBsNdxf5QMCXn+okRjKz2HiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=f+OAmRbR9Hbxw1jHvb8hHVq5fKLccI8qKvHWdqmDAL2P5mdTeZVsy9txynYpR1kI3G
         qCTNse98z+umtxHNQRo5pW1/c50g/PL5E9SZSHzjzwHDJuNjQkab2V6blbqApgwgTQU3
         saqIhW4ksdfvP/2QTSOdYcP29A2xnO/h5fLU8=
Received: by 10.227.138.146 with SMTP id a18mr380157wbu.151.1281636535217;
 Thu, 12 Aug 2010 11:08:55 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Thu, 12 Aug 2010 11:08:35 -0700 (PDT)
In-Reply-To: <AANLkTimxYgAwWWoJCxsQ_Rr-eGfWJWoL4Qscw3FBYk9_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153397>

On Thu, Aug 12, 2010 at 1:59 PM, Sultan Shakir <sshakirflhosp@gmail.com=
> wrote:
> On Wed, Aug 11, 2010 at 7:06 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> On Wed, Aug 11, 2010 at 6:51 PM, Sultan Shakir <sshakirflhosp@gmail.=
com> wrote:
>>> I've been trying to wrap my brain around how I can get Git to work =
at
>>> my organization. =A0The issue is that nearly all of our programs an=
d
>>> their IDE are remotely hosted. =A0This means that to even work on a=
 file
>>> we have to connect to the network in order to use the application t=
hat
>>> we code in. =A0We do have access to the backend where the files are
>>> stored though. =A0How can we use Git in this situation without sett=
ing
>>> up another server?
>>
>> If you want, you could just push/pull to a git repo in a file share =
on
>> one of your existing fileservers.
>
> Please excuse my ignorance. =A0What do you mean by a "file share" and
> "existing fileservers"?

You said you have "access to the backend where the files are stored."
Surely that's on a fileserver, like a Windows file sharing service or
a samba server or an NFS server, right?  Any of those are capable of
holding a git repository.

git is much faster if you store files on your local machine as much as
possible.  But you can push/pull from a shared repository on a
samba/NFS/whatever server and that generally won't be a performance
problem.

Have fun,

Avery
