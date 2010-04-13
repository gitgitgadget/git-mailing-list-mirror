From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git log of remote repositories.
Date: Tue, 13 Apr 2010 16:27:47 -0700
Message-ID: <20100413232747.GD17484@spearce.org>
References: <u2n3abd05a91004131625k500e79bbsc8ffa6455a85332d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 01:27:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1pWN-0005ix-JM
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 01:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab0DMX1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 19:27:51 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:24022 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab0DMX1u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 19:27:50 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2630117qwh.37
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 16:27:50 -0700 (PDT)
Received: by 10.229.251.72 with SMTP id mr8mr9431280qcb.30.1271201269881;
        Tue, 13 Apr 2010 16:27:49 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id v37sm8146224qce.0.2010.04.13.16.27.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 16:27:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <u2n3abd05a91004131625k500e79bbsc8ffa6455a85332d@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144838>

Aghiles <aghilesk@gmail.com> wrote:
> I have a local branch that is a tracking a remote branch. I want to see
> what are the modifications upstream, _before_ I pull. I tried
> 'git log origin' but that's only the point from where I pulled last.
> 
> Is there a way to do that?

git fetch
git log ..origin
 
-- 
Shawn.
