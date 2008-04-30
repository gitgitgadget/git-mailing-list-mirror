From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: About git and the use of SHA-1
Date: Wed, 30 Apr 2008 14:58:53 +1200
Message-ID: <46a038f90804291958u14eddc49sb54c7fd4a3a10381@mail.gmail.com>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
	 <481733A3.4010802@op5.se>
	 <alpine.LFD.1.10.0804291132060.23581@xanadu.home>
	 <7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com>
	 <alpine.LFD.1.10.0804291232130.23581@xanadu.home>
	 <7f9d599f0804291048n2c706f3amdf159ffe86bdbc8@mail.gmail.com>
	 <alpine.LFD.1.10.0804291352120.23581@xanadu.home>
	 <7f9d599f0804291102j4a30c344h18d12d03a6d5953b@mail.gmail.com>
	 <alpine.LNX.1.00.0804291410340.19665@iabervon.org>
	 <7f9d599f0804291331v2f44bee1y29c1580d68a3107a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>,
	"Nicolas Pitre" <nico@cam.org>, "Andreas Ericsson" <ae@op5.se>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Henrik Austad" <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: "Geoffrey Irving" <irving@naml.us>
X-From: git-owner@vger.kernel.org Wed Apr 30 04:59:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr2Xm-0001Oc-MH
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 04:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927AbYD3C6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 22:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754929AbYD3C6z
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 22:58:55 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:4054 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914AbYD3C6y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 22:58:54 -0400
Received: by wf-out-1314.google.com with SMTP id 28so210287wfc.4
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 19:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FjjwzZVL0ic7hoXr6TwdzQSF7CSQicfVanglueWNHFU=;
        b=PuAQ8nZ/bdIx+3uMLa2VZtS6wPyWPFqfS5rlSM6svn47iP5Fvqvub7j+EwP3NfKbV1Kbho/E9tCkidg4/+FHFjGH24xAIKLjVTtIXJ+18EQDyBrBAcFUf4vP5omgaPDZOhaKUvZuhtRlgCXAdsm4fIAk/V5N9L/mXWKWHxA7hz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pPjj8wHmWVpFAREPo8y3CGAZ+/IeWaL19t/+xQN+EEXuikfY0S9dU9olsrP7Sg/VKeORTXUAjWu8NIGHc0zs2NuJB9GLbVAiVO1l8OvRj79dfj7qrpziQfOAzZhEEbnRgDPQO5IGs79dRDsIIYVkmGbbRXZXOztBL7DCqQNKhp4=
Received: by 10.142.99.21 with SMTP id w21mr87116wfb.108.1209524333852;
        Tue, 29 Apr 2008 19:58:53 -0700 (PDT)
Received: by 10.142.212.21 with HTTP; Tue, 29 Apr 2008 19:58:53 -0700 (PDT)
In-Reply-To: <7f9d599f0804291331v2f44bee1y29c1580d68a3107a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80782>

On Wed, Apr 30, 2008 at 8:31 AM, Geoffrey Irving <irving@naml.us> wrote:
>  I sincerely hope that pdf/postscript don't allow the internal
>  rendering code to branch based on the current date.  That would be an
>  absurd security hole, and would indeed make you entirely correct.  If

PS is Turing complete, and does know about dates. So yes, you can make
such conditionals.

That original md5 paper with the 2 PDF files is mainly a good example
that you should trust binary blobs, that's all. The md5 trick is a
nice demo, but misses the point entirely.

I can't find it now, but someone had written a PDF file that printed
Pi computing in inside the PS VM. The tiny file would keep the printer
churning out paper until it ran out of memory. :-)

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
