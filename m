From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 19:33:11 +0100
Message-ID: <vpqtxc49o60.fsf@anie.imag.fr>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CACsJy8Bsc6sywL9L5QC-SKKmh9J+CKnoG5i78WfUbAG9BdZ8Rw@mail.gmail.com>
	<CAHOQ7J8gvwpwJV2mBPDaARu3cQ54-ZDQ6iGOwKuJRr9Z+XBL7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Wed Feb 12 19:33:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDece-0002dD-9f
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 19:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbaBLSdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 13:33:20 -0500
Received: from mx1.imag.fr ([129.88.30.5]:34738 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226AbaBLSdT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 13:33:19 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s1CIX9Ba009880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Feb 2014 19:33:09 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1CIXD8n012957;
	Wed, 12 Feb 2014 19:33:13 +0100
In-Reply-To: <CAHOQ7J8gvwpwJV2mBPDaARu3cQ54-ZDQ6iGOwKuJRr9Z+XBL7g@mail.gmail.com>
	(Stefan Zager's message of "Wed, 12 Feb 2014 10:12:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Feb 2014 19:33:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1CIX9Ba009880
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1392834791.09126@CcwnHiHMjwsD15XkfgacQQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242005>

Stefan Zager <szager@chromium.org> writes:

> I'm optimistic that parallelizing the stat calls will yield a further
> improvement.

It has already been mentionned in the thread, but in case you overlooked
it: did you look at core.preloadindex? It seems at least very close to
what you want.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
