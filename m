From: "Patrick Doyle" <wpdster@gmail.com>
Subject: Re: Significant performance waste in git-svn and friends
Date: Wed, 5 Sep 2007 21:07:10 -0400
Message-ID: <e2a1d0aa0709051807h53c95419r3fcb29affb92fdd2@mail.gmail.com>
References: <20070905184710.GA3632@glandium.org>
	 <7vd4wwj16d.fsf@gitster.siamese.dyndns.org>
	 <85bqcghktl.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 03:07:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT5q2-00065m-TU
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 03:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239AbXIFBHO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 21:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757232AbXIFBHO
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 21:07:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:62639 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757220AbXIFBHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 21:07:12 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1922nfh
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 18:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GqxWByaOw8gD1o6mIGVtoC+djMOIuDcQQk0Z/vxauTk=;
        b=IeQ2X4F2SkNXCwgfElVnNeyaXYMBCANYMQCYMgC71NMqZsg+pfjB6pA38095K60KBLX8koVY2R3k/Z9+JeuZFGsfH7rOHf6NlQ1oVUOWgL5RsQb+wY08S6LwmKySDNh8uQqbLNVccbVDUl8KB2iFLMVr54981CHr1vxkXCnOuU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EsVYaIwDsovrKZiIHyU+boelteR47uUUDW8ovZvje3ZP65rNpDZEOTfqyeKrYcalEfbzUeHwDJiuEyMAiIX1NqnumKYCiU8BmRewVAL5VgEGckSUIqxk0IWvsRQUxGJp5EG+VNetk2DkU54KQnV/MFbRJvnlmK9fHkcRyXFVg00=
Received: by 10.78.157.19 with SMTP id f19mr5718324hue.1189040830673;
        Wed, 05 Sep 2007 18:07:10 -0700 (PDT)
Received: by 10.78.194.9 with HTTP; Wed, 5 Sep 2007 18:07:10 -0700 (PDT)
In-Reply-To: <85bqcghktl.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57793>

I'll add my hearty vote of support, and perhaps even a patch or two,
to anything that would make git-svn faster.  Just last week, I gave up
waiting for it to complete the import of a (rather large) uClinux
distribution, falling back on SVN.  I'm looking forward to trying it
again with Mike's patch, or perhaps even implementing and trying out
David's idea.

Hmmm.... I'm supposed to be on a couple of planes for a rather longish
period of time next week.  Perhaps I'll give it a shot.  (But don't
count on much -- the laptop battery is pretty shot nowadays and, given
the nature of the rest of the participitants on this list, it'll
probably be implemented and tested by the time I pack up for the
trip.)

--wpd
