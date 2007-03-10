From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] git-bundle: only die if pack would be empty, warn if
 ref is skipped
Date: Sat, 10 Mar 2007 00:44:53 -0500
Message-ID: <45F245D5.4030103@gmail.com>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net> <45F17EF0.5060008@gmail.com> <Pine.LNX.4.63.0703091726530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 10 06:45:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPuOG-00071Y-Fo
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 06:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993173AbXCJFox (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 00:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993174AbXCJFov
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 00:44:51 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:34287 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993173AbXCJFou (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 00:44:50 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1095010wxd
        for <git@vger.kernel.org>; Fri, 09 Mar 2007 21:44:50 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=i2Ns8qZ6IeWdcjM694ZK7wWfkOtxKNNDlJAanHKqcsumcNb0EE6ogUtM51o8owrqJ8gVEeAu8uBW4vR+cSn2EzqnvTC+wbrbTYg2NR91O4Q5zqr61+OjmeWHQizy+PtKUP/m/wO3u0jBZoKMojQJgHg8fSsCQN6Lexl62DYPIPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XjMEEtduXaXclsX2eRL2/ThTihvE/n7A8SeFSymR1Ifg5Xo/53UQ7KghImyB+3w0l11UqlB9XjrO9IZ3USftxFCnHB9kjvzFnuLiGatYxJqVhDieG+IJBdk06sFsVpT2rV4EygiDTd80lL5HJNN/meUjOXyHbLnixuUQRjLoZ7w=
Received: by 10.90.120.13 with SMTP id s13mr346258agc.1173505489966;
        Fri, 09 Mar 2007 21:44:49 -0800 (PST)
Received: from ?192.168.100.117? ( [71.246.235.75])
        by mx.google.com with ESMTP id 7sm3930666aga.2007.03.09.21.44.49;
        Fri, 09 Mar 2007 21:44:49 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.63.0703091726530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41848>

Johannes Schindelin wrote:
> A use case for git-bundle expected to be quite common is this:
>
> 	$ git bundle create daily.bundle --since=10.days.ago --all
>
>   
This patch works for me... Thanks.

Mark
