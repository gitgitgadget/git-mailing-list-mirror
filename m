From: Alex Blewitt <alex.blewitt@gmail.com>
Subject: Re: [EGIT PATCH] Provide a more JavaBeans-style 'getName' accessor for the id Signed-off-by: Alex Blewitt <alex.blewitt@gmail.com>
Date: Mon, 10 Aug 2009 19:19:05 +0100
Message-ID: <E861EAC5-150C-4CF8-AD0F-EBF15CEAE114@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 10 20:18:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaZSO-0001fN-Sj
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 20:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbZHJSSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 14:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbZHJSSb
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 14:18:31 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:59850 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbZHJSSb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 14:18:31 -0400
Received: by ewy10 with SMTP id 10so3216227ewy.37
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=PiE6esUilCnY3ZCYlwStmj3q3amRyMrZ64di8tLhOCY=;
        b=LAN67j1IdPiEtbKcyw/uy5rWaHSw5IfUKwWFMt3m+a8no87XRCpNfA4qR3TCWC5dps
         EE7iIuuFkCY9XxFwJxp26iBKgBMeE0U6bTHffw/NLFw7/qFmpqqzF4sZ71L9WQyTc7iC
         0o/rkh6Lboa83QBg1u9fR+sMvFUvs3cF4Au9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=eaY6csTa2TDOmUoG/xOVR1t9PK2oErtifpbheco3ua2k07ZC2w8UPXqv0VtPSfAm22
         Rq9PfkxZz/Z8w2HaWAmBHFNu5D5esg9jfZECmwnIzHu+wAnnqnd8R/JthMP+SC7x+QjK
         SfrZo3FCkIwph5dCJ5sVRxEZNInkolY6qDeI8=
Received: by 10.210.52.15 with SMTP id z15mr3149625ebz.36.1249928311136;
        Mon, 10 Aug 2009 11:18:31 -0700 (PDT)
Received: from ?10.19.130.185? ([82.132.139.133])
        by mx.google.com with ESMTPS id 28sm166818eye.4.2009.08.10.11.18.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 11:18:29 -0700 (PDT)
In-Reply-To: <20090810155207.GW1033@spearce.org>
X-Mailer: iPhone Mail (7A400)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125494>

That patch was originally mailed on the 11th May. Has it taken until  
now to notice the problem, or was the other method added in the last  
month or so? If I'm to blame, I apologise but didn't note any compile  
time issues at the time.

Alex

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
