From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] bash completion: git rm has grown a --force option
Date: Sat, 9 Aug 2008 03:07:35 +0200
Message-ID: <20080809010713.GF7299@neumann>
References: <1218235022-33695-1-git-send-email-pdebie@ai.rug.nl>
	<7v8wv7az0z.fsf@gitster.siamese.dyndns.org>
	<20080808234134.GH5655@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Lee Marlow <lee.marlow@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 03:08:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRcwp-0003Nw-49
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 03:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbYHIBHp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 21:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbYHIBHo
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 21:07:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:59078 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbYHIBHo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 21:07:44 -0400
Received: from [127.0.1.1] (p5B133490.dip0.t-ipconnect.de [91.19.52.144])
	by mrelayeu.kundenserver.de (node=mrelayeu4) with ESMTP (Nemesis)
	id 0ML21M-1KRcve0Lk6-0008JY; Sat, 09 Aug 2008 03:07:39 +0200
Content-Disposition: inline
In-Reply-To: <20080808234134.GH5655@inocybe.teonanacatl.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX184Gxs2KhX/J/QwXBHI0vTusZ/5HXbvemAtKyc
 NRsTOoD76LziIg5lsApsxiHtbSTXRWPqdTvZFhHxVHdJBYcTT2
 NVPelhexfuwnXk9Pd0Ibg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91735>

Hi,

On Fri, Aug 08, 2008 at 07:41:34PM -0400, Todd Zullinger wrote:
> Perhaps this is worth adding as well then, since Lee went to the
> trouble of adding completion for git rm just the other day? ;)
I disagree here.  '--force' is an option that should be used with
care, therefore facilitating its usage by completion support is not a
good idea IMHO.  This is also the status quo:  while there are many
git commands with a '--force' option, we do not complete any of them.

Regards,
G=E1bor
