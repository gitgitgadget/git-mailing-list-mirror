From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH (GIT-GUI)] git-gui: Request blame metadata in utf-8.
Date: Tue, 11 Nov 2008 09:35:49 -0800
Message-ID: <20081111173549.GL2932@spearce.org>
References: <200811091853.09498.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 18:37:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzxBC-0006mH-0y
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 18:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbYKKRfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 12:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbYKKRfu
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 12:35:50 -0500
Received: from george.spearce.org ([209.20.77.23]:33684 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbYKKRfu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 12:35:50 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 934CA381FF; Tue, 11 Nov 2008 17:35:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200811091853.09498.angavrilov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100660>

Alexander Gavrilov <angavrilov@gmail.com> wrote:
> The blame builtin now supports automatic conversion of
> metadata encoding. By default it is converted to the
> character set specified by i18n.logoutputencoding.
> 
> Since gui blame expects the data in utf-8, it is
> necessary to specify the desired encoding directly.
> An old version of the blame command will simply
> ignore the option.

Thanks; all 3 applied.
 
-- 
Shawn.
