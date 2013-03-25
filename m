From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 3/3] t7800: run --dir-diff tests with and without symlinks
Date: Mon, 25 Mar 2013 11:59:12 +0100
Message-ID: <51502E00.7070904@viscovery.net>
References: <cover.1363980749.git.john@keeping.me.uk> <cover.1364045138.git.john@keeping.me.uk> <cf71cc8757c7cb59e93d762fba922635c077376d.1364045138.git.john@keeping.me.uk> <514FFC3C.3010203@viscovery.net> <20130325103516.GC2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Mar 25 11:59:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK57z-0000T0-RI
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 11:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999Ab3CYK7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 06:59:20 -0400
Received: from so.liwest.at ([212.33.55.24]:20178 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180Ab3CYK7U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 06:59:20 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UK57S-0006uK-Ni; Mon, 25 Mar 2013 11:59:14 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6F7CA1660F;
	Mon, 25 Mar 2013 11:59:12 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130325103516.GC2286@serenity.lan>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219028>

Am 3/25/2013 11:35, schrieb John Keeping:
> On Mon, Mar 25, 2013 at 08:26:52AM +0100, Johannes Sixt wrote:
>> The series looks good, but I can't test it because it does not apply
>> anywhere here.
> 
> It's built on top of da/difftool-fixes, is there some problem that stops
> it applying cleanly on top of that?

Thanks. I had only tried trees that were "contaminated" by
jk/difftool-dir-diff-edit-fix, which is in conflict with da/difftool-fixes.

t7800 passes on Windows with these patches.

-- Hannes
