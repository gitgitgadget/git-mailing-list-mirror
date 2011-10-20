From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How to verify that lines were only moved, not edited?
Date: Thu, 20 Oct 2011 08:25:09 +0200
Message-ID: <4E9FBEC5.2000407@viscovery.net>
References: <4E9EDFEC.3040009@viscovery.net> <7vvcrkdi59.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 08:25:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGm48-0003tk-IG
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 08:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243Ab1JTGZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 02:25:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:13797 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954Ab1JTGZM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 02:25:12 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RGm3y-0005K4-Cv; Thu, 20 Oct 2011 08:25:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 272CB1660F;
	Thu, 20 Oct 2011 08:25:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <7vvcrkdi59.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184008>

Am 10/19/2011 19:07, schrieb Junio C Hamano:
> When reviewing a "supposedly move-only" change, I typically just grab +/-
> blocks from the patch, remove the +/- prefix and run comparison between
> them.

Thanks. As I explained to Jeff, I don't have a block-move, but the sort
order of a block of lines was changed "in place". It seems I have to fall
back to a similarly manual method as well (e.g., compare the
whole-file-sorted versions of the pre- and the post-image).

-- Hannes
