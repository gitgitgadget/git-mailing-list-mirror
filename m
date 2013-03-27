From: John Keeping <john@keeping.me.uk>
Subject: Re: git status takes 30 seconds on Windows 7. Why?
Date: Wed, 27 Mar 2013 17:22:17 +0000
Message-ID: <20130327172216.GO2286@serenity.lan>
References: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Kinsman <jakinsman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 18:22:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKu3p-0003Oh-HF
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab3C0RWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:22:25 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:50300 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab3C0RWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:22:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 4BE93CDA526;
	Wed, 27 Mar 2013 17:22:24 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eUs57xJd+lrF; Wed, 27 Mar 2013 17:22:22 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 51BFECDA5B2;
	Wed, 27 Mar 2013 17:22:18 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219288>

On Wed, Mar 27, 2013 at 11:39:31AM -0500, Jim Kinsman wrote:
> git status takes 30 seconds on Windows 7. Here are some stats:
> git ls-files | wc -l
> 27330
> 
> git ls-files -o | wc -l
> 4
> 
> $ git diff --name-only | xargs du -chs
> 68K     update_import_contacts.php
> 68K     total
> 
> What can I do??? This is so slow it is unbearable.
> By the way i've done git gc several times and nothing changed.

Can you run these commands under "time" so that we can see that it's
definitely the "git ls-files" taking 30 seconds and not something in
$PS1?
