From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Bug] git add -i fails in multiple ways prior to first commit.
Date: Wed, 13 Feb 2008 02:23:48 -0800 (PST)
Message-ID: <m3k5l9cfzi.fsf@localhost.localdomain>
References: <C50196C5-B0C5-4536-AD4A-0F9C553782EE@gmail.com>
	<20080213101649.GA18444@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rhodes, Kate" <masukomi@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 13 11:24:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPEmz-0003RZ-JR
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 11:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbYBMKXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 05:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754418AbYBMKXz
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 05:23:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:12967 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbYBMKXy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 05:23:54 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1611092nfb.21
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 02:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=YS4Yrr4xNZC30PqxogJnMBDiVkXAz3IQjeMBPo8FNOA=;
        b=T/oKbl+RTtElRQyuy/YpXFhQJz5IQMKkLJrFYqnWjOXlNCExHAybyaZZm3mwRPSdLfmn9I88h1aSkuV6jFOa759IU5T/0qyDO38rebOGSf3Bw4n2aQiTH0GeLwBbLLSrDOaW/6ij9PiRJU7cHnwvqWOrCd8DiX7H67AoMpolJJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=sGcdU0HE9S/bayxzdJafQkpqsoP01f3b2nZGAWaqnhREBCZ5GjuRPCj16jvpXhMO5X9UIEbnEtT2gYqCZ+am5UihM0cQ4MMXqsPtgW0W0SVulSKtXnYLPK4KeVACe9L/qJsvTE60oF34CANf7LGKNeJzFQiFYfHWsZ8SN/IqcJU=
Received: by 10.82.108.9 with SMTP id g9mr4570866buc.34.1202898229686;
        Wed, 13 Feb 2008 02:23:49 -0800 (PST)
Received: from localhost.localdomain ( [83.8.208.20])
        by mx.google.com with ESMTPS id q9sm1481341gve.10.2008.02.13.02.23.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Feb 2008 02:23:48 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1DANUw0003113;
	Wed, 13 Feb 2008 11:23:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1DANDKb003107;
	Wed, 13 Feb 2008 11:23:13 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080213101649.GA18444@coredump.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73769>

Jeff King <peff@peff.net> writes:

> However, I wonder if this is the best approach. It would be nice if
> there were a shorthand for "the empty tree" for diffing,

/dev/null? --root?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
