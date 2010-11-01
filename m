From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: A confusing usage of the term 'successor' in the git glossary
Date: Mon, 01 Nov 2010 09:38:07 +0100
Message-ID: <4CCE7C6F.9030808@drmicha.warpmail.net>
References: <AANLkTimtYGKJUG94c4qFGropVOAgCOHgX5uo8XmWRNvW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lee Doolan <lee.doolan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 09:41:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCpxA-00087H-5s
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 09:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420Ab0KAIhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 04:37:45 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48111 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753516Ab0KAIho (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Nov 2010 04:37:44 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9335EA6D;
	Mon,  1 Nov 2010 04:37:43 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 01 Nov 2010 04:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=r4wQok0dPJgDknzlzHrDSGLAeY8=; b=dPRc+N//jKtM2b8DbAdTJfPZYH/YrQ0D+79yJgJ387WjGaVt2ACmz7h40XKLM95Td7ObNFGMYcc3p9sA/jljV0OdOaVfPdkAw+EH60Te1vFuuYAA62YIAgTKYVfAbDDKtqFx01kRKRtwD08e4dqkZB9uotkOz95rXSqhbXNC8cw=
X-Sasl-enc: Sn38+w6Vo/QM+tEih0kMvROCx2bOxtns7/MDrvCG28Bk 1288600663
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1DF655E91F3;
	Mon,  1 Nov 2010 04:37:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <AANLkTimtYGKJUG94c4qFGropVOAgCOHgX5uo8XmWRNvW@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160470>

Lee Doolan venit, vidit, dixit 31.10.2010 19:06:
> In the gitglossary
> (http://www.kernel.org/pub/software/scm/git/docs/gitglossary.html) I
> see this:
> ,----
> | chain
> |
> | A list of objects, where each object in the list contains a reference
> | to its successor (for example, the successor of a commit could be one
> | of its parents).
> `----
> 
> 
> don't you mean predecessor instead of successor?

In graph-theoretical terms, this is correct. Each commit contains
"pointers" (directed edges, arcs) pointing towards the parents. (There's
no way to point to children.) You can walk the graph only along directed
edges, i.e. towards parents. In that sense "parent" commits are the
successors (in the graph) of their "children".

So, there's an unavoidable conflict between the term in the underlying
data structure (directed acyclic tree) and the data it represents if you
thing of the latter as "childrenship" instead of "parentship".

Michael
