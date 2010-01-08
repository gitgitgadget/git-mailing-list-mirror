From: Chris Packham <judge.packham@gmail.com>
Subject: Re: ssh username environment variable
Date: Fri, 8 Jan 2010 15:37:36 -0500
Message-ID: <a038bef51001081237h67fd421cg767403bf9f0d99df@mail.gmail.com>
References: <a038bef51001081224l33164526y51e5ca064b82b73a@mail.gmail.com>
	 <20100108202958.GL32155@spearce.org>
	 <7vskag9vz0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 21:37:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTLaY-0004IC-ID
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 21:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab0AHUhj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 15:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903Ab0AHUhi
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 15:37:38 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:53491 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab0AHUhi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 15:37:38 -0500
Received: by pwj9 with SMTP id 9so247701pwj.21
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 12:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9ypN633tkdlM3R/IcUgHdoDhlB1nMxqn3ITqYmD/Hmo=;
        b=hULVOMQh9z8Zy+pCxaHgeBrSAqhGbfZC1Wrw13kdzznXkl8xtF8thLNEX7+q/xxxti
         kjlxwczMorilCLs+pfUEkMFps1hhVeqmeXZyToGJCS0synXU/pCpusIQeh4IbalSx3ZN
         26zIYbV45tWLJLAcCWu/SdMeWPbpfRXmQRDyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q/CFagiGzOjhzbPfmNbqHs7vbN0tPPOk5djwGrDx0pKZp3nRNUMhIr72buNyG4OTpY
         p5Pvq64X/RUMZ5W2E7/wvTlMijRNy9osBFK9u89Kaa3aFIyFFLv20XmlM83X16f2EhIu
         imqWimigzj4evDAqXzjFTpdpE1rnRFbVmhrRw=
Received: by 10.114.31.8 with SMTP id e8mr1518222wae.54.1262983056851; Fri, 08 
	Jan 2010 12:37:36 -0800 (PST)
In-Reply-To: <7vskag9vz0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136474>

On Fri, Jan 8, 2010 at 3:34 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> Chris Packham <judge.packham@gmail.com> wrote:
>>> Just wondering if there is an environment variable I can use to tel=
l
>>> git or ssh what user name to use for the ssh transport?
>>
>> No. =C2=A0But you can hack around it:
>>
>> =C2=A0 cat >$HOME/bin/git-ssh
>> =C2=A0 #!/bin/sh
>> =C2=A0 ssh -l $GIT_SSH_USER "$@"
>> =C2=A0 ^D
>>
>> =C2=A0 GIT_SSH=3D$HOME/bin/git-ssh GIT_SSH_USER=3Dmyname git clone .=
=2E.
>
> I thought the standard answer was "use $HOME/.ssh/config", to set Use=
r
> by keying on the remote hostname to which you are going.
>

Yeah thats what I've done after reading a few more man pages.
