From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [BUG] git-svn dcommit fails (connection closed unexpectedly)
Date: Fri, 11 May 2007 13:30:46 +0200
Message-ID: <8c5c35580705110430w12076cfbs527be3c404ea07a5@mail.gmail.com>
References: <vpq7irfengj.fsf@bauges.imag.fr>
	 <8c5c35580705110427o4de686e8qdb37f6a2da0043e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, "Eric Wong" <normalperson@yhbt.net>
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri May 11 13:30:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmTKm-0004kV-Ni
	for gcvg-git@gmane.org; Fri, 11 May 2007 13:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757670AbXEKLas (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 07:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757724AbXEKLas
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 07:30:48 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:36914 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757670AbXEKLar (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 07:30:47 -0400
Received: by nz-out-0506.google.com with SMTP id o1so955205nzf
        for <git@vger.kernel.org>; Fri, 11 May 2007 04:30:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ll/YMzgYETvSHOQWQJchFKgQLal8a1TEi2Y21xbQFAUp6wRqwRaqrOmgWlSNuWECezH1OU94TOWrm7loTP3jtqDQJRdtQieWLVUq2C2bTSw7AXRCn5LhpNl1yhnEexwnZ76NzB9OF/zi8CpG6kv9iHAj0a0V6oNdNKAZHN9Gcq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GV2TATYZ3ygc1ULscH5KdcmRs+ms3ZFBytuX+80UWGnoIG7uUQQ/8Cjg7/txbdNkqzVHnEh833wTuDIVDV4pgHHalG/Ugq9U/REalOyz5TpyzJG4RO1KUwU6xfqeP/+VehhJLaNG6ARuhKs5oprAkvC7Y0Eh4B63rX7SQsllGYY=
Received: by 10.114.178.1 with SMTP id a1mr927869waf.1178883046684;
        Fri, 11 May 2007 04:30:46 -0700 (PDT)
Received: by 10.114.234.19 with HTTP; Fri, 11 May 2007 04:30:46 -0700 (PDT)
In-Reply-To: <8c5c35580705110427o4de686e8qdb37f6a2da0043e4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46954>

Hmm, your MUA fooled me to reply to the wrong people...

Can you please don't do this:

  Mail-Followup-To: git <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>

--
larsh
