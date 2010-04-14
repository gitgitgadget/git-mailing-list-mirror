From: Dave Olszewski <cxreg@pobox.com>
Subject: Re: Re: git log of remote repositories.
Date: Tue, 13 Apr 2010 19:15:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1004131903190.25327@narbuckle.genericorp.net>
References: <u2n3abd05a91004131625k500e79bbsc8ffa6455a85332d@mail.gmail.com> <20100413232747.GD17484@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Aghiles <aghilesk@gmail.com>, git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 14 04:15:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1s8j-0000JH-Ar
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 04:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388Ab0DNCPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 22:15:07 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:36202 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754339Ab0DNCPG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Apr 2010 22:15:06 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o3E2F166012636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 13 Apr 2010 21:15:02 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <20100413232747.GD17484@spearce.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144841>

On Tue, 13 Apr 2010, Shawn O. Pearce wrote:

> Aghiles <aghilesk@gmail.com> wrote:
>> I have a local branch that is a tracking a remote branch. I want to see
>> what are the modifications upstream, _before_ I pull. I tried
>> 'git log origin' but that's only the point from where I pulled last.
>>
>> Is there a way to do that?
>
> git fetch
> git log ..origin

Or the more portable and concise, since 1.7.0:

git log ..@{u}
