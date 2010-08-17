From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: limiting ref visibility to specific users
Date: Tue, 17 Aug 2010 10:48:47 -0500
Message-ID: <AANLkTikbT+e+7+LxrP6TkuuQ=8rMxuTnvFcUbUFzaUgk@mail.gmail.com>
References: <20100817150921.GB12682@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: weigelt@metux.de, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 17 17:49:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlOPi-0008AA-86
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 17:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682Ab0HQPtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 11:49:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40668 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab0HQPtI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 11:49:08 -0400
Received: by gwj17 with SMTP id 17so1579464gwj.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=13zw05WHHOECLHQngwYv0VI4Hq3XNs+V7zZXeDMEPO0=;
        b=bx5tSlojZtvygHzdYdDdfONwVX0Z757X0Ob50UlxePkyATmSbQNj42z8bc7r/V5d8d
         AjKm+K1eoO3QxFflPaRga6kIHMUT8Ksr2gPzxmVX82enrLRPqWW2xyaBQwDOjXsVQjaZ
         mXQ7dEDD3CEaLQLtCuhIailAhj0oTv2OYsjDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=QkjXWwET22rE5hzGZtTEKUBa9qewhBClU4IQmTfOdlLEdhpX4xHDRPES3MwY1NwlVe
         EylWmJ/iRJm6YaVwvWrYP0Va8eA/BdGuWlm8ciz3lUDaGFvrcNmJBSjSSUx5Z3lkqGWf
         J045VkFe41qX7vyYBZttcWiltyNr0LTdtVSSg=
Received: by 10.150.178.14 with SMTP id a14mr7447312ybf.131.1282060147188;
 Tue, 17 Aug 2010 08:49:07 -0700 (PDT)
Received: by 10.150.98.8 with HTTP; Tue, 17 Aug 2010 08:48:47 -0700 (PDT)
In-Reply-To: <20100817150921.GB12682@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153754>

Heya,

On Tue, Aug 17, 2010 at 10:09, Enrico Weigelt <weigelt@metux.de> wrote:
> I'd like to control which refs are visible to certain users
> (when coming via ssh). Is there already some generic way to
> do that (eg. passing some filter rule by a calling wrapper ?)

Shawn, weren't you looking into something similar for Gerrit? Although
I think what you were investigating would allow the user to get the
rest of the refs somehow?

-- 
Cheers,

Sverre Rabbelier
