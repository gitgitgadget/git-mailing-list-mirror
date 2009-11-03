From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Mon, 2 Nov 2009 16:58:15 -0800
Message-ID: <20091103005815.GW10505@spearce.org>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com> <7vzl74trmc.fsf@alter.siamese.dyndns.org> <20091102235707.GV10505@spearce.org> <7vtyxctpf8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 01:59:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N57jf-00040c-Bc
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 01:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757548AbZKCA6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 19:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757451AbZKCA6M
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 19:58:12 -0500
Received: from george.spearce.org ([209.20.77.23]:55144 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757516AbZKCA6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 19:58:10 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 28019381FE; Tue,  3 Nov 2009 00:58:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vtyxctpf8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131939>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Junio C Hamano <gitster@pobox.com> wrote:
> > ...
> >> Shouldn't we say "the client MUST NOT make reference update request if
> >> everything is up to date" which would imply that in practice there is no
> >> reason to send an empty pack data?

Creating new branch quirk aside, I do agree with this.  Clients
shouldn't send no-op updates if it knows in advance the update is
a no-op.

-- 
Shawn.
