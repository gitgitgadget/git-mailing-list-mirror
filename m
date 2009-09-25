From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 16:12:52 +0200
Message-ID: <4ABCCFE4.6070202@viscovery.net>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>	 <e5bfff550909250246qed6f2ci4237bdaefd8a18a@mail.gmail.com>	 <4ABC9C5D.5030202@viscovery.net>	 <e5bfff550909250344y535a05edx7d30ad7e48a5f036@mail.gmail.com>	 <e5bfff550909250430x14b0d7f4w5e22467ddd66cc29@mail.gmail.com> <e5bfff550909250704x724fd4c7lebe7184b4557c7a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 16:13:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrBXh-0001EG-5k
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 16:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbZIYOMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 10:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbZIYOMv
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 10:12:51 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:62818 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbZIYOMv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 10:12:51 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MrBXZ-0004Ww-9U; Fri, 25 Sep 2009 16:12:53 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1652F9614; Fri, 25 Sep 2009 16:12:53 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <e5bfff550909250704x724fd4c7lebe7184b4557c7a9@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129086>

Marco Costalba schrieb:
> So somehow the problem is that all the commands are lowercased, and
> this explains why pretty format %H is interpreted as %h so that sha
> abbreviated form is used.
> 
> Now the question is: how to restore normal case sensitive command parsing ?
> 
> P.S: Please, at least answer this last question ;-)

I cannot.

Please try calling the commands from CMD. To do that in a regular msysgit
installation where you did not choose the option to set the PATH, it
should be sufficient to point your PATH to
<installdir>\git\bin;<installdir>\bin;%PATH% (although I'm not sure about
the exact paths - as I said, I don't install msysgit). Does that work?

-- Hannes
