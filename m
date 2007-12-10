From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: [PATCH] Restore ls-remote reference pattern matching
Date: Mon, 10 Dec 2007 10:16:42 +0100
Message-ID: <5C669468-71F1-4E28-9E15-1EAA4893135F@orakel.ntnu.no>
References: <Pine.LNX.4.64.0712082134350.5349@iabervon.org> <7vodd0tuuu.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0712082346310.5349@iabervon.org> <7v8x44tl7q.fsf@gitster.siamese.dyndns.org> <20071209162632.a16bfd6e.vsu@altlinux.ru> <7vtzmrobrl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sergey Vlasov <vsu@altlinux.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 10:17:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1ell-0004Vt-JV
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 10:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbXLJJRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 04:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbXLJJRX
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 04:17:23 -0500
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:51800 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbXLJJRW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 04:17:22 -0500
Received: from [192.168.2.243] (pat-gw.osl.fast.no [217.144.235.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 7FDA562F52C;
	Mon, 10 Dec 2007 10:17:19 +0100 (CET)
In-Reply-To: <7vtzmrobrl.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67693>


On 9. des. 2007, at 21.26, Junio C Hamano wrote:

> Sergey Vlasov <vsu@altlinux.ru> writes:
>
>> This still does not match the behavior of the old shell  
>> implementation
>> completely - because $pat was not quoted, shell pattern characters in
>> $pat worked, and things like "git ls-remote . 'refs/heads/ 
>> something--*'"
>> were possible (and used in some of my scripts), so a full fnmatch()
>> call is still needed.
>
> Sigh...

This patch makes ls-remote work as expected for me.
-- 
Eyvind
