From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [PATCH JGIT] Add "compare with index" action.
Date: Mon, 23 Feb 2009 10:32:47 +0100
Message-ID: <551f769b0902230132l6fd70f20xa3d59a5df6768395@mail.gmail.com>
References: <499E67CD.9020501@gmail.com>
	 <200902221738.40753.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 10:34:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbXCc-000755-TH
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 10:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbZBWJcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 04:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbZBWJcu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 04:32:50 -0500
Received: from mail-fx0-f167.google.com ([209.85.220.167]:56324 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbZBWJct (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 04:32:49 -0500
Received: by fxm11 with SMTP id 11so1516742fxm.13
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 01:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VWEpHoecpWJ1QEKzHybj5MQeAG+IE+RVP4g1m2nj2WU=;
        b=gSMJgkHRvZGDkRa3VjFvmXCgDrbGTw+JXf54NwiOLY9RQsxqTcYYUbEh/34KNNZshr
         JN7kx/yWdcpFoo+ui9f1vUdPsZFpFiaIOcoHqenHgEYT8XihZ1YYFvh1rBRmQX0DCpMN
         whFwjPdb5jpogs2pdcuhpjrKnC/HRCbqKDiVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k5vEbxZPv3yVkOz4mTn+Y/yQTpHub4Qd586woDYf25Hw/l/sgTXPqfmBlwfwUwED9K
         c8MIL7rFYvCVvFG5JnXLrRzBKdmw1oV0wbvr6CYN3u3rX6d2u1/P53CUiQLRkRvqS6KT
         lR3Z0pKPfuLBMUgOiyfsGL6k+TPu6iyguFftI=
Received: by 10.181.2.2 with SMTP id e2mr1459804bki.74.1235381567306; Mon, 23 
	Feb 2009 01:32:47 -0800 (PST)
In-Reply-To: <200902221738.40753.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111126>

2009/2/22 Robin Rosenberg <robin.rosenberg.lists@dewire.com>:
> fredag 20 februari 2009 09:20:29 skrev Yann Simon <yann.simon.fr@gmail.com>:
>> In the Compare With... menu, the "compare with index" action opens
>> a diff editor that compares the workspace version of a file and its
>> index version.
>
> The appearance in the menu is a bit odd. "Compare with" is already in the menu
> context as that is the name of the menu that hold the Compare with index. So the
> menu name should be really be just "Git Index".

Yes, you're right.
I can change the labels to:
CompareWithIndexAction_label=Git Index
CompareWithIndexAction_tooltip=Compare with Git's index version

>> The local file can be modified and saved.
>>
>> The staged version can be modified and saved. This updates the index.
>> For this, add methods into GitIndex to allow to specify a content
>> different from the file.
>
> One would expect this feature to work at any level of the project, not just files. That
> won't be a showstopper though.

Yes of course. In that case, we would need to display a tree of modifications.
That could be done in a second step.

-- yann
