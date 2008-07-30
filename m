From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: Feature suggestion: git-hist
Date: Wed, 30 Jul 2008 14:03:59 +0200
Message-ID: <8B01DD07-7A11-4855-94E6-822D901840E3@ai.rug.nl>
References: <20080730133859.368bbd92@pc09.procura.nl>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Jul 30 14:06:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOAQc-0002td-Uu
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 14:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbYG3MEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 08:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754501AbYG3MEO
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 08:04:14 -0400
Received: from frim.nl ([87.230.85.232]:47952 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754457AbYG3MEN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2008 08:04:13 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1KOAPY-0006JY-7l; Wed, 30 Jul 2008 14:04:08 +0200
In-Reply-To: <20080730133859.368bbd92@pc09.procura.nl>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90768>


On 30 jul 2008, at 13:38, H.Merijn Brand wrote:

> I've talked about this with Arjen, and he suggested to put it here.
> Please Cc me too, as I have little time to follow this quite busy  
> list.
>
> Suggestion
>
> 	Add a new command: 'git-hist' that will show a blame log of a
> 	single file with each line `tagged' with the most recent tag
> 	plus the number of changes since that tag.

You can do something almost similar with a command like:

	git blame -l Makefile | git name-rev --stdin --tags

- Pieter
