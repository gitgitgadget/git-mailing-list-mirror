From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Migrate from svn to git
Date: Tue, 1 Jun 2010 09:23:21 -0500
Message-ID: <AANLkTimRzqeffooPPHEVE9_ccZojmZG-SudKTx_6M7ho@mail.gmail.com>
References: <4BFD3AAF.4080403@fechner.net> <AANLkTinKsGPo0-ETmVOSH6fY64GLLwVm2dNBGyjAvrin@mail.gmail.com> 
	<4C04ADFC.9020309@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 16:24:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJSNx-0005KG-8R
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 16:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286Ab0FAOXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 10:23:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62415 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580Ab0FAOXy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 10:23:54 -0400
Received: by fxm8 with SMTP id 8so991294fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=AfPsyTBpApa1Tu+jvz3vObVsuofExDm5rFQSc7giuqc=;
        b=l4wdxnWyaceOH2oyxRqbGvvkpHa+Wq9QKUq6n9NyDAkqUPplm81j1D/3xP9b58YvBj
         htHHnrLItZFc7pHR+igw1YD7POc85okKfxcbSz/54zWOE524wp2NYiZJhrL8ALJFGPe0
         nk6Q3i2zyxl9/jQ/qS2sbABTM3DmHXgZ2Werc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=asi4TR3GONaKLU1ZlKFvGb12nzbdeMM2eoKwTSSkjj10ZcC/HnA01wh83gJwUhoAUp
         uq3xtR/zkaFZseQGIxF9G8ipYZAaz217pjBq0tEDAHx5QPNScPgTCUkhaisUKduTyJWF
         z4V0hXrJY2owaZhM82UCayZUX0Vx1N/NcbR9c=
Received: by 10.239.186.76 with SMTP id f12mr480151hbh.59.1275402232100; Tue, 
	01 Jun 2010 07:23:52 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Tue, 1 Jun 2010 07:23:21 -0700 (PDT)
In-Reply-To: <4C04ADFC.9020309@fechner.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148116>

On Tue, Jun 1, 2010 at 01:51, Matthias Fechner <idefix@fechner.net> wrote:
> I'm thinking more and more about it and I think the best solution is to keep
> svn as the central repo and do a git svn clone from there, so I have the
> advantage of the existing infrastructure and will get the nice features from
> git.

That's probably a good way to get people started with git.

However, git hooks SEEM like they should be enough for your purposes.

For permissions, see contrib/hooks/update-paranoid:

  http://git.kernel.org/?p=git/git.git;h=d18b317b2f018d1d1a5a9677a7bdaf8956d65186

and for emails, see see contrib/hooks/post-receive-email:

  http://git.kernel.org/?p=git/git.git;h=30ae63d74da065a31cced0b161708680f39c04c0

(Sorry if gmail mangles those urls).

Sincerely,
Michael Witten
