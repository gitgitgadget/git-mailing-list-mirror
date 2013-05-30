From: John Keeping <john@keeping.me.uk>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 12:48:08 +0100
Message-ID: <20130530114808.GD17475@serenity.lan>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex =?iso-8859-1?Q?Benn=E9e?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Thu May 30 13:48:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui1LB-0000Dc-7E
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 13:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833Ab3E3LsS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 07:48:18 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:51871 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab3E3LsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 07:48:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id C7BCF22FDA;
	Thu, 30 May 2013 12:48:15 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8X4A+tA2A5hz; Thu, 30 May 2013 12:48:14 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 23A9522CFC;
	Thu, 30 May 2013 12:48:10 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225967>

On Thu, May 30, 2013 at 11:38:32AM +0100, Alex Benn=E9e wrote:
> One factor might be the size of my repo (.git is around 2.4G). Could
> this just be due to computational cost of searching through large
> packs to walk the commit chain? Is there any way to make this easier
> for git to do?

What does "git count-objects -v" say for your repository?

You may find that performance improves if you repack with "git gc
--aggressive".
