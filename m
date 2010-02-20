From: Markus Elfring <Markus.Elfring@web.de>
Subject: APIs for automatic patch generation
Date: Sat, 20 Feb 2010 20:40:40 +0100
Message-ID: <4B803AB8.30304@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 20 22:11:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NivCF-0001y5-P6
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 20:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974Ab0BTTkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 14:40:46 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:51765 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955Ab0BTTkp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 14:40:45 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id ACC4013F0B049
	for <git@vger.kernel.org>; Sat, 20 Feb 2010 20:40:44 +0100 (CET)
Received: from [92.227.200.66] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NivC0-0001za-00
	for git@vger.kernel.org; Sat, 20 Feb 2010 20:40:44 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX18LWyxsO/JgfOSVlJsbOPq4PIPrWEKrRGGyQl0O
	P3ebwVdmwatPUUeBmh87xyzzEw1gwYq9scrSgrwfxXfnZnwqBL
	FJ+3b1sF/SpS8xsco4cQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140554>

Hello,

I would like to generate patches in the Git format for some other
software automatically. Which application programming interfaces do you
recommend for this purpose if I am going to integrate this into a small
C++ class library?
http://www.kernel.org/pub/software/scm/git/docs/v1.7.0/technical/api-index.html
http://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools

Specific use cases:
- Which functions or commands should I call to retrieve the required
informations for a line like "index 8d16832..358c98b 100644"?
- Can any functions help to construct proper range specifications for
difference hunks?

Regards,
Markus
