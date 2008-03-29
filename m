From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: why multiple password prompts?
Date: Sat, 29 Mar 2008 09:59:04 -0700 (PDT)
Message-ID: <m37iflv54l.fsf@localhost.localdomain>
References: <alpine.WNT.1.10.0803291141550.11992@znlsyl>
	<alpine.LNX.1.00.0803291241020.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul <lists@pote.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Mar 29 18:00:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfePL-0006tq-Dq
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 17:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbYC2Q7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 12:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbYC2Q7K
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 12:59:10 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:34853 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbYC2Q7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 12:59:08 -0400
Received: by fk-out-0910.google.com with SMTP id 19so992074fkr.5
        for <git@vger.kernel.org>; Sat, 29 Mar 2008 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=iHAAjLqnxdAhFP9E0nDRtRDOYsLmJO8D3g/I4ZPmx9Q=;
        b=iX282h+Wbe38RFUCplMBxUe9LN++7pwKOq8s0SKbJ5YcFuxWe6G/r9v/WCaP2jqpEsdyXD+qNfc6XBUi2e07mBl/e6gDvYc6mA/8/UXsVO4AQeCXqhHfkyxKSOKqtThbRz3R6u4HzhJd4OKmlBmdwAQgjQSpA4IyDFhiTFCtAdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=X39iZOW/A+VzN+FInRHqzpJqS7QIF8t7/LWvjvtrRSVbo9TDroeDZ6/9qIr+bMdEbok8FBHGRRf8wzWWTZOFgqYA/Sr5tEEU0A0qZwH794KyI0CohpJNFb8bVjbKl5Ut08LmGA48US6YpUVyiyBr/uNmN/GIpwnSndRqXNuVGX8=
Received: by 10.78.81.20 with SMTP id e20mr13495156hub.1.1206809946886;
        Sat, 29 Mar 2008 09:59:06 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.214.246])
        by mx.google.com with ESMTPS id d27sm102169nfh.2.2008.03.29.09.59.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 29 Mar 2008 09:59:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2TGwud1030749;
	Sat, 29 Mar 2008 17:59:00 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2TGwpFl030746;
	Sat, 29 Mar 2008 17:58:51 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LNX.1.00.0803291241020.19665@iabervon.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78473>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sat, 29 Mar 2008, Paul wrote:

Paul who?

>> When I do a simple git-pull over SSH, why does it typically prompt
>> me for my SSH password two or three times? And no, I am not
>> inputting it wrong.
> 
> In some versions of git, it makes separate connections to find out
> what the remote's state is and to fetch the actual data. A third
> connection should only be needed if there are new tags to fetch, and
> that would be after some of the messages.
> 
> One of the changes in the upcoming release is to reduce this to one,
> except for an occasional second one.

The way to avoid multiple prompt for SSH password is to set up SSH key
infrastructure, so you can login using SSH keys which does not require
you to enter password, with the possible exception of adding key to
keyring if it is protected by password.

See ssh-add(1) and ssh-keygen(1) (and keychain(1) if you want to add
keyonce for all sessions).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
