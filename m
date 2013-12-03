From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v2] gitk: make pointer selection visible in highlighted
 lines
Date: Tue, 3 Dec 2013 02:35:10 +0200
Message-ID: <20131203003434.GA18541@wheezy.local>
References: <20131201224132.GB12576@iris.ozlabs.ibm.com>
 <1ld8zlh.1h4guajnkaralM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Paul Mackerras <paulus@samba.org>,
	Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Tue Dec 03 01:35:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VndxX-0003aK-8q
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 01:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab3LCAfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 19:35:22 -0500
Received: from p3plsmtpa08-03.prod.phx3.secureserver.net ([173.201.193.104]:54038
	"EHLO p3plsmtpa08-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556Ab3LCAfV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Dec 2013 19:35:21 -0500
Received: from wheezy.local ([89.27.29.195])
	by p3plsmtpa08-03.prod.phx3.secureserver.net with 
	id wobB1m0014CavkR01obHza; Mon, 02 Dec 2013 17:35:21 -0700
Content-Disposition: inline
In-Reply-To: <1ld8zlh.1h4guajnkaralM%lists@haller-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238669>

On Mon, Dec 02, 2013 at 11:04:09AM +0100, Stefan Haller wrote:
> I don't think that not selecting the search hint is an
> option: the selection is used to keep track of where to
> search next.

To mark the next found position, should a 0-length selection
be enough? I will try to experiment with it.

> Can't we just raise the currentsearchhit tag above the sel
> tag?

This also seems to help, as far as I understod
currentsearchhit is always removed as interactive selection
starts, so it should not hide manual selection.

-- 
Max
