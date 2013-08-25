From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/5] replace: forbid replacing an object with one of a
 different type
Date: Sun, 25 Aug 2013 22:18:12 +0200
Message-ID: <521A6684.7090103@kdbg.org>
References: <20130825125940.4681.70226.chriscool@tuxfamily.org> <20130825130609.4681.25786.chriscool@tuxfamily.org> <521A4E83.9000400@kdbg.org> <20130825.214417.1308749312477487067.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, philipoakley@iee.org,
	trast@inf.ethz.ch
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Aug 25 22:18:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDglT-0006cG-PY
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 22:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab3HYUSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 16:18:14 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:56246 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753799Ab3HYUSO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 16:18:14 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A84731000B;
	Sun, 25 Aug 2013 22:18:12 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 20CD019F624;
	Sun, 25 Aug 2013 22:18:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130825.214417.1308749312477487067.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232967>

Am 25.08.2013 21:44, schrieb Christian Couder:
> What about:
> 
>      		die("Objects must be of the same type.\n"
> 		    "'%s' points to a replaced object of type '%s'\n"
> 		    "while '%s' points to a replacement object of type '%s'.",

Much better!

-- Hannes
