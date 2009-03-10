From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 16:14:04 +0100
Message-ID: <49B683BC.3030104@viscovery.net>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net> <20090310144646.GQ11989@spearce.org> <49B680F7.4040103@viscovery.net> <alpine.DEB.1.00.0903101605460.14295@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	gitster@pobox.com, Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 10 16:16:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh3gD-0005Dv-TH
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 16:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbZCJPOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 11:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbZCJPOM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 11:14:12 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38000 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbZCJPOL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 11:14:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lh3ef-00021v-8C; Tue, 10 Mar 2009 16:14:05 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DD6854FB; Tue, 10 Mar 2009 16:14:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0903101605460.14295@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112826>

Johannes Schindelin schrieb:
> On Tue, 10 Mar 2009, Johannes Sixt wrote:
>> I deliberatly avoided "%.*s" in the former hunk (1) because of the posts
>> that we had yesterday about potentially misbehaved fprintf in the case
>> where the precision is 0;
> 
> Didn't that turn out to be a false alarm?

Even better. I didn't follow the thread very closely.

> I think, indeed, that you can avoid the memcpy() by using %.*s.  The 
> private buffer is only used to make sure that the text is written in one 
> go anyway (i.e. that two sidebands messages are not written to the same 
> line because they use multiple calls to fprintf()/fwrite() per line), 
> right?

It must be something like that, yes. ;)

-- Hannes
