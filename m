From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: segfault bug in internal git grep from next (fixed)
Date: Thu, 4 May 2006 10:44:18 +0200
Message-ID: <20060504084418.GA10195@fiberbit.xs4all.nl>
References: <20060503083229.GA15579@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Thu May 04 10:44:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbZRi-00040D-HP
	for gcvg-git@gmane.org; Thu, 04 May 2006 10:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWEDIoU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 04:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWEDIoU
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 04:44:20 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:20401 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751149AbWEDIoU
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 4 May 2006 04:44:20 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.62)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1FbZRa-0002gJ-UZ
	for git@vger.kernel.org; Thu, 04 May 2006 10:44:18 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060503083229.GA15579@fiberbit.xs4all.nl>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19558>

On Wednesday May 3rd 2006 Marco Roeland wrote:

> I'm using the next branch as of commit 6a40327d242dac9f85c6d63c94d537b45ba86e89
> 
> A segfault occurs in using the new builtin grep when using it on a
> binary file, so no regular \n endings.

Fixed by Junio in commit 7ed36f56e33bd838d06521a37a916516397e9e8b.

I really use git grep a lot. It is very powerful, and the builtin version
makes even more possible. Thanks very much,
-- 
Marco Roeland
