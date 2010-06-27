From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3] git-rev-parse.txt: Document ":path" specifier
Date: Sun, 27 Jun 2010 21:41:54 +0200
Message-ID: <4C27A982.9080006@drmicha.warpmail.net>
References: <7vpqzfj8zi.fsf@alter.siamese.dyndns.org> <6af64ac563a9a165bec7fddc779b31ae5bcb9997.1277644307.git.git@drmicha.warpmail.net> <7vocewff4b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 21:41:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSxjj-0005Dd-Tx
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 21:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655Ab0F0Tlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 15:41:45 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54621 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754088Ab0F0Tlo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jun 2010 15:41:44 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3C3B41079DD;
	Sun, 27 Jun 2010 15:41:43 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 27 Jun 2010 15:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=LI+t7fWUSTqD3N2U8EjRuJbvHqk=; b=cMUsstV3H2P3IqiByd97PcPrSlOzg06YuNNpPWmlXU0zNHT5UIP3dWWeker+Kws7KYxVBIANJzetNfDUTj99GMlQoyQb7xSYVxCKYM2KVOD3YLyOdy6mCEMbO25BuYPMqmIxPiZn7BJYL9rU0eDy6rK8+ZmkRt2KcNu8R6pCOzM=
X-Sasl-enc: AJZqOgCHRJgFHuj3RtA/KhEW3drh6m6Iwx3iZKBSOM6k 1277667702
Received: from localhost.localdomain (p54859121.dip0.t-ipconnect.de [84.133.145.33])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2EE135C3B6;
	Sun, 27 Jun 2010 15:41:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100625 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <7vocewff4b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149801>

Junio C Hamano venit, vidit, dixit 27.06.2010 21:29:
> Thanks, will replace v2 with this versoin, but I suspect that swapping the
> two bullets in the existing documentation without anything else may be a
> simpler and easier-to-read alternative.
> 
> Orthogonal to this, it would probably make sense to give a simplest
> example in-line in the text, i.e.
> 
>  Documentation/git-rev-parse.txt |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 8db600f..c03f31d 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -291,12 +291,12 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
>  
>  * A suffix ':' followed by a path; this names the blob or tree
>    at the given path in the tree-ish object named by the part
> -  before the colon.
> +  before the colon (e.g. "HEAD:README").

Yep, I think the whole discussion there is quite theoretical, often
describing symbols like slash and colon by words rather then writing
them out. That could be the topic for a more extensive rewrite. But I'm
often wondering whether git-rev-parse(1) really is the place for that,
or whether the whole revision syntax should into, say, gitrevision, to
go with gitglossary etc.

Michael
