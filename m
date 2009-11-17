From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH] Doc: mention the crlf attribute in config autocrlf section
Date: Tue, 17 Nov 2009 00:43:31 -0700
Message-ID: <20091117074330.GA2813@comcast.net>
References: <1258223700-4009-1-git-send-email-mmogilvi_git@miniinfo.net> <20091116195048.6117@nanako3.lavabit.com> <20091117035945.GA1728@comcast.net> <7v7htpirmy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 08:43:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAIix-00068R-W1
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 08:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755883AbZKQHn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 02:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755875AbZKQHn2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 02:43:28 -0500
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:56651
	"EHLO QMTA12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755834AbZKQHn1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2009 02:43:27 -0500
Received: from OMTA19.emeryville.ca.mail.comcast.net ([76.96.30.76])
	by QMTA12.emeryville.ca.mail.comcast.net with comcast
	id 67ij1d0031eYJf8AC7jaMy; Tue, 17 Nov 2009 07:43:34 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA19.emeryville.ca.mail.comcast.net with comcast
	id 67jZ1d0015FCJCg017jZlb; Tue, 17 Nov 2009 07:43:34 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 8CACC89115; Tue, 17 Nov 2009 00:43:31 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <7v7htpirmy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133074>

On Mon, Nov 16, 2009 at 10:37:09PM -0800, Junio C Hamano wrote:
> How about this?  I didn't touch the patch text (other than dropping
> trailing whitespaces).
> 
> commit ff68668695486b72b5f06146eddf85b70841088a
> Author: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
> Date:   Sat Nov 14 11:35:00 2009 -0700
> 
>     core.autocrlf documentation: mention the crlf attribute
>     
>     The description of the configuration variable is obsolete and
>     wrong (saying only file content is used), not just incomplete.
>     It has used the attribute mechanism for a long time.
>     
>     The documentation of gitattributes mentions the core.autocrlf
>     configuration variable in its description of crlf attribute.
>     Refer to the gitattributes documentation from here as well.
>     
>     Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks good.  Sorry about the extra space in the patch text;
stripping it sounds good as well.

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]
