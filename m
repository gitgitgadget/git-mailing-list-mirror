From: Andreas Ericsson <ae@op5.se>
Subject: Re: Using pickaxe to track changed symbol CR4_FEATURES_ADDR
Date: Mon, 05 Jun 2006 14:43:38 +0200
Message-ID: <448426FA.1090204@op5.se>
References: <20060605102627.GB24346@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 05 14:43:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnEQq-00062y-2h
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 14:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWFEMnl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 08:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWFEMnl
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 08:43:41 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:35265 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751041AbWFEMnk
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 08:43:40 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 191C46BD5D; Mon,  5 Jun 2006 14:43:39 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20060605102627.GB24346@cip.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21317>

Thomas Glanzmann wrote:
> Hello,
> I am looking for the symbol CR4_FEATURES_ADDR which must be gone in one
> of the last kernel revision. Now how I do use pickaxe to track any
> changes that involve my missing symbol? Or is there a better way to
> track that change down?
> 

$ git whatchanged -S'CR4_FEATURES_ADDR'

last time I checked, but that was 10 days and an immense amount of cheap 
turkish alcohol ago so it's quite possible that I'm wrong.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
