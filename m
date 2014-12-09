From: =?ISO-8859-15?Q?Christoph_Gr=FCninger?= <foss@grueninger.de>
Subject: [wish] Revert changes in git gui
Date: Tue, 09 Dec 2014 20:49:55 +0100
Message-ID: <54875263.1010407@grueninger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 20:56:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyQtM-0000oJ-PQ
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 20:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbaLIT4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 14:56:13 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.223]:62881 "EHLO
	mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaLIT4M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 14:56:12 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Dec 2014 14:56:12 EST
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1418154970; l=368;
	s=domk; d=grueninger.de;
	h=Content-Transfer-Encoding:Content-Type:Subject:To:MIME-Version:From:
	Date;
	bh=Batzq6lykFbdnmsqocFfXtwkbbw=;
	b=nssVdS+9HzT7LNw1NsvfgZ3kQy0rzxKQ5e4aMmr8qpMghAh8n2ZTSATVqRip3C16KOq
	tvgKkgjETp1nCHN+jH5SdT40Ft2eWMqpuV1H+4jlJoFJZaPZcm6pFIjaQFvfHmbWiTnHi
	YrMECBj4VZBB3UGA1DvwFAX5zTiCv4IiyMo=
X-RZG-CLASS-ID: mo04
X-RZG-AUTH: :PH4kclK9fvHEIDd1AEB/H6dKpHPYpRotT71NeUdfzJjP6BFHx6uJQNYAeA==
Received: from [192.168.0.103] (HSI-KBW-134-3-24-15.hsi14.kabel-badenwuerttemberg.de [134.3.24.15])
	by smtp.strato.de (RZmta 36.3 SBL|AUTH)
	with ESMTPSA id j00220qB9Jnt5ZE
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	for <git@vger.kernel.org>;
	Tue, 9 Dec 2014 20:49:55 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261148>

Hi Git devs,
I have a feature request for git gui:

While browsing the changes, it is very easy to add (or remove) lines or 
hunks for commit via the context menu. I would like to revert the 
changes of a line or a hunk in a similar way. I have often white-space 
or formatting changes I don't want to commit but want them reverted 
immediately.

Bye
Christoph
