From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Manually edit the commit a submodule is pointing to?
Date: Mon, 12 Apr 2010 14:19:15 -0400
Message-ID: <g2yc115fd3c1004121119l404caf8coa376d7561f130a3b@mail.gmail.com>
References: <i2jc115fd3c1004120731g950c127fn44603df222de8273@mail.gmail.com> 
	<20100412144718.GC6313@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 20:19:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1OEY-0000Sr-Rw
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 20:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793Ab0DLSTi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 14:19:38 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:36221 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab0DLSTh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 14:19:37 -0400
Received: by gxk9 with SMTP id 9so3532016gxk.8
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 11:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nHhAZontQuyCMKTy0hCGyIvMCo55wrVo0Ul/S8RxrPI=;
        b=TW4ME24vUkr2HGoZ31iYUEqa1NPP/2lmyjmClDV6Pfsrp3EU4w8ia0+VRi+RB88ZjD
         IfLso0OLSeA3NKuA4SUnYWmqpELWV3HbCbSExtlZWPP3INXfb6QV5Q2YljS9yyK0FVO1
         MDU4a+6aBsv808Qv3Mon26xJIZeR1krV4kSb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=I1YjKsleIDPDYwbjd0GbOu3m1jzuLUKlwZniWpdCEe4fCPL9kjjo5ZWvsfiiH+BqQ9
         ou+sYo5tP7z7mZzJbJtjkh9BuJVXGSif6DPEXANvespFp6r6NFDAqY7mAGPnh5bT1Rw8
         Npq4kBEjHV0OVcyvATOSkLSPlqMjtPz8qBAAE=
Received: by 10.100.109.4 with HTTP; Mon, 12 Apr 2010 11:19:15 -0700 (PDT)
In-Reply-To: <20100412144718.GC6313@spearce.org>
Received: by 10.100.25.4 with SMTP id 4mr8016672any.9.1271096375564; Mon, 12 
	Apr 2010 11:19:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144764>

On Mon, Apr 12, 2010 at 10:47 AM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
> Tim Visher <tim.visher@gmail.com> wrote:
>> I recently began to use submodules to manage large packages that I
>> depend on from my .emacs file and I've run into an issue where I mad=
e
>> a change locally and didn't push out to the master repo. =C2=A0I'm n=
ow not
>> at that box and I'm trying to checkout the repo fresh.
>>
>> The problem is that the master repo doesn't have the commit specifie=
d=E2=80=A6
>> Where? =C2=A0So I can't edit the submodule commit and then readd it =
because
>> I don't have the submodule to edit since I can't check it out. =C2=A0=
Is it
>> possible to just manually munge the commit that the submodule is
>> pointing to?
>
> Yup:
>
> =C2=A0git update-index --cacheinfo 160000 commit path

Thanks, Shawn.  That worked great.

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
