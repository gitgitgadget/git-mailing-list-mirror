From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 3/3] Teach 'diff' about 'nodiff' attribute.
Date: Fri, 13 Apr 2007 12:30:38 +0100
Message-ID: <200704131230.41594.andyparkins@gmail.com>
References: <7vodlsd4wc.fsf@assigned-by-dhcp.cox.net> <461F602C.E9803108@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <J.Sixt@eudaptics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 13:30:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcJzQ-0006Pm-33
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 13:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbXDMLat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 07:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753541AbXDMLat
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 07:30:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:5471 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbXDMLas (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 07:30:48 -0400
Received: by ug-out-1314.google.com with SMTP id 44so524069uga
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 04:30:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sifGVpXkN3qkUICKgBqEA9MpaicHYmB7MD0XCv1svQh27sbKnjvGlVQc3MHLnna3lk5D9qQIp6but0AllAvIsiZejaYYrauxBiFfiIHOEfEFOGH7nT9G6CN74grAod9fXzMypmdRyVC+wj0+cC/t/6OK5mJv8p/jPe2/2a0tmtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LdvlIE2Efkltp2MSHoR6zDaJiYBNbUz25jL8YH8kFfFuAudeXZEUUiQaOJ9rOi1U+2lP2NNNpid2zdf9fhhB5dLuwpeJYYMIU0hX+5osUPdu95G2x/z8FpDHW6nVDJqnzMgBNsyNySTIXY2uQQU0tZe4S7dGueeG/uIHvm2g57Y=
Received: by 10.67.40.12 with SMTP id s12mr1945475ugj.1176463846969;
        Fri, 13 Apr 2007 04:30:46 -0700 (PDT)
Received: from ?192.168.11.214? ( [84.201.153.164])
        by mx.google.com with ESMTP id k28sm5039323ugd.2007.04.13.04.30.44;
        Fri, 13 Apr 2007 04:30:45 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <461F602C.E9803108@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44402>

On Friday 2007, April 13, Johannes Sixt wrote:

> -- Hannes "Can't we not have no double negation please?" Sixt

There's nothing wrong with double negatives per se.  They often confer 
more meaning than simple logic would suggest.

For example:

 I can't not hate CVS
 I hate CVS

Logically identical, but semantically different.  In the first, the 
speak would be suggesting that they've tried, but failed, to like CVS; 
in the second the speaker just hates it.  Language isn't logic, it's 
fuzzy logic :-).

The reason I think it's relevant to bring this up is that I think 
identifier naming in programming should try to use language to lead the 
reader down the same thought path as the writer.

You want a flag that controls whether a thread is running - should it be 
called RunFlag or StopFlag?

 while( RunFlag )

 while( !StopFlag )

I think that the context is important.

I, personally, wouldn't like to say which is correct in that case - or 
in the "nodiff"/"!diff" question.  However, I don't think it's correct 
to universally rule out all double negative use - they have their 
place.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
