From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 8 Jun 2011 15:49:27 +0200
Message-ID: <BANLkTiku_qvn73cUDBT=OxY-3jR3raoOhg@mail.gmail.com>
References: <20110608093648.GA19038@elte.hu> <20110608203433.61e02ad8.sfr@canb.auug.org.au>
 <20110608125242.GA32745@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, git@vger.kernel.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ingo Molnar <mingo@elte.hu>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 15:50:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUJ9D-0000fB-D6
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 15:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab1FHNuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 09:50:09 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45006 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755487Ab1FHNuI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 09:50:08 -0400
Received: by qwk3 with SMTP id 3so226475qwk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 06:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=oZ6KhrNM0QNk3/5Hxt2XwtsfSzmmUDp+UIacGoU9v/0=;
        b=udC9FLucwNm4Dv1b2mhdkrwKIvHDyoyyd75OJWwsdcVAI2qDWMkwpuOQPNk14OFq2C
         ljSJlzeUQVnIYYPMUjY3TBWwpGhxCirUfLs/15golf/TMnfI5OBbeXAw5K1oxkjWhpAr
         VNUwuwgx51YoeEkcWWcRly/D9LbplF8pX0duA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=S4r+Y0PR1D75IYf9K8ByNNoRvDzLlxefSe5tcI0jbEHJ/KBRp/Q9n724gDEvHIFoyL
         EDvPbTpxCtptGHwzPC6Bw+yl+WlRhh2GOozg6z0673Q9PnuTqY1Vtuvc1n9HbaQz+YZV
         xbhKUf/beG1VF1xPK2YlaQnKEjIo1v9GodEGs=
Received: by 10.229.127.99 with SMTP id f35mr5478423qcs.91.1307541007445; Wed,
 08 Jun 2011 06:50:07 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Wed, 8 Jun 2011 06:49:27 -0700 (PDT)
In-Reply-To: <20110608125242.GA32745@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175372>

Heya,

[+Peff, Duy, who seemed interested in this]

On Wed, Jun 8, 2011 at 14:52, Ingo Molnar <mingo@elte.hu> wrote:
> So it would be nice to have more separation for remotes - right now
> they do not sit still in their sandboxes! :-)

Sounds like the "tags should go in their own namespaces in git 1.8.0"
[0] discussion? :)

[0] http://thread.gmane.org/gmane.comp.version-control.git/165799/focus=165837

-- 
Cheers,

Sverre Rabbelier
