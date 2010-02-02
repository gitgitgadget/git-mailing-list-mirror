From: Markus Elfring <Markus.Elfring@web.de>
Subject: Completion of error handling
Date: Tue, 02 Feb 2010 14:11:59 +0100
Message-ID: <4B68249F.6070004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 14:12:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcIY7-0005el-7D
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 14:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab0BBNMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 08:12:05 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:59815 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab0BBNMD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 08:12:03 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 9203914CDA700
	for <git@vger.kernel.org>; Tue,  2 Feb 2010 14:12:00 +0100 (CET)
Received: from [78.49.150.133] (helo=[192.168.1.202])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NcIXw-0006BL-00
	for git@vger.kernel.org; Tue, 02 Feb 2010 14:12:00 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1/HQ2HWWHvviwB69ujFo8hMxACM/xE1glPOToyV
	OgD26GEMTLJI23tRzK9Gwy1e3Zkv2DO0lyD83TwdgRhN8r4Ozs
	ADFuxd1LychLzmAIyDPg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138715>

Hello,

I would like to point out that some checks for return codes are missing in the source files.

Examples:
Would you like to add more error handling for return values from "pthread_mutex_init" like in the function "start_threads" and from "fprintf" in the function "output_header_lines"?
http://git.kernel.org/?p=git/git.git;a=blob;f=builtin-grep.c;h=0ef849cb84650705ffc840aed8a3fcedbeb48f9a;hb=HEAD#l224
http://git.kernel.org/?p=git/git.git;a=blob;f=builtin-mailinfo.c;h=a50ac2256cdbacd76ed44a50804212be07f949db;hb=HEAD#l935

Regards,
Markus
