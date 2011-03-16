From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] reflog: silence -O3 -Wuninitialized warning
Date: Wed, 16 Mar 2011 10:54:09 +0100
Message-ID: <4D8088C1.5050901@viscovery.net>
References: <20110316024959.GA24932@elie> <7vfwqnabbi.fsf@alter.siamese.dyndns.org> <4D807E66.40504@viscovery.net> <20110316094639.GA8180@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 10:54:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PznQo-0001WR-MQ
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 10:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409Ab1CPJyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 05:54:14 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:10979 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752003Ab1CPJyN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 05:54:13 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PznQf-0002Jx-Pv; Wed, 16 Mar 2011 10:54:09 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7568D1660F;
	Wed, 16 Mar 2011 10:54:09 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110316094639.GA8180@elie>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169130>

Am 3/16/2011 10:47, schrieb Jonathan Nieder:
> Since the makefile already controls what options are passed to msvc,
> is there some simple way to suppress the warning from "expire =
> expire"?

I don't think so. This is not a special warning, but just

	warning C4700: uninitialized local variable 'expire' used

That is, if you disable it, you also disable it for locations where the
warning would be justified. That's not something that I would like to do.

-- Hannes
