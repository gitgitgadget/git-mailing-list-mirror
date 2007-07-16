From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] contrib/emacs/vc-git.el: various improvements.
Date: Mon, 16 Jul 2007 07:26:26 +0200
Message-ID: <85odicor5p.fsf@lola.goethe.zz>
References: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
	<7vejj9avaf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 07:26:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAJ6b-0001he-Gl
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 07:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbXGPF0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 01:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbXGPF0d
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 01:26:33 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:57858 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751351AbXGPF0c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 01:26:32 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 7EA232CAF61;
	Mon, 16 Jul 2007 07:26:31 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 7094A2DAABA;
	Mon, 16 Jul 2007 07:26:31 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-038-062.pools.arcor-ip.net [84.61.38.62])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 4EB9435E5A8;
	Mon, 16 Jul 2007 07:26:31 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BD5B91CE30E9; Mon, 16 Jul 2007 07:26:26 +0200 (CEST)
In-Reply-To: <7vejj9avaf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sun\, 15 Jul 2007 20\:20\:56 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91/3679/Mon Jul 16 04:44:42 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52639>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> (vc-git-previous-version): Simplify.
>> (vc-git-next-version): Simplify and make more efficient.
>
> If you make the result symbolic using vc-git-symbolic-commit, do you
> need to add --abbrev/--abbrev-commit to these functions?  These
> options have very small but still non zero cost.

vc-git-symbolic-commit may not always find a name (at least it did not
while I still used --tags).  The abbrev provides a fallback in that
case.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
