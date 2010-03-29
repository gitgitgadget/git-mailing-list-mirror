From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH 1/5] convert: Safer handling of $Id$ contraction.
Date: Mon, 29 Mar 2010 14:46:23 +0200
Message-ID: <20100329124623.GD22480@cuci.nl>
References: <cover.1269860022.git.grubba@grubba.org>
 <a75a46b1b6fdb9d52f608643676512e87474e16d.1269860022.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Henrik Grubbstr??m (Grubba)" <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 14:56:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwEWM-00023W-64
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 14:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534Ab0C2M4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 08:56:37 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:59510 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab0C2M4g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 08:56:36 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 3A7E25443; Mon, 29 Mar 2010 14:46:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a75a46b1b6fdb9d52f608643676512e87474e16d.1269860022.git.grubba@grubba.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143466>

Henrik Grubbstr??m (Grubba) wrote:
>The code to contract $Id:xxxxx$ strings could eat an arbitrary amount
>of source text if the terminating $ was lost. It now refuses to
>contract $Id:xxxxx$ strings spanning multiple lines.

Looks good.

Acked-By: Stephen R. van den Berg <srb@cuci.nl>
-- 
Stephen.
