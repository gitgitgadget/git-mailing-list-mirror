From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [PATCH] Teach git diff about Objective-C syntax
Date: Wed, 17 Sep 2008 15:32:29 +0100
Message-ID: <57518fd10809170732g507bc60ar4427f940b4343c37@mail.gmail.com>
References: <1221610063-33610-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <1221648564-56239-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <alpine.DEB.1.00.0809171205430.14329@racer>
	 <57518fd10809170637n585afacbs94fdddc5b8bb61b6@mail.gmail.com>
	 <alpine.DEB.1.00.0809171528120.14329@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, vmiklos@frugalware.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 17 16:36:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfy69-0004am-BY
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 16:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbYIQOcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 10:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbYIQOcc
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 10:32:32 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:53747 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbYIQOcc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 10:32:32 -0400
Received: by gxk9 with SMTP id 9so29628376gxk.13
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=NfHQ3tqIWlN6QofN3VOWGUpcI/7HyTu14JJR+zUwwCM=;
        b=i5vfDSEJRoTRIxNVRhmwfzBS16Fndd7odTZ/906Visq1fKeESnuWRG7nBXuuN8w5Dp
         SsbdVUnV3YtBH5qdSNJDvLU2SODLZqofKVTAuduUUw4hmPZHZujViT8zRmHq6UTXkCVm
         uG7xw5ZsVUWdk9D7ZkAA+NDKf+umY6xC52lM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=Ty5gpaePpvLbjOmUQWLjkcRLiF7W6SVm5SeLr7UOVbp+6FtY+hyxeyO2nXcGaXmll6
         G/3Cx6AYoaR9NkJJOpNQcwzR74ZnLNyEXtVgpGlK/mdJ7YXPyftu5U9NiBNUKYsXGJEN
         U4BviXgrTGgfa4lSVfaBA8VPvIpTYVW1nLN00=
Received: by 10.142.48.3 with SMTP id v3mr895950wfv.8.1221661949325;
        Wed, 17 Sep 2008 07:32:29 -0700 (PDT)
Received: by 10.143.6.3 with HTTP; Wed, 17 Sep 2008 07:32:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0809171528120.14329@racer>
Content-Disposition: inline
X-Google-Sender-Auth: 4acd9e51c32d4a09
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96117>

On Wed, Sep 17, 2008 at 3:28 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 17 Sep 2008, Jonathan del Strother wrote:
>
>> On Wed, Sep 17, 2008 at 12:06 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > Hi,
>> >
>> > On Wed, 17 Sep 2008, Jonathan del Strother wrote:
>> >
>> >> -                     "^[     ]*\\(\\([       ]*"
>> >> +                     "^[ \t]*\\(\\([ \t]*"
>> >
>> > Why?
>>
>> Sorry - missed that in the original reply.  You really prefer having
>> an invisible tab character to an explicit \t ?
>
> No.  But I prefer clear-cut commits, not sneaked-in changes.  This is a
> change in the java part FYI.
>

Sorry, I considered it to be a formatting change & didn't think it
would matter.  I'll separate them out & repost later
