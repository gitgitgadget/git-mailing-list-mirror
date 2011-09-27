From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] gitweb: Add js=1 before an URI fragment to fix line number
 links
Date: Tue, 27 Sep 2011 08:44:03 +0200
Message-ID: <4E8170B3.8040205@viscovery.net>
References: <1317060642-25488-1-git-send-email-peter@stuge.se> <7v62kf2jf4.fsf@alter.siamese.dyndns.org> <20110926194639.25339.qmail@stuge.se> <7vipof0zx0.fsf@alter.siamese.dyndns.org> <20110926222801.14985.qmail@stuge.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Peter Stuge <peter@stuge.se>
X-From: git-owner@vger.kernel.org Tue Sep 27 08:44:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8ROq-0008P4-EA
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 08:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170Ab1I0GoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 02:44:12 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:57897 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751052Ab1I0GoL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 02:44:11 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R8ROe-0003m4-El; Tue, 27 Sep 2011 08:44:04 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2AD191660F;
	Tue, 27 Sep 2011 08:44:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.22) Gecko/20110902 Thunderbird/3.1.14
In-Reply-To: <20110926222801.14985.qmail@stuge.se>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182214>

Am 9/27/2011 0:28, schrieb Peter Stuge:
> Junio C Hamano wrote:
>> You don't have to explain these to *me* specifically as a response
>> to this thread. What I meant was that your patch should have these
>> necessary descriptions in its proposed commit log message.
> 
> IMO not so neccessary if one knows a little web and javascript, which
> is probably likely for a gitweb change..
> 
> It's a simple fix of links broken by manual URI manipulation that
> didn't consider fragments. Is the subject description really not
> enough?

No, it is not. The target audience of a commit message are people like I
am. I do know a bit of Perl, and a bit of Javascript; I know how an URL is
structured; I would find my way through the gitweb code if the need
arises. But I am not an expert in any of these areas.

The subject alone is not sufficient because I do not know for sure what an
"URI fragment" is or what role line numbers in gitweb's links play. The
explanations and examples you gave in a later email were very
enlightening, and they would be very helpful if *I* am forced to hack
gitweb, and if I need to understand why this particular change was good.

Finding the right balance between verbosity and terseness needs practice,
but to write *no* justification is practically always wrong.

-- Hannes
