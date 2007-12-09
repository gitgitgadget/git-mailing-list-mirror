From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: [PATCH] Restore ls-remote reference pattern matching
Date: Sun, 9 Dec 2007 16:31:21 +0100
Message-ID: <02ECE8E0-3D11-47AE-9875-69D0CEA34453@orakel.ntnu.no>
References: <Pine.LNX.4.64.0712082134350.5349@iabervon.org> <7vodd0tuuu.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0712082346310.5349@iabervon.org> <7v8x44tl7q.fsf@gitster.siamese.dyndns.org> <20071209162632.a16bfd6e.vsu@altlinux.ru>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Sun Dec 09 16:32:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1O8T-0004rn-Pw
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 16:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbXLIPbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 10:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbXLIPbX
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 10:31:23 -0500
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:61157 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbXLIPbW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 10:31:22 -0500
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 2069A62EC07;
	Sun,  9 Dec 2007 16:31:21 +0100 (CET)
In-Reply-To: <20071209162632.a16bfd6e.vsu@altlinux.ru>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67626>

On 9. des.. 2007, at 14.26, Sergey Vlasov wrote:
> This still does not match the behavior of the old shell implementation
> completely - because $pat was not quoted, shell pattern characters in
> $pat worked, and things like "git ls-remote . 'refs/heads/something-- 
> *'"
> were possible (and used in some of my scripts), so a full fnmatch()
> call is still needed.


The example in the ls-remote manpage ("git ls-remote --tags <remote> v 
\*") also fails because of this.

Eyvind Bernhardsen
