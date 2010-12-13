From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: APIs for automatic patch generation
Date: Mon, 13 Dec 2010 17:00:30 +0100
Message-ID: <4D06431E.5020906@web.de>
References: <4B803AB8.30304@web.de> <4B840AA2.3010604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, libgit2@librelist.com
X-From: git-owner@vger.kernel.org Mon Dec 13 17:00:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSApd-0002Uv-P6
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 17:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230Ab0LMQAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 11:00:49 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:36244 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab0LMQAs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 11:00:48 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id 457FC17D811FC;
	Mon, 13 Dec 2010 17:00:47 +0100 (CET)
Received: from [78.49.108.39] (helo=[192.168.1.46])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PSApT-0004a5-00; Mon, 13 Dec 2010 17:00:47 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.13) Gecko/20101206 SUSE/3.1.7 Thunderbird/3.1.7
In-Reply-To: <4B840AA2.3010604@web.de>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX189JH7QgAlkxMAZcSPyRmbcsNeX3YzM4V3rF/Pg
	ws2X9VE1rYaERAhYnxgSaC+4z3OjNSWfpga4nq4+9FDbcx8C8T
	vn/WX2IObhmP0uHrQU2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163558>

> The commands "git diff" and "git format-patch" contain functionality that I
> would like to reuse for my little application in a C++ class library.

Which functions exist in the recently published C API 
(http://libgit2.github.com/) that can provide the following data?
* a line like "index 8d16832..358c98b 100644"
* range specifications for difference hunks
* mail construction

Regards,
Markus
