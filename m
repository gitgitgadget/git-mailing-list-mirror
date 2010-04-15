From: "Daniel Richard G." <skunk@iSKUNK.ORG>
Subject: Re: [PATCH] Building Git on Tru64
Date: Thu, 15 Apr 2010 15:46:49 -0400
Message-ID: <1271360809.25304.1370186353@webmail.messagingengine.com>
References: <1271358589.19032.1370170305@webmail.messagingengine.com>
 <r2n81b0412b1004151229g6fe840a1v23a9d06f72e8d36a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:46:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2V1Z-0007G9-Ve
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756361Ab0DOTqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 15:46:50 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43994 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756356Ab0DOTqt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 15:46:49 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6F8D8EAE25;
	Thu, 15 Apr 2010 15:46:49 -0400 (EDT)
Received: from web7.messagingengine.com ([10.202.2.216])
  by compute1.internal (MEProxy); Thu, 15 Apr 2010 15:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=BlqFdakgFCu2tIHEg+Qn5WMfaFM=; b=MCEBF2iIxQ1TZNS2josdJtxG5GKnaO304h4LvIYmF2Hprmf+q9OZsKH/Ug1+RS5/Pz1Vk89Z5GgMqCBP5rzXEqUi/sMBJEBYQqRb1UntXVTGsvPfW5t9JXBLgUkKWFO4GdDHEbVGJpSnr6X3a/DYuVESrkuGLRuk2DdyNTaBtwg=
Received: by web7.messagingengine.com (Postfix, from userid 99)
	id 5006C13D160; Thu, 15 Apr 2010 15:46:49 -0400 (EDT)
X-Sasl-Enc: fKBgWyNpTP2vGFv6qB2pisJ5xhg8KQ+ry9iNH/An9CI2 1271360809
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <r2n81b0412b1004151229g6fe840a1v23a9d06f72e8d36a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145017>

On Thu, 2010 Apr 15 21:29+0200, Alex Riesen wrote:
>
> That one may be better handled at one place (git-compat-util.h?) with
> something like:
>
>   #ifdef Tru64
>   #define MAP_FAILED ((void *)MAP_FAILED)
>   #endif

I agree with the sentiment, but you can't have a macro refer to itself
:]

> P.S. You may consider reading Documentation/SubmittingPatches. The way
> you did it is a little unconventional.

The patch isn't meant to be committed as-is, at least not all of it.
Some of these things need to be massaged in a little (e.g. having
hstrerror.c #include git-compat-util.h instead of just sticking #define
_OSF_SOURCE at the top), but I need to hear from others on how to go
about this.


--Daniel


(Please Cc: any replies to me, as I am not subscribed to this list.)


-- 
NAME = Daniel Richard G.     _\|/_    Remember, skunks
MAIL = skunk@iSKUNK.ORG     (/o|o\) _- don't smell bad---
MAIL+= skunk@alum.MIT.EDU   < (^),>     it's the people who
WWW  = (not there yet!)      /   \      annoy us that do!
