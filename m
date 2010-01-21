From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: git locate
Date: Thu, 21 Jan 2010 10:51:37 +0100
Message-ID: <20100121095137.GB7370@headley>
References: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com>
 <alpine.DEB.1.00.1001200224270.4985@pacific.mpi-cbg.de>
 <m3zl49bk0o.fsf@localhost.localdomain>
 <alpine.DEB.1.00.1001201021060.31129@intel-tinevez-2-302>
 <4B579BA8.8050000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: SungHyun Nam <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 10:49:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXtfM-0001Zu-TU
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 10:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab0AUJtV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jan 2010 04:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974Ab0AUJtU
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 04:49:20 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:55349 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab0AUJtT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 04:49:19 -0500
Received: by fxm20 with SMTP id 20so1094509fxm.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 01:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=97WIHwFloNGt9jlLwhbmWlcCmUvuLx0OYlcul4Ej8I0=;
        b=IqBuMYCBq2V5VL1PibvmcSOSCQcbdwCU/mVexMhe9zFLvOdTT9aU79y4O91M8WVpMw
         qkgDS/D3u+GC1/c/SGWvytaGGZgshbi1YK73QhAV3HSs3MIG/GuPfHR+8/DtCwGkU+jm
         izkj2xwCp5rRIbJirq4XGW8v5dSWEXAOS6tYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=W5faWVzxX0VGyE3tR1l/XMIJ6qdXaBm4XZqYO1OPf41o8nYc8CyNV87Nw33bixJK0a
         aQq6AKNwvpbascU09ekMcGzbkZvWWL9wdMdEJ7jGZDHbMTiAfK2gFYDpQhhDncoOf3oM
         C6rYCm8VPW9MRPBTDj95R66p0N9im4WbE7CTg=
Received: by 10.223.14.141 with SMTP id g13mr1175954faa.54.1264067358198;
        Thu, 21 Jan 2010 01:49:18 -0800 (PST)
Received: from localhost ([88.103.132.186])
        by mx.google.com with ESMTPS id 12sm1060643fks.39.2010.01.21.01.49.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Jan 2010 01:49:17 -0800 (PST)
Mail-Followup-To: SungHyun Nam <goweol@gmail.com>,
	Git List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B579BA8.8050000@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137647>

On Thu, Jan 21, 2010 at 09:11:20AM +0900, SungHyun Nam wrote:
> Hello,
>=20
> Johannes Schindelin wrote:
> >
> >On Tue, 19 Jan 2010, Jakub Narebski wrote:
> >
> >>Johannes Schindelin<Johannes.Schindelin@gmx.de>  writes:
> >>
> >>>On Wed, 20 Jan 2010, John Tapsell wrote:
> >>>
> >>>>   Could we add a:  git locate<filename>        or git find<filen=
ame>
> >>>
> >>>How about "git ls-files \*<filename>"?
> >>
> >>Or "git ls-files '*filename'...
> >>
> >>... but how to make an (git) alias for this?
> >
> >Add something like this to your $HOME/.gitconfig:
> >
> >[alias]
> >         locate =3D !sh -c 'git ls-files "\\*$1"' -
>=20
> The alias 'git locate' and the command 'git ls-files' runs
> differently if I run them in a subdirectory.
> Is it expected?
>=20
> [master] ~/srcs/git[299]$ git locate urls.txt
> Documentation/urls.txt
> [master] ~/srcs/git[300]$ git ls-files '*urls.txt'
> Documentation/urls.txt
> [master] ~/srcs/git[301]$ cd t
> [master] ~/srcs/git/t[302]$ git locate urls.txt
> Documentation/urls.txt
> [master] ~/srcs/git/t[303]$ git ls-files '*urls.txt'
> [master] ~/srcs/git/t[304]$

Yeah, as stated in another part of the Wiki page Dscho referred to
(namely the "Serve repo on the spot" section):

"It makes use of the fact that (currently, as of git 1.5.6.1) non-git
alias are executed from the top-level dir of a repo."

("non-git" =3D=3D those starting with "!", which is the case here)


    =C5=A0t=C4=9Bp=C3=A1n
