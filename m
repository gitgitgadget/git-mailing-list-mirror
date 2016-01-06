From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Segmentation fault found while fuzzing .pack file under 2.7.0.rc3
Date: Wed, 6 Jan 2016 16:46:04 +0700
Message-ID: <CACsJy8A3xX02pV7r+vG0BvtFmU=Axx7=2nHXp07zOreXeAj_wg@mail.gmail.com>
References: <568BC8D1.3080201@gmail.com> <20160105152436.GA1205@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacek Wielemborek <d33tah@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 10:46:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGkg4-0001jo-19
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 10:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbcAFJqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 04:46:38 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35914 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbcAFJqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 04:46:35 -0500
Received: by mail-lb0-f182.google.com with SMTP id oh2so188272249lbb.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 01:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OAc7LLtC5KX6Dy0F+3XOehu/bANWAxPAqIEsXMrzdXQ=;
        b=VzfbjILpRJaIoEDhO4BHo3a3lGIFLW95zEUJtEwqeFSU9C+2YTJzS6pLB0aHuUJUHL
         ad2sHHJQLErdPK9SyCWlr18vUKPQKoc6xNq6wJvaremqh+PRWROdM0aC58KOlhCoT7/8
         fbfIuuGmuYZBYPPwQkSZSGYqW4VD4jltpQAj1MtRBFxXpctbyb/GLpzRC35WkwnmEwSR
         AedQ+6dc2/XF7F+clri693bVOkEOxQ7RJT5qL7OF/eMqumArfDNM7sjujEhD0scZ3OJ4
         LrPsc6xfpm8L/Tw3VUmWw7IrYFhc/oYFjqX5Jwne0bwqSzh1rGF3JM/P+9m8p5+RsIcr
         Di5g==
X-Received: by 10.112.172.8 with SMTP id ay8mr14342407lbc.145.1452073593702;
 Wed, 06 Jan 2016 01:46:33 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 6 Jan 2016 01:46:04 -0800 (PST)
In-Reply-To: <20160105152436.GA1205@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283429>

On Tue, Jan 5, 2016 at 10:24 PM, Jeff King <peff@peff.net> wrote:
> If you can find a fuzzed packfile that crashes "index-pack", then _that_
> would be a big deal.

I'm sure you know this, but if Jacek moves to break index-pack, then
he/she should also try to break unpack-objects because sometimes we
use that command instead of index-pack.
-- 
Duy
