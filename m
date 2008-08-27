From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [EGIT PATCH 0/6] Fetch UI, minor improvements/fixes
Date: Wed, 27 Aug 2008 22:09:33 +0200
Message-ID: <48B5B47D.2000004@gmail.com>
References: <1219862506-11075-1-git-send-email-marek.zawirski@gmail.com> <200808272148.02345.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:10:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYRLq-0002Is-S6
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 22:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbYH0UJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 16:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbYH0UJl
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 16:09:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:2714 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbYH0UJk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 16:09:40 -0400
Received: by nf-out-0910.google.com with SMTP id d3so12333nfc.21
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 13:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PTQVq6gzb7ncAVHjHumJ7qKg/n1E1NPayNPYdyB4Wo0=;
        b=C4vluRRweCrbeCo/0Ss4q0fYz5X2BpcgxGNUOt7LqS5/SjcoTNuqwNMcKxFXJ7tnG9
         DJFjTsrj/j0EaZBFXZPvUgR6TEA4Jd/t2Ac1gSNqBkURtC2p80vjJ+1oxKWY8gYC9tRu
         VwYOit07EG3FLeN7POgpWtfj/LOjacmu2kID0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=WMyJ3FWutK7xIHjkH2JxG83L/TlzTs/K+Nq94vd/OIvN4qHcrmPnMoRi+K6q8RleyA
         ZJBN7VbBScxSfvhEp+f4db1815F9Ez5HYbqVoLr1Oqn/wUx2t8fpGJVe0qKKImC3jRpH
         OgJZ0p/Mr568v8cFO8CNwUEP4Rd0S7TO1xxO4=
Received: by 10.103.208.15 with SMTP id k15mr248911muq.84.1219867777928;
        Wed, 27 Aug 2008 13:09:37 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id u9sm330197muf.9.2008.08.27.13.09.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 13:09:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080702 Iceape/1.1.11 (Debian-1.1.11-1)
In-Reply-To: <200808272148.02345.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93938>

Robin Rosenberg wrote:
> onsdagen den 27 augusti 2008 20.41.40 skrev Marek Zawirski:
(...)
>> isn't that right time to release next version?
> 
> Indeed, this is the missing piece for a coherent version.  I'll have yet to
> review the stuff, but I have great confidence in your work.

Sure, I even wouldn't like to have my code accepted without your review:)

>> OT(?): The only strange thing I observe now is how "refresh" resources
>> works in egit (master), but maybe I'll open new issues for that.
> 
> We might have bugs there.... Or actually, I *know* we have bugs including
> lockups. But I can consider bumping the version anyway by next weekend, since
> automatic refresh can be disabled. That'll leave us some time for things to cook.

I also encountered issues with locking workspace one day, but I actually 
meant something different.
See http://code.google.com/p/egit/issues/detail?id=14

BTW, is it possible at code gooogle to receive e-mail notifications 
about new issues?
-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
