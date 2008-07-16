From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH,RFC] Implement 'git rm --if-missing'
Date: Wed, 16 Jul 2008 20:06:17 +0200
Message-ID: <20080716180617.GO32184@machine.or.cz>
References: <1216231250-21141-1-git-send-email-ciaran.mccreesh@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 20:07:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJBPL-0007Kv-4T
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 20:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbYGPSGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 14:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbYGPSGU
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 14:06:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39136 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbYGPSGT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 14:06:19 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id CF7CE1E4C025; Wed, 16 Jul 2008 20:06:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1216231250-21141-1-git-send-email-ciaran.mccreesh@googlemail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88703>

  Hi,

On Wed, Jul 16, 2008 at 07:00:50PM +0100, Ciaran McCreesh wrote:
> git rm --if-missing will only remove files if they've already been removed from
> disk.
> 
> Signed-off-by: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>

  what is the usage scenario? The porcelain options space is a precious
resource, so please explain why do you need this and who is going to use
it (especially with such a long name).


				Petr "Pasky" Baudis
