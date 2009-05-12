From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Cross-Platform Version Control
Date: Tue, 12 May 2009 08:14:03 -0700
Message-ID: <20090512151403.GS30527@spearce.org>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Esko Luontola <esko.luontola@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 17:14:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3tgM-00080b-LD
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 17:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbZELPOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 11:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755958AbZELPOF
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 11:14:05 -0400
Received: from george.spearce.org ([209.20.77.23]:44083 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572AbZELPOE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 11:14:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D3839381D6; Tue, 12 May 2009 15:14:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118902>

Esko Luontola <esko.luontola@gmail.com> wrote:
> Are there any plans on storing the encoding information of file names  
> and commit messages in the Git repository?

Commit messages already store their encoding in an optional
"encoding" header if the message isn't stored in UTF-8, or
US-ASCII, which is a strict subset of UTF-8.

As for file names, no plans, its a sequence of bytes, but I think a
lot of people wind up using some subset of US-ASCII for their file
names, especially if their project is going to be cross platform.

-- 
Shawn.
