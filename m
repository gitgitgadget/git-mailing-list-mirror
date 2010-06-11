From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC] ll-merge: Normalize files before merging
Date: Fri, 11 Jun 2010 09:51:41 +0200
Message-ID: <4C11EB0D.20208@viscovery.net>
References: <1276202894-11805-1-git-send-email-eyvind.bernhardsen@gmail.com> <4C11CE75.7080706@viscovery.net> <4C11E717.4070508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 09:52:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMz24-0002my-4X
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 09:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758079Ab0FKHvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 03:51:46 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:15710 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab0FKHvp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 03:51:45 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OMz1i-0008MQ-G4; Fri, 11 Jun 2010 09:51:42 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3DC901660F;
	Fri, 11 Jun 2010 09:51:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4C11E717.4070508@gmail.com>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148930>

Am 6/11/2010 9:34, schrieb Eyvind Bernhardsen:
> On 11. juni 2010 07:49, Johannes Sixt wrote:
>> I think you are going overboard here. Normalization should only happen
>> only for data that moves from the worktree to the database. But during a
>> merge, at most one part can come from the worktree, methinks; you are
>> normalizing all three of them, though.
> 
> Well, that's sort of the point.  All three are normalized to (hopefully)
> minimize the differences between them, increasing the chance of a
> successful merge.

I know what your point is. It is still inappropriate to call
normalize_file() on data that comes from the repository. It is not the
task of a merge procedure to blindly normalize data.

-- Hannes
