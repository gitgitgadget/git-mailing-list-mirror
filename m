From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v2] An alias that starts with "!!" runs in the current
 directory.
Date: Thu, 06 May 2010 07:26:40 +0100
Message-ID: <1273127200.3562.10.camel@dreddbeard>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
	 <20100505005153.GC25390@coredump.intra.peff.net>
	 <4BE115EF.8010306@viscovery.net>
	 <20100505070131.GA11265@coredump.intra.peff.net>
	 <19425.9169.537598.876589@winooski.ccs.neu.edu>
	 <7v1vdql4c9.fsf@alter.siamese.dyndns.org>
	 <19425.54504.163875.379151@winooski.ccs.neu.edu>
	 <19425.58290.42871.986460@winooski.ccs.neu.edu>
	 <1273098179.723.10.camel@dreddbeard>
	 <7vpr19j4ng.fsf@alter.siamese.dyndns.org>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eli Barzilay <eli@barzilay.org>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 06 08:27:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9uYR-0006Iq-70
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 08:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827Ab0EFG1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 02:27:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63505 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab0EFG1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 02:27:18 -0400
Received: by wyb35 with SMTP id 35so914031wyb.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 23:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=Ll6cA3/NLZ2O8gbjUfxP7drfK6f52iWH/9otzBhpRwM=;
        b=MdMNbuvl5f9KnwGxDkaO/V+qsg7xmDPrnX1I9nfdIJPuOnhqqdOkbDcP8WwLZK556k
         hkXJZF/1IUx6dMOKzaQGrarxvkPhDUgd/8R+m8FrwhA5EvybekNHJ/Q65MYQPCFY11aw
         7ElLPhBVwr4biwes0I23UO5Mh9567guegpaVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Ol0Km/7eEkgUq9DvzyjjfQVTrYl9Rs5NOby8JZYFV5GNmBBM/BUXM3VVrmqj13dc0/
         0ec8+FrWzFjn2KTAmzUaAVofev3y7Avjk498W9nopGGOlGwL8ACvESkq66dQZbuo6MhY
         82JwuqEigg1+9K4fGPJUQ7EwQEZhixn8a9g08=
Received: by 10.227.157.69 with SMTP id a5mr3790632wbx.146.1273127236494;
        Wed, 05 May 2010 23:27:16 -0700 (PDT)
Received: from [192.168.0.129] (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id u8sm4906949wbc.17.2010.05.05.23.27.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 May 2010 23:27:16 -0700 (PDT)
In-Reply-To: <7vpr19j4ng.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146444>

On Wed, 2010-05-05 at 16:43 -0700, Junio C Hamano wrote:
> What other variants might we want to be able to specify while defining and
> using aliases?  If cwd vs root is the only distinction, then !(cwd) would
> be a bit overkill, but if we used !! for this new feature, I suspect that
> it would make it much harder to switch the default in the future.
> 
> Comments?
> 
> 

What I had in mind when I mentioned !(...)  were some half-formed ideas
about shortcuts for manipulating the environment, !(nopager), for
example.

But these ideas were vague and I can't think of any off-hand which I
would use other than !(cwd). I'd say !(root:path/to/dir), but that's
obviously not necessary (any more than !(root) would be, if cwd were the
default), and honestly I'm quite happy using shell functions for that
sort of thing.

-- 
-- Will
