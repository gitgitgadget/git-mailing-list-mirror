From: John Keeping <john@keeping.me.uk>
Subject: Re: .gitignore behavior on Mac
Date: Sat, 18 May 2013 19:55:07 +0100
Message-ID: <20130518185507.GI27005@serenity.lan>
References: <CAEe6bfD_1GjMBByaEFQ4RMTMaz8XZvd00mxyfaAHtXVpbUjj6A@mail.gmail.com>
 <20130518184136.GH27005@serenity.lan>
 <CAEe6bfB30aD0LcgR4fzLy=xJGwzASJpgfvvtoTmFmJ1_2HZ4Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Lauri <peterlauri@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 18 20:55:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdmI2-0000GB-3A
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 20:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab3ERSzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 14:55:16 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:58817 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab3ERSzP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 14:55:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 7A56CCDA566;
	Sat, 18 May 2013 19:55:14 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id syHTpkheVBHJ; Sat, 18 May 2013 19:55:12 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id C31F0CDA5DA;
	Sat, 18 May 2013 19:55:12 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id B675D161E325;
	Sat, 18 May 2013 19:55:12 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r064PDS6mOmG; Sat, 18 May 2013 19:55:12 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id BD469161E3F7;
	Sat, 18 May 2013 19:55:09 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAEe6bfB30aD0LcgR4fzLy=xJGwzASJpgfvvtoTmFmJ1_2HZ4Jg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224805>

On Sat, May 18, 2013 at 08:43:57PM +0200, Peter Lauri wrote:
> But I just don't want to see that darn file. It is a config file that
> I have changed, and I don't want to need to stash it for each "git
> svn" action I want to perform... Any solution for that?

Read about --assume-unchanged in git-update-index(1).
