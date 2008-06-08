From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [PATCH] A simple script to parse the results from the testcases
Date: Sun, 8 Jun 2008 13:43:35 +0200
Message-ID: <bd6139dc0806080443g64403fa4o855809b70e367f0@mail.gmail.com>
References: <1210584832-16402-3-git-send-email-srabbelier@gmail.com>
	 <1212884291-13847-1-git-send-email-vmiklos@frugalware.org>
	 <bd6139dc0806071734h16aa4218md051fbbe9f025f43@mail.gmail.com>
	 <20080608004928.GG29404@genesis.frugalware.org>
	 <bd6139dc0806071756k331c9b29obc5f1cb525ef47d8@mail.gmail.com>
	 <20080608022656.GH29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, dsymonds@gmail.com
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 13:44:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5JK1-0004WU-Pc
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 13:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758124AbYFHLng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 07:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758020AbYFHLng
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 07:43:36 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:62394 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757891AbYFHLnf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 07:43:35 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1662409wfd.4
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=44p0nBO8mrzEMbkmpqE8hwL+zchBU0e49zILmsBFiuk=;
        b=Yt9GEn+O/hRFXqe2Kr5PnOHXscFybZiQ/Z8NXhY35fyO7weUjD7xh1UWbIbi8HnmhL
         BxuLHyIR3ErfkUtjgrNADU1C3H4Z5b5GQ/+OI8EuhQvxJcH0NF/unPNa2m8ZilHhPbM+
         HlZjSsE2o5CmWX1/n0lfoAG2xSYt9z7KjMu14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=D5/jG0CtQRl5X6Ft61jLXr2p2gg6pNn0hta0qvuPRB52+ID8vxTuDw8sMyDIhVu9nb
         sS6M1rTCKzYsyXRyu0TGGujJici+ZkHZOnu3Ry2CxIZFnjOpeP2caOe+07HdRs9/MBWk
         zaSnAO9LnaNvrynox/JJgCMrplDA9tjL5S8bA=
Received: by 10.142.177.7 with SMTP id z7mr909379wfe.238.1212925415507;
        Sun, 08 Jun 2008 04:43:35 -0700 (PDT)
Received: by 10.143.41.7 with HTTP; Sun, 8 Jun 2008 04:43:35 -0700 (PDT)
In-Reply-To: <20080608022656.GH29404@genesis.frugalware.org>
Content-Disposition: inline
X-Google-Sender-Auth: 6cfb51c06b0b3ec7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84263>

On Sun, Jun 8, 2008 at 4:26 AM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Sun, Jun 08, 2008 at 02:56:09AM +0200, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> Heh, I'm not sure what the protocol is here :P. I could send in the
>> series with your patch as second... that is, if I can figure out how
>> to apply it from gmail (maybe you can send me the patch as attachment?
>> :D).
>
> Or:
>
> $ git pull git://repo.or.cz/git/vmiklos.git stat

I used the 'show original message' feature, so that I could edit it
before applying. I changed the name to  aggregate-results.sh as
suggested and changed the path to /t/test-results. Now let's see if I
can make a new patch series out of this...

-- 
Cheers,

Sverre Rabbelier
