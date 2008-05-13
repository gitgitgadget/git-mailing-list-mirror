From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] Documentation/git-gc.txt: change --aggressive description
Date: Tue, 13 May 2008 13:13:08 +0200
Message-ID: <3A0C16C0-601C-408E-BD48-7DB783586C20@ai.rug.nl>
References: <1210672413-8761-1-git-send-email-pdebie@ai.rug.nl> <20080513105728.GA3088@mithlond.arda.local>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue May 13 13:14:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvsSH-0000ft-FF
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 13:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbYEMLNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 07:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbYEMLNM
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 07:13:12 -0400
Received: from smtp-2.orange.nl ([193.252.22.242]:28917 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbYEMLNL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 07:13:11 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6103.orange.nl (SMTP Server) with ESMTP id 2E5371C00086;
	Tue, 13 May 2008 13:13:10 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6103.orange.nl (SMTP Server) with ESMTP id E23011C00085;
	Tue, 13 May 2008 13:13:09 +0200 (CEST)
X-ME-UUID: 20080513111309926.E23011C00085@mwinf6103.orange.nl
In-Reply-To: <20080513105728.GA3088@mithlond.arda.local>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82018>


On 13 mei 2008, at 12:57, Teemu Likonen wrote:
> This patch might be a good thing. But from ordinary user's point of  
> view
> this raises questions: if gc --aggressive really is not that  
> aggressive
> then the option itself is misleading. Why not change gc --aggressive  
> to
> be really effective? Using high --window/--depth value etc.

The problem is that you don't know what is aggressive for this  
repository; that is relative to how it was previously packed.

I'd much rather change --aggressive to something like --rebuild, which  
describes much better what it does. However, I don't think it's easy  
to just rename a flag, as scripts may depend on it.

- Pieter
