From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: APIs for automatic patch generation
Date: Tue, 23 Feb 2010 18:04:34 +0100
Message-ID: <4B840AA2.3010604@web.de>
References: <4B803AB8.30304@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 18:04:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjyBd-00009y-TR
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 18:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab0BWREg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 12:04:36 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:56839 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab0BWREg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 12:04:36 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 13197148BB1F1
	for <git@vger.kernel.org>; Tue, 23 Feb 2010 18:04:35 +0100 (CET)
Received: from [78.49.33.20] (helo=[192.168.1.202])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NjyBW-0006Gf-00
	for git@vger.kernel.org; Tue, 23 Feb 2010 18:04:35 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <4B803AB8.30304@web.de>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+C/h0z0n5/vG4XFPGbWmyQx4r4w5xR1g+n7onx
	Hj0IhwmLP8IrxmdiM2ytm1DcOSFiFYYiLSMyy2kjq+cErenJQE
	sOOzJir6Usvgw96ToHUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140811>

Hello,

The commands "git diff" and "git format-patch" contain functionality that I
would like to reuse for my little application in a C++ class library.

Which functions exist in a C API that can provide the following data?
- a line like "index 8d16832..358c98b 100644"
- range specifications for difference hunks
- mail construction

Regards,
Markus
