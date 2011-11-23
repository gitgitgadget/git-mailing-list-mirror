From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: git reset --merge documentation improvments
Date: Wed, 23 Nov 2011 09:57:09 +0100
Message-ID: <4ECCB565.9020706@lyx.org>
References: <CAGK7Mr59bN8rjhLHAK0Vq=bOBBHG=N02CgGe-np=OBdTyS+rsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 09:57:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT8dr-00065Y-KZ
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 09:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236Ab1KWI5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 03:57:15 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49154 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab1KWI5O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 03:57:14 -0500
Received: by wwe5 with SMTP id 5so1910319wwe.1
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 00:57:13 -0800 (PST)
Received: by 10.227.209.82 with SMTP id gf18mr2682288wbb.8.1322038633366;
        Wed, 23 Nov 2011 00:57:13 -0800 (PST)
Received: from [145.94.168.114] (wlan-145-94-168-114.wlan.tudelft.nl. [145.94.168.114])
        by mx.google.com with ESMTPS id i8sm10616541wbp.2.2011.11.23.00.57.11
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Nov 2011 00:57:12 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CAGK7Mr59bN8rjhLHAK0Vq=bOBBHG=N02CgGe-np=OBdTyS+rsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185830>

Op 23-11-2011 9:31, Philippe Vaucher schreef:
> Hello,
>
> The current documentation for --merge is:
>
> "Resets the index [1] and updates the files in the working tree that
> are different between<commit>  and HEAD, but keeps those which are
> different between the index [2] and working tree"
>
> I think this is confusing, because [1] is the *after-reset* index and
> [2] is the *before-reset* index.

You mean that you read that the *after-reset* index is reset ? They both 
refer to the *before-reset* index.

>   If you fail to realise this it looks
> like this "resets index (so index is empty) and then updates worktree
> but skip files staged from index" -->  "but there's nothing staged, the
> index was reset!"

The misunderstanding comes from the added "then".

>
> I think a better sentence would be:
>
> "Updates the files in the working tree that are different between
> <commit>  and HEAD, but keeps those which are different between the
> index and working tree, and finally resets the index."

There is nothing to update as long as the index is not reset.

Vincent
