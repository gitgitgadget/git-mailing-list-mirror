From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: git-fast-import
Date: Wed, 07 Feb 2007 13:38:10 +0000
Message-ID: <1170855490.29759.1155.camel@pmac.infradead.org>
References: <20070206023111.GB9222@spearce.org> <45C81C33.6010704@gmail.com>
	 <20070206061817.GB10508@spearce.org>
	 <Pine.LNX.4.64.0702062347060.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 14:38:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEn06-0007EO-I5
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 14:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161296AbXBGNiP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 08:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161297AbXBGNiP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 08:38:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40912 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161296AbXBGNiO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 08:38:14 -0500
Received: from pmac.infradead.org ([81.187.2.168])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HEmzz-0007Qj-Gd; Wed, 07 Feb 2007 13:38:11 +0000
In-Reply-To: <Pine.LNX.4.64.0702062347060.20138@iabervon.org>
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38922>

On Tue, 2007-02-06 at 23:55 -0500, Daniel Barkalow wrote:
> It might be nice to have a git-fast-export, which could actually be 
> potentially useful for generating a repository with systematic differences 
> from the original. (E.g., to make a repository of git's Documentation 
> directory, with just the commits that affect it) 

That kind of thing isn't hard to do. See the scripts which create the
'JFFS2 for eCos' git tree or the 'exported kernel headers' git tree,
directly from Linus' git tree.

-- 
dwmw2
