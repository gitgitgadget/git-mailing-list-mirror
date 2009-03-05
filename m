From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or 
	configured
Date: Thu, 5 Mar 2009 23:18:59 +0100
Message-ID: <fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com>
References: <20090305221529.GA25871@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Andreas Ericsson <ae@op5.se>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 23:20:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfLvf-00022l-Ue
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 23:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbZCEWTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 17:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753133AbZCEWTG
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 17:19:06 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:33162 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbZCEWTE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 17:19:04 -0500
Received: by fk-out-0910.google.com with SMTP id f33so64385fkf.5
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 14:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wNpE38IfZU/9ccZJc9B7hlpyt+f2jhTvZAIStRENt20=;
        b=F7MyeLEGDZVUHl4XCu4spVV29DzXpFDQj1uDqyUzedvVKuixH7NJVffwZsnz8g4dUv
         ADdqWU2OrKT4VdDDIy2XJ8qWxLcojn/v7Wm8UWJEnGflebv2wvtC93gbQzapetPQi7ZT
         UHqpy4jtqPc09TH0pH3a9Ow4doLUs9OXf+8B4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZSrb8Uj3ZOwG5n7jagCRmWCiXsf4p6CGE+xhAKu2iFLUa1rN/Or4wH1TXxSfn5QqBK
         YRLnTYiESEyHh+JP8Yb5iCWzyzYWsF38cEv4Q493oos71WSZbjjTaZ9+Xdt6xesnWbT5
         MOaIlpLuw/Sh459D7H9nOlTPAUrYgmKVVpYiI=
Received: by 10.102.219.8 with SMTP id r8mr785228mug.10.1236291541358; Thu, 05 
	Mar 2009 14:19:01 -0800 (PST)
In-Reply-To: <20090305221529.GA25871@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112350>

Heya,

On Thu, Mar 5, 2009 at 23:15, Finn Arne Gangstad <finnag@pvv.org> wrote:
> Previously, git push [remote] with no arguments would behave like
> "git push <remote> :" if no push refspecs were configured for the remote.
> It may be too easy for novice users to write "git push" or
> "git push origin" by accident, so git will now push nothing, and give an
> error message in such cases.

Config option please, I very much like the current behavior.

-- 
Cheers,

Sverre Rabbelier
