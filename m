From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: git-gui and gitk-git as submodules (Re: [RFC PATCH 0/2] Teach
 	"git status" the "--ignore-submodules" option)
Date: Mon, 28 Jun 2010 15:55:30 -0400
Message-ID: <4C28FE32.80901@xiplink.com>
References: <4C24C34B.20403@web.de>	<7vlja3j7hu.fsf@alter.siamese.dyndns.org>	<20100625190147.GA17493@burratino> <AANLkTimqXhGw5fAAgZsoDAI9s6kaIzcka9mbFEW8j05v@mail.gmail.com> <4C25E83E.4080905@web.de> <4C28EA0A.3080804@xiplink.com> <4C28F130.2090904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 28 21:55:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTKQe-0002zb-Gf
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 21:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab0F1Tzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 15:55:35 -0400
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:43146 "EHLO
	smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab0F1Tze (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 15:55:34 -0400
Received: from relay25.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay25.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id B80E01B4E5A;
	Mon, 28 Jun 2010 15:55:31 -0400 (EDT)
Received: by relay25.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 582AD1B4E23;
	Mon, 28 Jun 2010 15:55:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <4C28F130.2090904@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149855>

On 10-06-28 03:00 PM, Jens Lehmann wrote:
> 
>>> 2) On "git clone" the submodules must be cloned and checked out too
>>>    (currently you have to do a "git submodule update --init" after
>>>    cloning the superproject).
>>
>> Making clone do this automatically would be a show-stopper for us.  The
>> current '--recursive' option is fine (though we never use it).
>>
>> It would be interesting if the super-project could configure which submodules
>> to automatically clone.
> 
> That's what I have in mind too. Maybe we could use the 'update' option of
> .gitmodules to clone all those submodules where it is set. Then different
> branches with different .gitmodules would behave differently.

That sounds fine to me.

Thanks again!

		M.
