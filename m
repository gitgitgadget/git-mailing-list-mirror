From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 3/3] Makefile: add commented out 's for Emacs here, too
Date: Sun, 31 May 2009 00:01:43 +0200
Message-ID: <200905310001.44532.markus.heidelberg@web.de>
References: <1243289231-32500-1-git-send-email-naesten@gmail.com> <200905301505.38016.markus.heidelberg@web.de> <7vr5y6z9xp.fsf@alter.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Samuel Bronson <naesten@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 00:01:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAWcj-0003Sk-AR
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 00:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbZE3WBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 18:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbZE3WBo
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 18:01:44 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:52785 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbZE3WBn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 18:01:43 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 10E19FE7991D;
	Sun, 31 May 2009 00:01:45 +0200 (CEST)
Received: from [89.59.100.180] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MAWca-0000xF-00; Sun, 31 May 2009 00:01:44 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7vr5y6z9xp.fsf@alter.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19lwqPGPq53R/9TNEsv70Ps8KOvbq/RUCZGlE80
	bm0xFEVrUdOGNlHlwZW2TNDfoVLhZMBLUqK0DA+YUUGSy15kPY
	oq+rtfKl3NNkv0TDUU8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, 30.05.2009:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> >> +# unconfuse Emacs: '
> >> +
> >> +# The above comment is in case there is an odd number of _SQ
> >> +# definitions above, since they seem to confuse Emacs. If there is an
> >> +# even number of such definitions, it does no harm, since emacs
> >> +# doesn't recognize string delimiters inside recognized comments.
> > ...
> > I think this is way too much comment and would prefer none at all. I
> > also would remove the global 4-line comment.
> 
> I personally do not like contaminating our source files with this kind of
> magic crufts just to please broken tools [...]

Neither do I like it. That's why I wrote, I wasn't sure whether this
should be applied.

In the buildroot project (it consists of Makefiles) there a lots of
those workarounds. There was a patch on the list to replace all
$(strip $(subst ",,$(FOO))) with $(call strip_dquotes, $(FOO)), but
$(call) is not allowed in git for compatibility reasons.

Markus
