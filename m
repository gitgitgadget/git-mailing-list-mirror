From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/1] Introduce a way to create a branch and worktree at
 the same time
Date: Tue, 15 Mar 2016 21:40:23 +0100
Message-ID: <56E87337.3040609@kdbg.org>
References: <cover.1457609615.git.johannes.schindelin@gmx.de>
 <CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com>
 <alpine.DEB.2.20.1603101417590.4690@virtualbox>
 <CAHYJk3Sij4tH0i29Asahjj8KBdQj59jFRTCoYzO_XE_kt3SnDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 21:40:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afvlX-00059C-Ij
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 21:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934930AbcCOUk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 16:40:27 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:7889 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934917AbcCOUk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 16:40:27 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3qPmhm4KNJz5tlL;
	Tue, 15 Mar 2016 21:40:24 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id ED6FC52AA;
	Tue, 15 Mar 2016 21:40:23 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CAHYJk3Sij4tH0i29Asahjj8KBdQj59jFRTCoYzO_XE_kt3SnDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288910>

Am 11.03.2016 um 03:57 schrieb Mikael Magnusson:
> You can have /usr/src/git/master, /usr/src/git/some-work-tree, etc,
> and /usr/src/git itself is not a git repository at all. That way
> /usr/src only has one git-related directory and no worktrees are
> nested.

I started using separate worktrees recently, and I chose the layout you 
sketch here. I didn't ask someone or read any documentation to find out 
about a recommended layout. I chose the layout because it felt the most 
natural.

Never in my life would I have considered nesting worktrees inside other 
worktrees.

-- Hannes
