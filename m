From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/remote-helpers: explain capabilities first
Date: Fri, 18 Mar 2011 23:34:37 +0100
Message-ID: <AANLkTiksEgm+n6nLQ=HYjdE1PV4-XfmJhwj39Wp1crmg@mail.gmail.com>
References: <20110318174504.GA22332@elie> <AANLkTimfZM6muiU3vPMgx3NnRdb4H0t4E2DMXt1233LP@mail.gmail.com>
 <20110318222107.GD23407@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 23:35:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0iGR-00024e-VZ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 23:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757490Ab1CRWfT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 18:35:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40703 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757239Ab1CRWfR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 18:35:17 -0400
Received: by gyf1 with SMTP id 1so1767192gyf.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 15:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=hj1qxfjkP9e3+1VQUqtBWvugBBtB05g3+uKTPeHYRYk=;
        b=ndypYiTGEtDjK8TTZN2ohbN+kyLIvOiEsBndwUJk6uauBt8HsVBTpyORt+47h1WwZx
         HvfF22JaMRRJVx9MPOopqLZ+1v6XQUXAeopNaR7HgENhN5BoMpkEAk/dWo7ge2t69iTi
         kjFMaQ2IJTeTQLfi5gitQJdYRjuZFXWpq1dlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Rl/ZUYJNWjptyKylLf/Gf51u/m3iX7JCI0c/4BSOiunLIoO9Ppgw685wZkYa7yudjh
         Ml7RjIjKh+o3cgIAX6dKSQ9KvNo7XrBeKeEPkkAtKp/sawziUEh2T+pBHIgxPoEPUoXE
         EZpLqqZOePG756tOpNTU4iStxJaxSmvhZMiws=
Received: by 10.150.131.18 with SMTP id e18mr1750383ybd.316.1300487717099;
 Fri, 18 Mar 2011 15:35:17 -0700 (PDT)
Received: by 10.151.44.10 with HTTP; Fri, 18 Mar 2011 15:34:37 -0700 (PDT)
In-Reply-To: <20110318222107.GD23407@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169374>

Heya,

On Fri, Mar 18, 2011 at 23:21, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Thanks for explaining. =C2=A0FWIW I'd be interested in your thoughts =
on this
> sometime (not now necessarily, just some time before the svn push
> support project is on the front burner :)).

Any idea on when that will be? I've been wanting to finish push
support for git-remote-hg for ages now, but haven't been able to make
the time :(.

--=20
Cheers,

Sverre Rabbelier
