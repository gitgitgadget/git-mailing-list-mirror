From: Max Kirillov <max@max630.net>
Subject: Re: What's cooking in git.git (Aug 2015, #06; Mon, 31)
Date: Sun, 6 Sep 2015 15:15:37 +0300
Message-ID: <20150906121537.GA5073@wheezy.local>
References: <xmqqfv2zt576.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 14:15:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYYrQ-0007lT-FC
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 14:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbbIFMPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 08:15:49 -0400
Received: from p3plsmtpa09-05.prod.phx3.secureserver.net ([173.201.193.234]:35509
	"EHLO p3plsmtpa09-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751682AbbIFMPr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Sep 2015 08:15:47 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-05.prod.phx3.secureserver.net with 
	id DoFh1r0045B68XE01oFmHg; Sun, 06 Sep 2015 05:15:47 -0700
Content-Disposition: inline
In-Reply-To: <xmqqfv2zt576.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277424>

Hi.

On Mon, Aug 31, 2015 at 04:21:17PM -0700, Junio C Hamano wrote:
> * mk/utf8-no-iconv-warn (2015-06-08) 1 commit
>  - utf8.c: print warning about disabled iconv
> 
>  Warn when a reencoding is requested in a build without iconv
>  support, as the end user is likely to get an unexpected result.  I
>  think the same level of safety should be added to a build with
>  iconv support when the specified encoding is not available, but the
>  patch does not go there.
> 
>  Waiting for a reroll.

I think this can be dropped, I decided to use iconv anyway
so it's not needed for me anymore, and with the requested
additions it's getting too complicated.

-- 
Max
