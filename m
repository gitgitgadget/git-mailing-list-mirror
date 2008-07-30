From: Lars Noschinski <lars-2008-1@usenet.noschinski.de>
Subject: Re: Feature suggestion: git-hist
Date: Wed, 30 Jul 2008 15:33:34 +0200
Message-ID: <20080730133334.GB31192@lars.home.noschinski.de>
References: <20080730133859.368bbd92@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Jul 30 15:41:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOBvb-00075B-9q
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 15:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014AbYG3NkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 09:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbYG3NkS
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 09:40:18 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:41417 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771AbYG3NkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 09:40:17 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jul 2008 09:40:17 EDT
Received: from [87.78.68.8] (helo=vertikal.home.noschinski.de)
	by smtprelay11.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars-2008-1@usenet.noschinski.de>)
	id 1KOBo7-00022Z-K6; Wed, 30 Jul 2008 15:33:35 +0200
Received: from lars by vertikal.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars-2008-1@usenet.noschinski.de>)
	id 1KOBo6-0000DK-Il; Wed, 30 Jul 2008 15:33:34 +0200
Content-Disposition: inline
In-Reply-To: <20080730133859.368bbd92@pc09.procura.nl>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90784>

* H.Merijn Brand <h.m.brand@xs4all.nl> [08-07-30 13:38]:

>	I can ask them what version they have, and I can then check if
>	the complaint was already addressed in an update that was
>	already released. In SCCS this was easy: they tell me the output
>	of the what command, I check if the bug was fixed in a newer
>	version and the answer is present. No such luck in git, as the
>	stamps are (non-sequitive) SHA id's. As we moved to git, we now
>	have to update those id's by hand, as the customers are used to
>	it. (At least we can now use readable date formats)

Hm, what about "git-describe --contains $SHA_OF_BUGFIX"?
