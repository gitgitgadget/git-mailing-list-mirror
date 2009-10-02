From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Re: Git push over git protocol for corporate environment
Date: Fri, 2 Oct 2009 11:58:59 -0400
Message-ID: <76c5b8580910020858t16804f5cg96ebb067e3a69e82@mail.gmail.com>
References: <m3pr989eyt.fsf@localhost.localdomain>
	 <00163623ac5d75929b0474e66b96@google.com>
	 <76c5b8580910020741p2024f6c0w70be53338924e7e8@mail.gmail.com>
	 <20091002144727.GZ14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eugene Sajine <euguess@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 02 17:59:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtkXC-0007Vu-1d
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 17:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552AbZJBP64 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Oct 2009 11:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbZJBP64
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 11:58:56 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:51289 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbZJBP6z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Oct 2009 11:58:55 -0400
Received: by ywh6 with SMTP id 6so621576ywh.4
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VFfJugNVAOhpY3t3UPgcY+YwE138yJ0ZP/ZYqXQ28wE=;
        b=HfBaVcOGo54+LjsvTj+ySmyG6R10Me+sbwfvdfDFqJqufV2xQw6gDbbZj9sCldI/x3
         O96Hl2H5njANz/8rCED8N182uuLVeQXnUqMOgwTxnUqTXWAzGYpuJS6PqPQiLqHLRdeZ
         QVFLRwL8YtfqC/3ZePXsduI7gvaMFI/vMtml0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RkeLqsEOzYiBBOrTtm/DWf41v7Zl45vdmbwp/6Bf2fwLtpZnDaqBiomSi31Nj+p55q
         1hB050A63MkCz8sdZ7+4rT96zJsYTyKi4R3ejryT+znJpa8gbKe0H9nY2xLqYss5R4jQ
         jOVHOXYwodnfIZTKxpGMMkXVn+fif7sEeysU0=
Received: by 10.91.97.9 with SMTP id z9mr1543440agl.46.1254499139192; Fri, 02 
	Oct 2009 08:58:59 -0700 (PDT)
In-Reply-To: <20091002144727.GZ14660@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129448>

Thanks Shawn!

I saw info about Scumd and Gerrit in previous emails, but
unfortunately haven't enough time to spend with those tools yet.
Reading about Gerrit right now.


On Fri, Oct 2, 2009 at 10:47 AM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Eugene Sajine <euguess@gmail.com> wrote:
>> Gitorious is even better!! for corporate use, i think, because of it=
s
>> team oriented approach, but... man... I would kill for java
>> implementation or anything as simple as that!!
>
> If you want a Java based server, look at either:
>
> * SCuMD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 http://githu=
b.com/gaffo/scumd
> * Gerrit Code Review =C2=A0http://code.google.com/p/gerrit/
>
> I think SCuMD might be easier to install, I don't think it depends
> upon a database or a servlet container like Gerrit does. =C2=A0But bo=
th
> are a SSH+Git implementation with some access control capabilities,
> and are implemented in Java.
>
> I don't think either is (yet) as easy to install as Hudson CI.
> Both projects have a much smaller team of developers behind them,
> and are still focusing on basic functionality rather than ease of
> new system setup.
>
> --
> Shawn.
>
