From: Francis ANDRE <francis.andre.kampbell@orange.fr>
Subject: Git improvement for line feed processing: LF versus CR-LF
Date: Mon, 08 Sep 2014 10:55:07 +0200
Message-ID: <540D6EEB.2040101@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 10:55:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQujF-0001Tm-1k
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 10:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbaIHIzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 04:55:10 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:21957 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946AbaIHIzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 04:55:09 -0400
Received: from [192.168.1.2] ([92.131.132.97])
	by mwinf5d03 with ME
	id oYv71o00m26ER5Y03Yv8gc; Mon, 08 Sep 2014 10:55:08 +0200
X-ME-Helo: [192.168.1.2]
X-ME-Auth: ZnJhbmNpcy5hbmRyZS5rYW1wYmVsbEB3YW5hZG9vLmZy
X-ME-Date: Mon, 08 Sep 2014 10:55:08 +0200
X-ME-IP: 92.131.132.97
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256635>

Hi

I am using git-gui on a project hosted  at GitHub and the project 
requirement is to commit only Unix ending with LF lines as show below

When contributing to POCO, please adhere to our coding style guide

All text file line endings in the repository must be Unix-style (LF). 
This includes Visual Studio project and solution files (.sln, .vcproj, 
.vcxproj, .vcxproj.filters).

But git-gui translates states:
warning: LF will be replaced by CRLF in file.txt. The file will have its 
original line endings in your working directory.

Could you add a option to git-gui to specify to translate or not the end 
of line of the cloned repository so that my fixes be accepted by the 
owner of the repository.

Thank
