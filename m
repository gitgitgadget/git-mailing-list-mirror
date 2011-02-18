From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: My git-gui difftool script
Date: Fri, 18 Feb 2011 08:36:51 +0100
Message-ID: <4D5E2193.1050103@fastmail.fm>
References: <loom.20110217T141642-685@post.gmane.org> <4D5D4CA0.8040301@fastmail.fm> <loom.20110218T020325-431@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chunlin Zhang <zhangchunlin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 08:40:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqKwm-00073j-Ex
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 08:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab1BRHkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 02:40:04 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59115 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753352Ab1BRHkB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 02:40:01 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3394520BDC;
	Fri, 18 Feb 2011 02:40:01 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 18 Feb 2011 02:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=QT5WIy7LIF3NXENSNx5w2UzZX48=; b=LH/YzHCd4RbxbNWurIRFBdmIqgFgjEvyoBepN6JwRemIkKQvpR/N7Dk0iMUPG7/DHvDKLFQOUXQ4qh9f0Q5v+5mflnWW3qPuvZhoga5e/EIXPxTNuMpRThk7hbLHb3xscPU3QFNlxtsscordLbCbcytzXaONX2DgBTEHUS031a0=
X-Sasl-enc: x7zycVQjtOr1EsluVoLUwtmUls6prYdyhhtqFlYvZ/Iw 1298014800
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AD714407DEE;
	Fri, 18 Feb 2011 02:40:00 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <loom.20110218T020325-431@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167180>

Chunlin Zhang venit, vidit, dixit 18.02.2011 02:12:
> Michael J Gruber <michaeljgruber+gmane <at> fastmail.fm> writes:
> 
>>
>>
>> I don't want to spoil the party, but how is this different from using
>> "git difftool -y $FILENAME" for the command?
> 
> Because in git-gui I can know which files are modified and which file are staged
> more clearly and directly,and I can examine the diff over and over again if I
>  like.

Well, of course, but in git-gui's Tools menu you can use

"git difftool -y $FILENAME"

instead of

"YOUR_PATH_TO_git_gui_difftool.py $FILENAME"

for the command. So I'm just wondering what your new difftool.py does
differently from the existing git-difftool.

Michael
