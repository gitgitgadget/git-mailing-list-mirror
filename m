From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: git show and the --quiet option
Date: Sat, 28 May 2011 18:53:28 +0200
Message-ID: <4DE12888.1040506@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 19:02:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQMtu-0005PW-Ey
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 19:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132Ab1E1RCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 13:02:04 -0400
Received: from muon.isy.liu.se ([130.236.48.25]:63820 "EHLO muon.isy.liu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887Ab1E1RCD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 13:02:03 -0400
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 May 2011 13:02:03 EDT
Received: from [192.168.2.5] (217-211-21-249-no36.tbcn.telia.com [217.211.21.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by muon.isy.liu.se (Postfix) with ESMTPSA id 335FA2B5;
	Sat, 28 May 2011 18:53:31 +0200 (MEST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
X-Enigmail-Version: 1.1.1
X-ISY-LIU-SE-MailScanner-Information: Please contact postmaster@isy.liu.se for more information
X-ISY-LIU-SE-MailScanner-ID: 335FA2B5.AD5BD
X-ISY-LIU-SE-MailScanner: Found to be clean
X-ISY-LIU-SE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 6, ALL_TRUSTED -1.00)
X-ISY-LIU-SE-MailScanner-From: hendeby@isy.liu.se
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174665>

Hello everyone,

I was playing around with "git show" lately and realized it has changed
its behavior regarding the --quiet option, which no longer suppresses
the diff output as it used to.  The behavior change happened in
1c40c36b ("log: convert to parse-options").  Was this intentional?

The commit message talks about the --quiet handling being improved and
the "git show" help doesn't mention a --quiet option.  Is the simple
answer that the previous behavior was incorrect?

/Gustaf
