From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git refuses to work with gvim
Date: Mon, 12 Oct 2009 17:20:19 +0300
Message-ID: <94a0d4530910120720pccaa920n7ab407494473ac7b@mail.gmail.com>
References: <20091012134312.236d250e@gzip.coli.uni-saarland.de>
	 <vpq8wfgg4u1.fsf@bauges.imag.fr> <20091012141334.GE9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	sebastian@coli.uni-sb.de, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 16:24:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxLpZ-0003mq-0Z
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 16:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbZJLOWJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 10:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbZJLOWI
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:22:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:64769 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254AbZJLOWH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 10:22:07 -0400
Received: by fg-out-1718.google.com with SMTP id 16so461370fgg.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 07:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wLQi3CF8li2/H3u/J4E0OkAZ0au4DsbU72KZ03eZFqg=;
        b=HpojJqo65e6jI5DbREiciam1a1bY12SjwBWYq205rt7NyeduD9DI80EhuW/MYeM2xK
         AzqrE+J7ui4azpky5qquOB2xSdjY791hu+99x5bwCppes/fWscVfRG728+MbwF5duy4J
         Mb3a36PGXdWOvo5If6weqGNauNKhI04cDyLw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EDUVP2rCSRnXsRP1MLjMAycVNPhZ2CfmFDtSClY42SuP/Lc710MDxGdfhCog0EPOKs
         OJhb1zVZPTugtYsh0kDClayBAz4CZTM9PpkD4zJstZ9g6BE7OU4zztui+V7XIChQswgg
         MxaN8L2YCz6NjU8f2f6MLo6oN6ovgsJUIwKag=
Received: by 10.86.254.23 with SMTP id b23mr994928fgi.21.1255357219899; Mon, 
	12 Oct 2009 07:20:19 -0700 (PDT)
In-Reply-To: <20091012141334.GE9261@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130015>

On Mon, Oct 12, 2009 at 5:13 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>> The problem is that gvim returns immediately
> ...
>> (BTW, this is in no way specific to Git, 99% applications calling
>> $EDITOR will expect the same behavior)
>
> The sad part is, every gvim user blames Git.
>
> Every single one of my coworkers who uses Linux had gvim as their
> default $EDITOR and found git commit working sometimes, and not
> working others. =C2=A0Since git was new to them, they blamed git, not
> their $EDITOR. =C2=A0They also felt insulted when I told them their
> $EDITOR was busted and should be replaced.
>
> Someone needs to whack gvim upside the head and fix that program
> to behave correctly.

Huh? What is wrong about 'gvim --nofork'?

--=20
=46elipe Contreras
