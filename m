From: Andreas Ericsson <ae@op5.se>
Subject: Re: know wget URL, need git-clone URL
Date: Thu, 27 Nov 2008 10:00:22 +0100
Message-ID: <492E61A6.5060800@op5.se>
References: <87bpw1hkqx.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, smartphones-userland@linuxtogo.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Thu Nov 27 10:01:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5ckv-0000nY-1Q
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 10:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbYK0JAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 04:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555AbYK0JAc
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 04:00:32 -0500
Received: from mail.op5.se ([193.201.96.20]:35329 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbYK0JAc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 04:00:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7BA671B8145E;
	Thu, 27 Nov 2008 09:56:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vA9nDd-V7z8T; Thu, 27 Nov 2008 09:56:15 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 2AD031B8145D;
	Thu, 27 Nov 2008 09:56:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
In-Reply-To: <87bpw1hkqx.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101799>

jidanni@jidanni.org wrote:
> I wish the git beginner documentation would tell one how to translate
> e.g., http://git.debian.org/?p=pkg-fso/files.git&a=blob_plain&f=install.sh
> which is good for wget, to the URL one needs for git-clone to get the
> same file.

You can't use "git clone" to get a single file. You can only get the
entire repository using "git clone". Usually, the clone-url is written
somewhere on the projects gitweb page, and that is also the case for
this repository.

If you visit http://git.debian.org/?p=pkg-fso/files.git;a=summary you'll
find this section on that page:

URL	git://git.debian.org/git/pkg-fso/files.git
	http://git.debian.org/git/pkg-fso/files.git

It's impossible to infer the clone url from the gitweb url, because there's
absolutely no connection between them (that will change if gitweb gains
fetch/clone support), and the paths/urls depends on the servers configuration
which we cannot know.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
