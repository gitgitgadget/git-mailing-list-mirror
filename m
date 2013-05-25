From: Gioele Barabucci <gioele@svario.it>
Subject: git clone does not understand insteadOf URLs
Date: Sat, 25 May 2013 22:23:44 +0200
Message-ID: <51A11DD0.4040802@svario.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 22:33:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgL9u-0008Is-Tm
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 22:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758012Ab3EYUdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 16:33:42 -0400
Received: from camelia.svario.it ([164.138.26.129]:56225 "EHLO mail.svario.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757990Ab3EYUdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 16:33:41 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 May 2013 16:33:40 EDT
Received: from [192.168.2.4] (dynamic-adsl-84-223-204-159.clienti.tiscali.it [84.223.204.159])
	by mail.svario.it (Postfix) with ESMTPSA id 9A5052722C
	for <git@vger.kernel.org>; Sat, 25 May 2013 20:23:46 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225532>

Hello,

it seems that `git clone` does not understand keywords used `insteadOf` 
longer URLs.

     $ git clone remote-repo/ProjectA.git
     fatal repository 'remote-repo/ProjectA.git' does not exist

I suppose that git interprets the argument as a local directory. Git 
should see if the argument matches one of the known URLs before raising 
an error.

Regards,

-- 
Gioele Barabucci <gioele@svario.it>
