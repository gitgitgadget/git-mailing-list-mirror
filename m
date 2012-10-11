From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/3] grep: stop looking at random places for .gitattributes
Date: Thu, 11 Oct 2012 07:55:00 +0200
Message-ID: <50765F34.1070108@viscovery.net>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org> <1349868894-3579-1-git-send-email-pclouds@gmail.com> <1349868894-3579-4-git-send-email-pclouds@gmail.com> <5075615B.8020702@viscovery.net> <CACsJy8BG0HJNePG-j27SrfEenEkZ5a5nCdMEuDGn=qXxq=VzhA@mail.gmail.com> <50756646.5060505@viscovery.net> <7vy5jeaz81.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 07:57:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMBlq-0006Yi-7j
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 07:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756734Ab2JKFzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 01:55:03 -0400
Received: from so.liwest.at ([212.33.55.24]:37760 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756724Ab2JKFzC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 01:55:02 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TMBjZ-0003xv-0Y; Thu, 11 Oct 2012 07:55:01 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B987E1660F;
	Thu, 11 Oct 2012 07:55:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vy5jeaz81.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.4
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207464>

Am 10/10/2012 21:44, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Is there already an established definition which the "correct"
>> .gitattributes are?
> 
> No, and it is deliberately kept vague while waiting for us to come
> up with a clear definition of what is "correct".
...
> Very often, people
> retroactively define attributes to correct earlier mistakes.

Absolutely. I have Windows resource files that are Shift-JIS encoded
checked in long ago, and I want to retoactively declare them with
"encoding=Shift-JIS" because I prefer to see Japanese script in gitk
rather than gibberish.

-- Hannes
