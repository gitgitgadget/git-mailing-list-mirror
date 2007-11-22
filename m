From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path to patch
Date: Thu, 22 Nov 2007 22:55:37 +0100
Message-ID: <4C292793-6EEF-4C1A-A91A-B5040A3752C5@wincent.com>
References: <1195648601-21736-1-git-send-email-win@wincent.com> <1195648601-21736-2-git-send-email-win@wincent.com> <1195648601-21736-3-git-send-email-win@wincent.com> <20071121152118.GG24108@sigill.intra.peff.net> <7vejejfi28.fsf@gitster.siamese.dyndns.org> <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <7vk5obb09a.fsf@gitster.siamese.dyndns.org> <20071122091356.GD7153@sigill.intra.peff.net> <7v8x4q7gns.fsf@gitster.siamese.dyndns.org> <887C3CB1-D21B-4143-8D4E-BF37709FA102@wincent.com> <7vlk8q5xj4.fsf@gitster.siamese.dyndns.org> <FDAFAD8C-8FF5-4DD7-AC5E-BA39790281A4@wincent.com> <7vsl2y3wph.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 22:56:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvK2S-0002JP-1r
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 22:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbXKVV43 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 16:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752330AbXKVV43
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 16:56:29 -0500
Received: from wincent.com ([72.3.236.74]:58617 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbXKVV42 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 16:56:28 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAMLtc5j026473;
	Thu, 22 Nov 2007 15:55:39 -0600
In-Reply-To: <7vsl2y3wph.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65851>

El 22/11/2007, a las 20:29, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> Or if we add some kind of "--patch" switch, instead do:
>>
>> 	git add -i --patch foo
>
> You do not need both "-i" and "--patch", do you?  Plain git-add
> does not take --patch anyway so it can pass --patch to the
> underlying interactive one.

Good point.

Cheers,
Wincent
