From: Alex Blewitt <alex.blewitt@gmail.com>
Subject: Re: [EGIT PATCH] Provide a more JavaBeans-style 'getName' accessor for the id Signed-off-by: Alex Blewitt <alex.blewitt@gmail.com>
Date: Mon, 10 Aug 2009 19:11:09 +0100
Message-ID: <A85D4F42-88A0-4508-80A2-22F069CB2F49@gmail.com>
References: <1241909854-11498-1-git-send-email-alex.blewitt@gmail.com> <20090810155207.GW1033@spearce.org>
Mime-Version: 1.0 (iPhone Mail 7A400)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "robin.rosenberg@dewire.com" <robin.rosenberg@dewire.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 10 20:11:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaZKt-0007DE-1f
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 20:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbZHJSK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 14:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbZHJSK3
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 14:10:29 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:20628 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbZHJSK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 14:10:27 -0400
Received: by ey-out-2122.google.com with SMTP id 9so923436eyd.37
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 11:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=syCRMcVU//IM2wFm2Qe+Dat7K+djqtq2ts54RsuS9eY=;
        b=rPT3ubWvgZrUJKeXMPpzoJsHRN1WcaXnMEYEZGOxiCwl9STi56GUOhkKva45AwcIZ+
         VJM4gZzZ9CqLHDmdCkm880XQWeqg/uojCNI1qQNeFDIv0z9NZOiGPlUm2MqsJUi1UnWV
         cPS+8A+9xsCwcROg/hKWDWk9hIXfIquTTNBJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=q8UYwPYuGlhgx9JHyanXT9hn1C3T8Y+iYPbYdISeu9EWcyzrDtHqv92zZSpTX662a1
         RFL2tqtHy7B+jAjeI6PTxRGHJ4nXSgqpkIbYxp1LlSmyRZEKgONNadwwGtM3DH3L1wuz
         DiWLzzY8ElxRQxgz/jB8QuwjgahqhahHeGm6M=
Received: by 10.210.128.17 with SMTP id a17mr5337897ebd.4.1249927827347;
        Mon, 10 Aug 2009 11:10:27 -0700 (PDT)
Received: from ?10.61.72.211? (94-116-72-211.dynamic.thecloud.net [94.116.72.211])
        by mx.google.com with ESMTPS id 28sm9813113eye.14.2009.08.10.11.10.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 11:10:24 -0700 (PDT)
In-Reply-To: <20090810155207.GW1033@spearce.org>
X-Mailer: iPhone Mail (7A400)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125493>

That was ages ago that I submitted that patch. I'm pretty sure that it  
compiled at the time for the version of JGit that I had back then.

Sent from my (new) iPhone

On 10 Aug 2009, at 16:52, "Shawn O. Pearce" <spearce@spearce.org> wrote:

> Alex Blewitt <alex.blewitt@gmail.com> wrote:
>> ---
>> .../src/org/spearce/jgit/lib/AnyObjectId.java      |    6 ++++++
>> 1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ 
>> AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ 
>> AnyObjectId.java
>> index acb3cb5..015042a 100644
>> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
>> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
>> @@ -448,6 +448,12 @@ public final String name() {
>>    }
>>
>>    /**
>> +     * @return string form of the SHA-1, in lower case hexadecimal.
>> +     */
>> +    public final String getName() {
>> +        return name();
>> +    }
>
> Obviously you didn't compile test this in JGit:
>
> ./org/spearce/jgit/revwalk/RevTag.java:206: getName() in
> org.spearce.jgit.revwalk.RevTag cannot override getName() in
> org.spearce.jgit.lib.AnyObjectId; overridden method is final
>
> :-(
>
> -- 
> Shawn.
