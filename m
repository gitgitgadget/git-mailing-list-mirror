From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Document GIT_SSH environment variable alongside other variables
Date: Mon, 6 Aug 2007 00:16:40 +0200
Message-ID: <200708060016.40829.jnareb@gmail.com>
References: <20070804060652.GA28379@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 01:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHpgT-0002m7-L5
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 01:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbXHEXii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 19:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbXHEXih
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 19:38:37 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:54791 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbXHEXiY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 19:38:24 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1860554mue
        for <git@vger.kernel.org>; Sun, 05 Aug 2007 16:38:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iX4qeRUsDmTDzL7w3n88/PdPtf3lyqv7DFTnGW6+a/0tCifQCa3BIhh6tgDTrmmKTIkCgHBP9hHYDIrSmg0Co1li4NX4NPsToshFgN9VUY8nPw/kDnypuQrkp90RNVoajdohvnpL1M6bMkeNh5vZDJjecUrH3XCww8xZVWtrYRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KrME5Vw/CeTFGQ61xDlPFHBlDGMfzEjG7iWIp1f1znzijidHePznZopW3XAz45gUb6bFn6uoTRjnEFesETN8QmsfzSwsIcLMLAgnSyjJ1e4W/M87M3FIh5ALpiRN+UbtQYDSNw7CGdsqLKncDMPWDUofstnx42NpgKPWnHEvWHE=
Received: by 10.86.3.2 with SMTP id 2mr3939524fgc.1186357103528;
        Sun, 05 Aug 2007 16:38:23 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id o11sm11427967fkf.2007.08.05.16.38.22
        (version=SSLv3 cipher=OTHER);
        Sun, 05 Aug 2007 16:38:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070804060652.GA28379@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55082>

Shawn O. Pearce wrote:

> The GIT_SSH environment variable has survived for quite a while
> without being documented, but has been mentioned on list and on
> my day-job repositories can only be accessed via magic supplied
> through the wonderous hack that is GIT_SSH.

Thanks a lot.

By the way, I plan on documenting existing environmental variables used 
by git better (for after 1.5.3). First, separate "Environmental 
variables" section in Documentation/git.txt into separate file (similar 
to the config.txt file), named environment.txt. Second, add to the list 
of variables links to variables which are documented in other manpages, 
similarly to how for example GIT_AUTHOR_NAME etc. are described. Then 
add one by one environmental variables which are not documented at all: 
GIT_SSH_PUSH/GIT_SSH_PULL, GIT_CURL_VERBOSITY, GIT_REFLOG_ACTION, 
GIT_GRAFT_FILE and GIT_TEMPLATE_DIR.

-- 
Jakub Narebski
Poland
