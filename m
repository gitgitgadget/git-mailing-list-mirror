From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/2] git-show: use pathattr to run "display"
Date: Thu, 1 Mar 2007 09:04:44 +0000
Message-ID: <200703010904.48146.andyparkins@gmail.com>
References: <7vodndxwia.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 10:05:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMhDh-0007qf-Is
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 10:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933153AbXCAJFA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 04:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933159AbXCAJFA
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 04:05:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:43812 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933153AbXCAJEy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 04:04:54 -0500
Received: by nf-out-0910.google.com with SMTP id o25so830319nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 01:04:52 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fFU7bK4A/+bwvfWEMRF82hEBwiG3YzyM8wiWJZmzEHpw4Yv1fczzhUEBj9UTnws9CGElFzMMxL02yBBsI3QmV26wttW6q7ZCm/GeJvNS4Re1FAGgGQDaZA+by8VHCZeL++13BmKySWkW9VCPhuSEe3x0BJCj3u02wKsyBk4ZDZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Trko/RZU9ABTm9xWzy1Am1V4fgWwiWOgJGqpNUVvw5YLlaMlNF+yCl9Rmw/DhpIVUzA6XMwdNKgu/OLLaoB+ha1S1tSpDnML/u1aVUGURxMdKlV8KnMn1POxwp6l03xSUzWSiIkOJoCsCQfhf5hiL6J/fS3V8rJzrUHz6D+uD2k=
Received: by 10.49.93.4 with SMTP id v4mr5250625nfl.1172739892823;
        Thu, 01 Mar 2007 01:04:52 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id b1sm8380844nfe.2007.03.01.01.04.50;
        Thu, 01 Mar 2007 01:04:50 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vodndxwia.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41056>

On Thursday 2007 March 01 07:18, Junio C Hamano wrote:
> This is a bit of detour, to demonstrate a possible use of
> pathattr infrastructure.  With this,
>
> 	$ git show v1.4.4:t/test4012.png
>
> would hopefully do what you would expect.

Is this serious?  This doesn't belong inside git does it?

What if I don't want to run "display"?  What if I don't want to run anything, 
and just want png files dumped raw to the terminal?



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
