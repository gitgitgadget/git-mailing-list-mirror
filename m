From: Thomas Harning <harningt@gmail.com>
Subject: Re: [PATCH] quote_path: convert empty path to "./"
Date: Fri, 07 Dec 2007 14:05:15 -0500
Message-ID: <4759996B.2000300@gmail.com>
References: <20071207165703.GA8889@sigill.intra.peff.net> <Pine.LNX.4.64.0712071853500.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 07 20:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0iXW-00033J-On
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 20:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbXLGTGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 14:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753520AbXLGTGs
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 14:06:48 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:11400 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbXLGTGr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 14:06:47 -0500
Received: by an-out-0708.google.com with SMTP id d31so201302and
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 11:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=KBm1ZQ5JIOyh9vMxmU5n8iDBI7DJ58EG6LGwr44TnnI=;
        b=c7X05FIuAmHB/EwL+Y1+cw9bheH2Ai6tdz6afX/uWQdfML0VAZo/KpxsLY5pTKJrN7ieN+bDOm1J96y5jEi8zkexzls2+GFpDRii2xukLi/u1RDTeB3IuK59FIjuBdfStx2QTP+HtuBcDzvNTSTqQt+3xfw7qmjQz/Nz/ftc+iw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=F2wy9fqtAsGHOT9tQiXOoygm1jZh/TNkO9NTAHUrOGphE7exsRe62yvxPnNEQOnCG2QK4Qvz6yRKhcpA7F+pWBr851vsUkjS4xMIBkG48thrb9cPmtEcV3U/Lit+zhoHXMgSrxnhwpn1EBvFEQNr+i1PyFlaE0bC7idozaYW14o=
Received: by 10.142.162.5 with SMTP id k5mr2378312wfe.1197054404805;
        Fri, 07 Dec 2007 11:06:44 -0800 (PST)
Received: from ?192.168.24.40? ( [149.164.193.61])
        by mx.google.com with ESMTPS id m6sm46270wrm.2007.12.07.11.06.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Dec 2007 11:06:43 -0800 (PST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070716)
In-Reply-To: <Pine.LNX.4.64.0712071853500.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67442>

Johannes Schindelin wrote:
> Hi,
>
> On Fri, 7 Dec 2007, Jeff King wrote:
>   
>> ...
>>     
>
> Sounds reasonable.
>
> Ciao,
> Dscho  
I concur.  There is one case that this seems to dodge.  What about the 
case where you are in:

/test/test_2  where /test  is not tracked...

This should probably show "./../"   not just "./"   , right?
