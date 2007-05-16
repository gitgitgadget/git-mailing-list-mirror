From: Alon Ziv <alonz@nolaviz.org>
Subject: Re: MinGW port: some questions
Date: Wed, 16 May 2007 22:55:34 +0300
Message-ID: <1179345334.31213.48.camel@bruno.nolaviz.org>
References: <1179341520.31213.38.camel@bruno.nolaviz.org>
 <7vejlgegb9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 16 21:56:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoPbb-0003bs-E5
	for gcvg-git@gmane.org; Wed, 16 May 2007 21:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757902AbXEPTz4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 15:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757979AbXEPTz4
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 15:55:56 -0400
Received: from mxout4.netvision.net.il ([194.90.9.27]:20289 "EHLO
	mxout4.netvision.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757902AbXEPTzz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 15:55:55 -0400
Received: from mail.nolaviz.org ([194.90.198.244]) by mxout4.netvision.net.il
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTP id <0JI500HEUGP5ODC0@mxout4.netvision.net.il> for
 git@vger.kernel.org; Wed, 16 May 2007 22:55:54 +0300 (IDT)
Received: from localhost (localhost [127.0.0.1])	by mail.nolaviz.org (Postfix)
 with ESMTP id B1B3E2004795; Wed, 16 May 2007 22:55:53 +0300 (IDT)
Received: from mail.nolaviz.org ([127.0.0.1])
	by localhost (gardener.nolaviz.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15853-07; Wed, 16 May 2007 22:55:35 +0300 (IDT)
Received: from [192.168.0.17] (bruno.nolaviz.org [192.168.0.17])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)	by mail.nolaviz.org (Postfix)
 with ESMTP id 65CCD200477D; Wed, 16 May 2007 22:55:35 +0300 (IDT)
In-reply-to: <7vejlgegb9.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.10.1
X-Virus-Scanned: Debian amavisd-new at nolaviz.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47454>

On Wed, 2007-05-16 at 12:09 -0700, Junio C Hamano wrote:
> I do not know if you mistyped dc380d6 (I do not find it there),

I did; it was dc3806d.  I don't know how it slipped...  I usually
cut'n'paste commit IDs :-/

> but reverting 4493e36 (merge of jc/3way) was intentional.  The
> work in that commit that deviates from the mainline is the
> jc/3way topic, which turned out to be incomplete and not very
> usable.

I know it was intentional; but the revert happened on Feb 13, and the
MinGW port is supposed to be merged up to v1.5.1.  The revert of dc3806d
("in_merge_bases(): optimization") and 40e0e66 ("merge_base(): move
traversal into a separate function.") also happened on Feb 13, and both
of there commits are still present in the MinGW master branch.

Maybe I'll just try cherry-picking the port's commits on top of the
latest master, and see if anything breaks :)

	-az
