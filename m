From: Abhijit Bhopatkar <bain@devslashzero.com>
Subject: Re: [RFC] Common library for Git GUIs
Date: Wed, 18 Feb 2009 11:32:04 +0530
Message-ID: <2fcfa6df0902172202n70c355dbg2a3f8ef50b9ea65c@mail.gmail.com>
References: <20090216212459.GA25046@efreet.light.src>
	 <74161B7F-A178-49CB-990D-DF7299235C58@frim.nl>
	 <20090217212145.GC2216@efreet.light.src>
	 <1976ea660902171738j777e0af3mbd3b8aae8d1e7aaf@mail.gmail.com>
	 <20090218055700.GE2216@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>, Pieter de Bie <pieter@frim.nl>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonas Fonseca <fonseca@diku.dk>,
	Marco Costalba <mcostalba@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Henk <henk_westhuis@hotmail.com>,
	tortoisegit-dev <tortoisegit-dev@googlegroups.com>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Feb 18 07:03:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZfX1-0000oF-UE
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 07:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbZBRGCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 01:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbZBRGCI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 01:02:08 -0500
Received: from qb-out-0506.google.com ([72.14.204.230]:28468 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbZBRGCG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 01:02:06 -0500
Received: by qb-out-0506.google.com with SMTP id q18so2608087qba.17
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 22:02:05 -0800 (PST)
Received: by 10.142.174.18 with SMTP id w18mr2971308wfe.24.1234936924805; Tue, 
	17 Feb 2009 22:02:04 -0800 (PST)
In-Reply-To: <20090218055700.GE2216@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110508>

>> I think TortoiseGit need C\C++ git library, which should be also used
>> by git itself. Otherwise, it is difficult sync with git.
>
> I don't mean to reimplement a single bit of what is implemented in git
> itself. I want to factor out some stuff that is above git, only useful for
> _graphical_ user interfaces.
>

Ah!!
Sorry i missed that detail in the orig long mail :(
I still don't think it making things simpler. What you are proposing
is yet one more abstraction. But me thinks cli abstraction is enough.

Abstractions at interface levels are usefull, abstractions at
functional level (gui's vs clis) are complex and don't solv anything.
BAIN
