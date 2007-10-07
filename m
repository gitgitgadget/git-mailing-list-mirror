From: David Brown <git@davidb.org>
Subject: Re: [StGit PATCH 4/8] Don't split long and short description in
	"stg edit"
Date: Sun, 7 Oct 2007 16:40:10 -0700
Message-ID: <20071007234009.GA19073@old.davidb.org>
References: <20071007231446.12626.14259.stgit@yoghurt> <20071007231735.12626.81744.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:40:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefjX-0006e3-Qs
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262AbXJGXkP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756191AbXJGXkO
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:40:14 -0400
Received: from mail.davidb.org ([66.93.32.219]:52332 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756086AbXJGXkN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:40:13 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IefjG-00052D-1x; Sun, 07 Oct 2007 16:40:10 -0700
Mail-Followup-To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071007231735.12626.81744.stgit@yoghurt>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60264>

On Mon, Oct 08, 2007 at 01:17:35AM +0200, Karl Hasselstr=F6m wrote:
>"stg edit" used to present the patch information like this:
>
>  Short description
>
>  From: ...
>  Date: ...
>
>  Long description
>
>If the project follows the git convention with a single-line short
>description and follwed by a blank line and the rest of the
>description, this merely looks a little odd. However, for projects
>that don't follow that convention, presenting the first line
>separately is actively inconvenient; for example, it breaks emacs's
>fill-paragraph command.

I think this fix is better to begin with.  I found it especially confus=
ing
when there was only a single line commit message.  Now the header looks
like a header :-)

David
