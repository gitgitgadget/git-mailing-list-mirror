From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: catch mkdtemp errors
Date: Fri, 27 Jun 2014 16:58:42 +1000
Message-ID: <20140627065842.GA21103@iris.ozlabs.ibm.com>
References: <1403146394-9589-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 08:59:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Q8E-00074f-V0
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 08:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbaF0G7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 02:59:31 -0400
Received: from ozlabs.org ([103.22.144.67]:59819 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724AbaF0G7a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 02:59:30 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id D65671400DE; Fri, 27 Jun 2014 16:59:28 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <1403146394-9589-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252534>

On Wed, Jun 18, 2014 at 07:53:14PM -0700, David Aguilar wrote:
> 105b5d3fbb1c00bb0aeaf9d3e0fbe26a7b1993fc introduced a dependency
> on mkdtemp, which is not available on Windows.
> 
> Use the original temporary directory behavior when mkdtemp fails.
> This makes the code use mkdtemp when available and gracefully
> fallback to the existing behavior when it is not available.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: David Aguilar <davvid@gmail.com>

Thanks, applied (with slight modification to commit message).

Paul.
