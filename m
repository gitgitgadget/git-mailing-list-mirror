From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Better cooperation between checkouts and stashing
Date: Wed, 03 Mar 2010 16:55:35 +0100
Message-ID: <4B8E8677.8060003@web.de>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de> <7v1vg4ufas.fsf@alter.siamese.dyndns.org> <4b8c0420.5544f10a.2eb2.ffffb4c4@mx.google.com> <7vk4tvsu6x.fsf@alter.siamese.dyndns.org> <4B8C2F90.8080104@web.de> <b4087cc51003011741w29023914wec78f9acd6efb516@mail.gmail.com> <4B8CDBCA.4030101@web.de> <7vvdde62ai.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 16:55:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmqvN-0007cN-RD
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 16:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908Ab0CCPzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 10:55:44 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:53321 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab0CCPzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 10:55:43 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 934B6141B35A3;
	Wed,  3 Mar 2010 16:55:42 +0100 (CET)
Received: from [78.48.6.0] (helo=[192.168.1.2])
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1NmqvF-0000wQ-00; Wed, 03 Mar 2010 16:55:42 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7vvdde62ai.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX18srEREJ18Fk2UcJWzJAqdZVrlzKiU1YEiRzyaF
	F4Ho4Gb6zdz4+YOmyfqG08AKY1Pta60yEGfbEGy26N+J7/apFd
	ijPAzgU78PfY9pSL0VZA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141456>

> Traditionally the right way to do this has been to make a temporary commit
> on the branch, i.e.

I would like to avoid such commits for unfinished content updates. Should the
storage operation be provided by the stash instead for intermediate work results?
Will it happen to forget corresponding clean-up for "temporary" changes that
might be committed too early just to get them stored?

Regards,
Markus
