From: "Mikhail T." <mi+thun@aldan.algebra.com>
Subject: Re: How to fork a file (git cp ?)
Date: Thu, 05 May 2011 15:31:22 -0400
Message-ID: <4DC2FB0A.2090100@aldan.algebra.com>
References: <4DC1934D.6070608@aldan.algebra.com> <4DC19955.7040503@kdbg.org> <7viptqdvrf.fsf@alter.siamese.dyndns.org> <4DC20461.4090703@aldan.algebra.com> <7v1v0ddhbz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:31:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4Gs-0004Rm-Pt
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668Ab1EETba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 15:31:30 -0400
Received: from smtp11.lnh.mail.rcn.net ([207.172.157.101]:61942 "EHLO
	smtp01.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752586Ab1EETb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 15:31:29 -0400
Received: from mr16.lnh.mail.rcn.net ([207.172.157.36])
  by smtp02.lnh.mail.rcn.net with ESMTP; 05 May 2011 15:31:24 -0400
Received: from smtp04.lnh.mail.rcn.net (smtp04.lnh.mail.rcn.net [207.172.157.104])
	by mr16.lnh.mail.rcn.net (MOS 4.2.3-GA)
	with ESMTP id BBH34737;
	Thu, 5 May 2011 15:31:23 -0400
X-Auth-ID: anat
Received: from 209-6-61-133.c3-0.sbo-ubr1.sbo.ma.cable.rcn.com (HELO [192.168.1.8]) ([209.6.61.133])
  by smtp04.lnh.mail.rcn.net with ESMTP; 05 May 2011 15:31:23 -0400
User-Agent: Mozilla/5.0 (X11; U; FreeBSD amd64; uk-UA; rv:1.9.2.12) Gecko/20101114 Thunderbird/3.1.6
In-Reply-To: <7v1v0ddhbz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172890>

On 04.05.2011 22:14, Junio C Hamano wrote:
> I think that is what exactly "blame -C -C" gives you.
For that to be useful, one has to suspect, the file was derived by 
copying something else... Simple "git log" will not suggest that -- 
unless the commit message, that adds the new copy of a file points to it...

On 05.05.2011 14:02, Piotr Krukowiecki wrote:
> Maybe Mikhail wanted to say that if there's a git-mv as a shortcut for
>    "cp old new ; rm old; add new"
git-mv preserves the old's change-history in new, so it is more than the 
above, is not it?
> then there should be a git-cp as a shortcut for
Yes...

    -mi
