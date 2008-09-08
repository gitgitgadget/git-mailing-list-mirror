From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Change checkout remotely.
Date: Mon, 8 Sep 2008 08:45:39 -0700
Message-ID: <20080908154539.GF10252@spearce.org>
References: <f5cc88f60809080842l34760997r4b821a79e7727d91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marcello Henrique <faraohh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 17:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kciww-0004eu-30
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 17:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbYIHPpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 11:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752830AbYIHPpl
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 11:45:41 -0400
Received: from george.spearce.org ([209.20.77.23]:42928 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbYIHPpk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 11:45:40 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EF97038360; Mon,  8 Sep 2008 15:45:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <f5cc88f60809080842l34760997r4b821a79e7727d91@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95264>

Marcello Henrique <faraohh@gmail.com> wrote:
> 
> Is it possible change checkout another work tree remotely and refresh all files?
> 
> For example: git remote other checkout other-branch-x

ssh otherhost cd otherdir '&&' git checkout other-branch-x

-- 
Shawn.
