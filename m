From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: How to prevent changes to repository by root
Date: Thu, 17 Jun 2010 10:28:07 +0800
Message-ID: <AANLkTimjIraq-qDaifACixJ4cCOYuvkf1v-hVpeaVt3u@mail.gmail.com>
References: <AANLkTikLixhYITdJKMFb3Hw2hZvaas1DtiV3x9ThCTZz@mail.gmail.com>
	<AANLkTikPNH1ueb5m8JpiB2hU4afd3hv-4qYqSO3QPujl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Aneurin Price <aneurin.price@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 04:28:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP4q3-0004N3-E7
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 04:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845Ab0FQC2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 22:28:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53941 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892Ab0FQC2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 22:28:09 -0400
Received: by gwj15 with SMTP id 15so4532718gwj.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 19:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=g6VAEgRe2pDbuH2nItBAN6ulNRERNfF0ehouRzgdqWA=;
        b=b93V4r4STAx1XOocecageF3+9OPyZLsGrXxUqPFdDV2rV4RuG5YIjxejxrj0rLSbSy
         mwdpSckoHOIDytbyk3gthcPHd1vFYkGNMaGD5XJ0quX0YHQNf0VNsJyL0wl97PfDcARl
         kK8y3jI9hvt/LLAqPgKY5oABOUmOzbJPlGIdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XvHxA/QwhXYVTyPCePj6QDdacXigPjD4bPsleT5K+YVtKPO1F9oD01DqAye4NClHA0
         Md0SZf/5xoSz9FpXKXJFb1GQRRKCADrEIrbKyeDe9gLGt81/9f4R2360mFa9xbLsI9Rl
         KxhByYxeIBanZ5nA+vhIfXryt+rygLv/VTNrQ=
Received: by 10.90.5.6 with SMTP id 6mr7191948age.84.1276741687846; Wed, 16 
	Jun 2010 19:28:07 -0700 (PDT)
Received: by 10.90.29.10 with HTTP; Wed, 16 Jun 2010 19:28:07 -0700 (PDT)
In-Reply-To: <AANLkTikPNH1ueb5m8JpiB2hU4afd3hv-4qYqSO3QPujl@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149284>

On Thu, Jun 17, 2010 at 12:09 AM, Aneurin Price <aneurin.price@gmail.com> wrote:
> How are they becoming root? If they are using sudo you could forbid
> running git as root. If they are using su or logging in directly maybe
> you can get away with some trivial thing like putting 'alias
> git=/bin/false' in /root/.bashrc - or some wrapper which does
> something helpful rather than silently fail :-).

Thanks for dropping the hint on wrapper.

I've implemented one that give the user a friendly reminder
that they are running git as root and ask whether to continue.

nazri.
