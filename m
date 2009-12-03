From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] reset: add --quiet option
Date: Thu, 03 Dec 2009 01:46:35 -0800
Message-ID: <1259833595.1491.1.camel@swboyd-laptop>
References: <1259492290-21771-1-git-send-email-felipe.contreras@gmail.com>
	 <1259543939.5679.5.camel@swboyd-laptop>
	 <94a0d4530911300219j51e21e2cwae17d4248400a345@mail.gmail.com>
	 <780e0a6b0911301345v42c2b22bs34092fb69b21a2a0@mail.gmail.com>
	 <94a0d4530912030133n7e2fbf2asfea6e3896980dc7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 10:46:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG8Gq-0001uH-AF
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 10:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798AbZLCJqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 04:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755657AbZLCJqc
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 04:46:32 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:41554 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516AbZLCJqb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 04:46:31 -0500
Received: by pwi3 with SMTP id 3so951153pwi.21
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 01:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=3mOvQvNWHb/4Y9pv0TMhAgtOMxNG2SxMl17KlANtWU8=;
        b=kZYKLCgBRcsICjezWCRvmYuyb2cp3T1AcGW7Syp/W6OfmESK5Abc4Z5TVw7lN7I6Xz
         DFGW9rBgVHgbdapePOzRuK2shrWVP1tk0JUTx5/8NGnt1i1nUPFTW+YCKiIaotGVIfCV
         ADEYznDGu39yrwX+N0UE4x7/Lm12KamGzvjfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Sb7nz4BHGk8hKOu/HkC2hI1AUwq+d4+UhQstA4nScs6KDuKBPwzw8eICDM3jupCY2D
         ORGKlwofnod/n+lZEacEvUyhLLnuzTB8wAIO01s8ZxHqglvCuiWBJhibVibuLrx+gnO1
         1zho20gLtJqhSU2vEx/KLfPcS8V0d72h7I+is=
Received: by 10.115.102.38 with SMTP id e38mr2097934wam.207.1259833597442;
        Thu, 03 Dec 2009 01:46:37 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 23sm1560163pzk.0.2009.12.03.01.46.36
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Dec 2009 01:46:36 -0800 (PST)
In-Reply-To: <94a0d4530912030133n7e2fbf2asfea6e3896980dc7c@mail.gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134446>

On Thu, 2009-12-03 at 11:33 +0200, Felipe Contreras wrote:
> On Mon, Nov 30, 2009 at 11:45 PM, Stephen Boyd <bebarino@gmail.com> wrote:
> > If you're already touching the line why not just do it once? I agree a
> > follow-up patch to cover the other commands would be good.
> 
> Because the less trivial the patches, the less luck I have of getting
> them applied :)

Heh, still seems pretty trivial to me ;-)

> 
> Anyway, I sent a patch to use OPT__QUIET directly in two places.
> 

Great. Thanks for making it more consistent.
