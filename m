From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] gitk: Show notes
Date: Tue, 11 May 2010 16:35:45 +0200
Message-ID: <4BE96B41.7010902@drmicha.warpmail.net>
References: <1273566416-3512-1-git-send-email-kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Tue May 11 16:36:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBqZ4-0003Zu-SR
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 16:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757487Ab0EKOfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 10:35:44 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37246 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755609Ab0EKOfn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 10:35:43 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 465B1F50AF;
	Tue, 11 May 2010 10:35:42 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 11 May 2010 10:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=9x6ryyhpr9lzrMQCXhMyOUFSONo=; b=PXnazSdVpVdN4rFChQSuiMG0jIOQ1EcqibYx7S9oCjmBCdL3NBDN04XmM9YgHXPQwA2SN+DLkPK0vXSkUUn4LTqnelrjpRJpmyVLvU+dIbI7XI4Unx7igYqQFXigxD5JO05kv3I5mrUcoWXiMMiTXZD+F/8vi+Kr8ZsYKHgr2k8=
X-Sasl-enc: JVTPKjggVvs1opB7bmIfm1f2x6LidwxsJMTAkFTKP1TF 1273588541
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3C68A45BBF;
	Tue, 11 May 2010 10:35:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <1273566416-3512-1-git-send-email-kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146897>

Kirill Smelkov venit, vidit, dixit 11.05.2010 10:26:
> If in git.git I do
> 
>     $ git notes add -m 'This makes status significantly slower with Dokko' \
>         ee6fc514
> 
> then `git log` shows the note...
> 

because --show-notes is the default...

> ... but unfortunately gitk does not.

... unless --pretty is given, and gitk uses --pretty.

But what is wrong with gitk --show-notes?

If you mean to adjust gitk's default to log's current default please say
so in the commit message. There's no need to include a longish sample
output for that.

Also, I don't think proc do_readcommit needs the notes. The other two
places use $args, so it might make sense to prepend --show-notes to the
arg list in a central place.

Michael
