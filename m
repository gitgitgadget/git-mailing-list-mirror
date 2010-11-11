From: Gelonida <gelonida@gmail.com>
Subject: Re: git clone / git pull to USB memory stick (FAT) and symlinks
Date: Thu, 11 Nov 2010 19:10:20 +0100
Message-ID: <ibhbic$643$2@dough.gmane.org>
References: <ibh605$adm$1@dough.gmane.org> <7vk4kjhhjh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 19:15:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGbg3-0007Tx-IR
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 19:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639Ab0KKSPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 13:15:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:52855 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab0KKSPI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 13:15:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PGbft-0007O3-E1
	for git@vger.kernel.org; Thu, 11 Nov 2010 19:15:05 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 19:15:05 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 19:15:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 ""
In-Reply-To: <7vk4kjhhjh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161285>

On 11/11/2010 06:54 PM, Junio C Hamano wrote:
> Gelonida <gelonida@gmail.com> writes:
> If you do need a working tree on the stick, and the stick has a FAT
> derived filesystem (which would be the most common), then you would need
> 
>> git config --add core.fileMode false
> 
> and perhaps "core.symlinks false" also would help


Thanks:

Will try core.symlinks false
