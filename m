From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git merge --no-commit <branch>; does commit
Date: Thu, 13 Dec 2007 22:19:08 +0100
Message-ID: <81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com>
References: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael Dressel" <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Thu Dec 13 22:19:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2vSy-0001Ga-4u
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 22:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763591AbXLMVTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 16:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762855AbXLMVTM
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 16:19:12 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:2132 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbXLMVTK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 16:19:10 -0500
Received: by wr-out-0506.google.com with SMTP id c49so589386wra.1
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 13:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Q7nSkYYh6SF1EApK8UDXze7jVouvNzbM0SkMi4rLgT8=;
        b=oRZFXDQKHnhOJGaXcY/NiNS6stUNfzNLt3SttqZO34Y3ulR8mV7f49PK5IWxtQEzjWnyE6A7ppRN7kMSaCHDl7X58+uTp2SXgjhyaZfQDb2WTEh+8F3DBldWsiK7UiAdnJACrozCuQo+7cXeC+MNxJ1IczLPY6fvrgdD9xuw0IE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gCtPemQ0pKRkLS+uqsjeV3ej3DZp+uea7k7EhVUkZxj9GGy2prCg7piABzakLxLXHnCBjgflTDav4romX8eFbWqoOWj1TtekQzsY+a2sOFrdTdgczMfSuVHnAcLsRmxF8pB/3ZibznitLXutjNHFWkbo5PuGeQOZVFiAdo6bD/A=
Received: by 10.78.183.8 with SMTP id g8mr3147575huf.55.1197580748120;
        Thu, 13 Dec 2007 13:19:08 -0800 (PST)
Received: by 10.78.118.18 with HTTP; Thu, 13 Dec 2007 13:19:08 -0800 (PST)
In-Reply-To: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68192>

On 13/12/2007, Michael Dressel <MichaelTiloDressel@t-online.de> wrote:
> git merge --no-commit <branch> does "create" a commit. At lesat the
> head and index are moved to the new commit fetched from <branch>. Maybe
> that is because git was able to do a fast forward?

Yes. Because fast-forward is what it called: fast-forward.
It does not do any commits at all.
