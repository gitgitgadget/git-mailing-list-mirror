From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Use git-add-file for unmerged files, remove git-resolve-file
Date: Wed, 09 Sep 2009 18:09:53 +0200
Message-ID: <87ocpk6qwe.fsf@wine.dyndns.org>
References: <4AA026AC.10907@gmail.com>
	<7vtyzdrq1h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Nordholts <enselic@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 18:10:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlPkY-0001OO-TK
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 18:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682AbZIIQKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 12:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbZIIQKA
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 12:10:00 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:40733 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbZIIQJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 12:09:59 -0400
Received: from adsl-84-227-126-171.adslplus.ch ([84.227.126.171] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1MlPk3-0005IM-W1; Wed, 09 Sep 2009 11:10:02 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 52EDC1E72A5; Wed,  9 Sep 2009 18:09:53 +0200 (CEST)
In-Reply-To: <7vtyzdrq1h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 08 Sep 2009 16:10:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
X-Spam-Score: -3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128072>

Junio C Hamano <gitster@pobox.com> writes:

> I do not know all the details of how Emacs keybinding works, but I had an
> impression that something-x sequence is triggered if you type something-X
> and you do not have an explicit binding for something-X but you do have a
> binding for something-x.
>
> IOW, if I only have
>
> 	(define-key global-map "\C-xc" 'compile)
>
> then both "\C-xc" and "\C-xC" runs "compile", but in addition to the
> above if I also have
>
> 	(define-key global-map "\C-xC" 'grep-find)
>
> then I can invoke these two commands with lower- and upper- case 'c/C'
> after control-x.
>
> If people have been relying on the historical behaviour that typing "R"
> marked the path resolved (which may internally have been implemented with
> whatever way), and if you are removing that binding, wouldn't that now
> expose them to whatever happens to be bound to "r"?

No, I don't claim to understand exactly how that works for the C-x case,
but it doesn't apply here, "r" and "R" are two different bindings.

-- 
Alexandre Julliard
julliard@winehq.org
