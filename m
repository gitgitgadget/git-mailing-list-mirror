From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] revision: add --except option
Date: Mon, 02 Sep 2013 08:30:30 +0200
Message-ID: <52243086.6030102@viscovery.net>
References: <1377984383-15770-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 02 08:30:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNem-00029g-Jf
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757704Ab3IBGab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 02:30:31 -0400
Received: from so.liwest.at ([212.33.55.13]:39676 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757654Ab3IBGaa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 02:30:30 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VGNef-0001di-Ib; Mon, 02 Sep 2013 08:30:29 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 569B01660F;
	Mon,  2 Sep 2013 08:30:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1377984383-15770-1-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.5.2
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233609>

Am 8/31/2013 23:26, schrieb Felipe Contreras:
> +--except::
> +	Skip the following object names. For example:
> +	'--branches --except master' will show all the branches, except master.
> +	This differs from --not in that --except will still show the object, if
> +	they are referenced by another object name.

--except needs a bit more documentation, in particular, how it interacts
with --not.

It would be better to settle on the meaning of --except before throwing
back and forth implementations.

-- Hannes
