From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] Add handler for SVN dump
Date: Sun, 30 May 2010 12:45:08 +0200
Message-ID: <AANLkTimFQAzmiRHySSSVbnfGb8WMNCF_3z9vBOCdOdiV@mail.gmail.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com> 
	<1274650832-7411-8-git-send-email-artagnon@gmail.com> <20100530085937.GA5513@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 12:45:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIg1R-00014G-6I
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 12:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127Ab0E3Kpa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 06:45:30 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63735 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab0E3Kp3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 May 2010 06:45:29 -0400
Received: by vws11 with SMTP id 11so939969vws.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 03:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LHcZVdkSPYjqDhRdZCy5LJ4tiqULo4cZMiFW3/QJCjc=;
        b=c0uPZoJrMXmG78WEtnCfwi5RduQoRhbaP7a51Yiz110BDHUV7uIKdvWgKnL5/et8A2
         hVUF3EfPUpfREvi9uocsoRQmQbLNS2d5kTTLK9l1QJXGp25r68IycEGK93BsxJT6rX1z
         6Ga2Wwbm6GUXiZKgQqcKXDfDD2KUVv2AfJoi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ND0Bf6vaxqCCApqPBef/i8RfMEHCL7rxdxU0L6hoSs6K0pdWrjyqO8IoG7yCpDQGGt
         hhe6+t2wYwMf0VWulXVRMjvtra2gerFd2bBCOEKV3Fs6GjRvsjO5q9t+Yj+DAOvopgOM
         dcZktGIz9YEf8yHyjKVvPsb5jfyY+pGW1rwGY=
Received: by 10.224.72.6 with SMTP id k6mr1108432qaj.110.1275216328113; Sun, 
	30 May 2010 03:45:28 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Sun, 30 May 2010 03:45:08 -0700 (PDT)
In-Reply-To: <20100530085937.GA5513@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147998>

Hi,

Jonathan Nieder wrote:
> Hmm. =C2=A0I suspect the svndump-to-fastimport converter might be use=
ful as
> a sort of swiss army knife even after remote-svn moves on to use
> the ra lib. =C2=A0What would you think about putting a main() functio=
n to
> build the standalone program under contrib/fast-import?

Yes, I like the idea. I'll just sort out a few things in my GitHub
fork and tell you when something's ready.

> I can write a patch for it for next round if you like the idea.

Um, I'd suggest waiting a little bit- my fork's in a bit of a mess
with all these changes from your reviews, and I don't want to merge in
more changes yet :p

-- Ram
