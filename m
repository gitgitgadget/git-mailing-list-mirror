From: Baz <brian.ewins@gmail.com>
Subject: Re: Feature Request: Branch Annotations
Date: Wed, 8 Oct 2008 12:41:43 +0100
Message-ID: <2faad3050810080441sdb1b29bxe92c467c2dd9a908@mail.gmail.com>
References: <d2115f4f0810080341m27c4ca9bv9b1e9b66704ef3fa@mail.gmail.com>
	 <d2115f4f0810080348t62e18b14x1dfe798974332b05@mail.gmail.com>
	 <d2115f4f0810080349o30b6bc2labc2745b8d981e0d@mail.gmail.com>
	 <18071eea0810080355g743c7bbfq9d7d39c9a76eb59d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Rotem Yaari" <vmalloc@gmail.com>, git@vger.kernel.org
To: "Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 13:43:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnXRj-0001iJ-M7
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 13:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbYJHLlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 07:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbYJHLlp
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 07:41:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:40319 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbYJHLlp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 07:41:45 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1536048nfc.21
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=177Pf/I6AZBTV4YiC9a8vfBtxWbBiXm65YZLnrCkLOg=;
        b=xhJfMl3p/OznRvV1PL9Zibt6bqbI6xclRzbXUZIwXj7lXV5/a3XTckyZPhJk5LHsgc
         sZdkzJf8+ZZhHIfs9utuCIlZ3X3wEoJfNdZCU27cP3xmXOfhV0lKQfsqc3Uy8VkUHM0x
         QQWA/4NKZrNbc0nu2FjIryC2hUuh2sy0G6Gp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FDKh1a5nK6Hy5it6/Ep1ey9ri9vIqGUbFRpGv+ecQn7RfH1NY6sczzVIo3I2hiTtRp
         +8UpYXP0jTlil3023fkLNcGg1Hn3zqK+7R8S1GqoB30mcxBYoQBQhore8TN5aezEnhtW
         QPZzTduvOrPlz8+lwC+rTIQjW2pcz7t4DaXh0=
Received: by 10.103.249.7 with SMTP id b7mr4376610mus.2.1223466103241;
        Wed, 08 Oct 2008 04:41:43 -0700 (PDT)
Received: by 10.103.141.13 with HTTP; Wed, 8 Oct 2008 04:41:43 -0700 (PDT)
In-Reply-To: <18071eea0810080355g743c7bbfq9d7d39c9a76eb59d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97795>

2008/10/8 Thomas Adam <thomas.adam22@gmail.com>:
> 2008/10/8 Rotem Yaari <vmalloc@gmail.com>:
>> Hi,
>>
>> I usually work with many branches in git, each of which represents a
>> different state of development/stability, but also development tasks
>> assigned to me.
>> Sometimes, besides the name of the branch, it could be useful to have
>> a short description of a branch which quickly reminds me what that
>> branch is intended for.
>>
>> Currently I see no way in git to achieve this (there's a description
>> for a repository, but not for individual branches).
>>
>> Any opinions on this?
>
> Wasn't this discussed here before, with a prototype?  ISTR it was, but
> dropped due to lack of interest?  Have a look through the archives.

The most recent thread was 'branch description' back in April, which
discussed alternatives, but petered out:
http://kerneltrap.org/mailarchive/git/2008/4/15/1442684/thread

An older thread on 'topic descriptions' where Junio described his use
of the config file for this:
http://kerneltrap.org/mailarchive/git/2006/12/6/232466/thread

And there's a similar feature in stgit, which uses the same config
setting that Junio did:
http://kerneltrap.org/mailarchive/git/2007/5/14/246358
http://kerneltrap.org/mailarchive/git/2007/4/12/243404

-Baz

>
> -- Thomas Adam
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
