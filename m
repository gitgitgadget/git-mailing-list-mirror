From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Fri, 18 Jan 2008 19:51:57 +0100
Message-ID: <4790F54D.7000008@gnu.org>
References: <4790BCED.4050207@gnu.org> <alpine.LSU.1.00.0801181545530.5731@racer.site> <4790CAF7.5010908@gnu.org> <alpine.LSU.1.00.0801181605020.5731@racer.site> <4790D5CF.8000602@gnu.org> <alpine.LSU.1.00.0801181804410.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 19:52:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFwKb-0004vI-OZ
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 19:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765395AbYARSwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 13:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765114AbYARSwD
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 13:52:03 -0500
Received: from hu-out-0506.google.com ([72.14.214.224]:20280 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765392AbYARSwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 13:52:00 -0500
Received: by hu-out-0506.google.com with SMTP id 19so365667hue.21
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 10:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=T2ITQw4WeLNPPpKd+UzhfbNn0nwF6w8jMffpVHKNA2U=;
        b=UwXd1dPUvEj91hRLkXBCa1SFbR33LCBfCm4/RjH9rqyK6R3PDmZF2JMEBDlPmV6Py696eXX5qSWv+rHcJ+Kyf1EjwvNcXoUlTLoWWlZg+fviTnBCrWNNlgewO95RD9NFbRGqlVObn391UC89vXn04sDLNFFlLvwXgOi08Z0ditM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=GlzR1XvjscTUPQDFIk6o3xi6sWuO20pxi+6W/HaWF0ipOgNuKdfJ9Ij04zMu/iQsKN1gZfQnU+EiUVSF7epdZwnqJFjNdE5gUaUqPjKReCacaTETfiKR8HbhZ0lmmkAZ6RjqWYrAkMNUc6LPm1r2S+tAx8V5PjfBSPlMtJ5cR8w=
Received: by 10.86.91.12 with SMTP id o12mr3353807fgb.62.1200682316646;
        Fri, 18 Jan 2008 10:51:56 -0800 (PST)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id l19sm6231774fgb.9.2008.01.18.10.51.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jan 2008 10:51:56 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <alpine.LSU.1.00.0801181804410.5731@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71049>


> No, my intention was to avoid complications.  Like introducing yet another 
> commit hook.  I like clean, elegant semantics.  I don't like overbloated 
> semantics.  That's why I speak up whenever I fear it is entering git.

Do you think my three line patch is too complicated?  Possibly I was too
zealous in documenting the semantics for the new hook and that looked
like unelegant semantics.

Do you have another possibility which allows the same workflow (git
commit shows the output of that script) within the existing framework?

Paolo
