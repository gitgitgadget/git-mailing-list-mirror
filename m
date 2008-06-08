From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [PATCH 1/3] Modified test-lib.sh to output stats to /tmp/git-test-results
Date: Sun, 8 Jun 2008 16:45:27 +0200
Message-ID: <bd6139dc0806080745i2ff2489bv70a1596bcc83f700@mail.gmail.com>
References: <1212933875-29947-1-git-send-email-sverre@rabbelier.nl>
	 <m3tzg4vvgw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git list" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 16:46:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5MA1-0008HN-95
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 16:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbYFHOp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 10:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbYFHOp2
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 10:45:28 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:15445 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbYFHOp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 10:45:27 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1706369wfd.4
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=DT+fvoC5ko/F9K4w2JAEl7SG08wKbxLufAYZ3U/pm5I=;
        b=farJIRY+QEO7ivn3fmcIhvuU7g2cT9LbEm8mfOgJF06I6rp5JbESIF+JNmutsY7IZ4
         KpOX+YdbJfheoEeoA8UQYNKEDH+JNqybX9NqTqMwo6S/MuTrZ/dgyPEsoF1YZ7xoqACU
         B/udFedcNQdqrx44fTUkzbtMNFZ/XwTe3f9EY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=fsSiPBwM1OhhJZ+x0hAJ8nMYvkI+aDyS+LVPg5+QvzyNrgWy+71skVQzautH/u722t
         6CMkmxvowZ+W1nhZQtffTgUgolDVvpKlAE6SzRFzW4ivtZ7cTOhHS2ZQ0FrpJ9g2MSoM
         Ilwg4vHEaBUMQzBY12PPkwD6+AVGydXr1fgu4=
Received: by 10.142.52.9 with SMTP id z9mr985685wfz.30.1212936327549;
        Sun, 08 Jun 2008 07:45:27 -0700 (PDT)
Received: by 10.143.41.7 with HTTP; Sun, 8 Jun 2008 07:45:27 -0700 (PDT)
In-Reply-To: <m3tzg4vvgw.fsf@localhost.localdomain>
Content-Disposition: inline
X-Google-Sender-Auth: 219c364734268523
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84275>

On Sun, Jun 8, 2008 at 4:42 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Sverre Rabbelier" <sverre@rabbelier.nl> writes:
>
>> Because writing to the current directory is not possible, we write to /tmp/.
>> Suggestions for a better location are welcome.
>
>> +     test_results_path="../test-results"
>
> Errr... it looks like you forgot to update commit message.

Yeah, I intended to fix that when amending the original commit, but I
forgot. I thought I couldn't write to the current dir, but instead I
was writing to /t/trash, which of course gets deleted after every
test. Obviously outputting to ../test-results fixed that.

> But that aside, I quite like this series.

Thanks!

-- 
Cheers,

Sverre Rabbelier
