From: Ittay Dror <ittay.dror@gmail.com>
Subject: connecting existing local git repository to svn
Date: Mon, 26 Jan 2009 21:29:44 +0200
Message-ID: <497E0F28.9030805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 20:33:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRXCB-0001jU-4k
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbZAZTbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 14:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbZAZTbE
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 14:31:04 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:58611 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbZAZTbD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 14:31:03 -0500
Received: by ewy14 with SMTP id 14so964106ewy.13
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 11:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=kACb38AeQR2zb++Yh5vu5D9qkK1XtgvV806AzglHkic=;
        b=e119K+sxF8Q39mVW+st8dW9YcMz1ymb1B9Th+guVqeAimdJZVMJvXYYet90ASQtMFl
         K+0M39C9DOIp4WCDfufnj63SXzoEVYJF+S930EMtARQ/qbBVItR7TVR91fcZ3bWwmXCH
         WIWSu9om30xBFdZ7mVK4rFjsCAF3TPAYJSQnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=vqTZugaLIVYR5ZQzpoNWu9vpvmJSCFjswXE2r4TS7gPnHhRvJotP46On99ejEzQDhQ
         hnfwbvSNjB5BEfFymc6PM8jjVgexNhG7tOqk4CoPPyGaRkn/igtR2Cfngmz6kZ7DP8p0
         QCSk8W0zIUGmNR9/kZKCAIThSvDtyBFlNPaw4=
Received: by 10.86.54.3 with SMTP id c3mr513880fga.3.1232998259812;
        Mon, 26 Jan 2009 11:30:59 -0800 (PST)
Received: from ?192.168.1.9? (bzq-84-108-89-36.cablep.bezeqint.net [84.108.89.36])
        by mx.google.com with ESMTPS id d4sm55732fga.51.2009.01.26.11.30.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 11:30:59 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107256>

Hi,


I'd like to create a branch in a subversion repository so that I can 
work with git-svn on it.


My git repository is already with a history, that I don't want to 
replicate to subversion, I want to start with subversion having just the 
latest revision and then continue from there normally (git svn 
dcommit/rebase).


How can I do that?


Thanks,

Ittay
