From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Sat, 20 Mar 2010 07:00:09 +0100
Message-ID: <4BA46469.7020800@web.de>
References: <4B67227A.7030908@web.de> <4b8bf32f.0706c00a.26cb.691d@mx.google.com> 	<4BA104C7.5020207@web.de> <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com> 	<7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA1FC39.10300@web.de> 	<32541b131003180936x746dad06k386788d3cb6fcdeb@mail.gmail.com> 	<b4087cc51003181019r4408953bxcd5049c9521b8173@mail.gmail.com> 	<32541b131003181033p7916d92frc1269b95c292e3db@mail.gmail.com> 	<4BA335B6.4000103@web.de> <32541b131003191017rdc4e87fgcc4fabc76e0709be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 07:00:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsrjU-00019w-NP
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 07:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab0CTGAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 02:00:19 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:46598 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab0CTGAS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 02:00:18 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 39CC914620FE7;
	Sat, 20 Mar 2010 07:00:17 +0100 (CET)
Received: from [78.48.36.7] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #4)
	id 1NsrjN-0000ew-00; Sat, 20 Mar 2010 07:00:17 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.8) Gecko/20100228 SUSE/3.0.3-1.1.1 Thunderbird/3.0.3
In-Reply-To: <32541b131003191017rdc4e87fgcc4fabc76e0709be@mail.gmail.com>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX19xX3PuOGgJS+KU6dRT/weuzeRr9hAJij3PPcsc
	PAkrrFkeaS36T+n0b6PjrgDW688OH944q1FqMNJfQkxP4sRnNl
	QXarqwE5+VtVuCvqlQxA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142689>

> Commits cost almost exactly zero.

The storage costs are negligible. I am more concerned about unwanted work flow
effects because a modification might be committed and suddenly merged too early.


>     git commit -a -m 'FIXME temporary'

The specified message is not independent from a language. I see also a potential
for typos by this approach which will make it harder to distinguish
non-temporary commits from the real ones.

Regards,
Markus
