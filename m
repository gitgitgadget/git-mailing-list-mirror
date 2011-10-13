From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git attributes ignored for root directory
Date: Thu, 13 Oct 2011 15:16:25 +0200
Message-ID: <4E96E4A9.8030708@viscovery.net>
References: <4E8B55FB.1050203@svario.it> <4E8C481A.1070808@alum.mit.edu> <7vd3eb8hkb.fsf@alter.siamese.dyndns.org> <4E961626.4030201@alum.mit.edu> <7vfwix7qk2.fsf@alter.siamese.dyndns.org> <4E96C220.5050601@svario.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
X-From: git-owner@vger.kernel.org Thu Oct 13 15:16:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REL9M-0000a1-PV
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 15:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054Ab1JMNQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 09:16:36 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4295 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751177Ab1JMNQf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 09:16:35 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1REL9B-0005WX-5I; Thu, 13 Oct 2011 15:16:29 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 556111660F;
	Thu, 13 Oct 2011 15:16:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <4E96C220.5050601@svario.it>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183480>

Am 10/13/2011 12:49, schrieb Gioele Barabucci:
> I see that `/*/` in `.gitignores` successfully ignores all the non-hidden
> directories in the root project directory. Another accidental success? :)

No, that's by design. The first slash means "apply only in this directory,
not any subdirectories", and the slash at the end means "match only if the
name is a directory".

-- Hannes
