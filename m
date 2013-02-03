From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Sun, 03 Feb 2013 21:55:38 +0530
Message-ID: <510E8F82.9050306@gmail.com>
References: <1359901085.24730.11.camel@t520>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robert Clausecker <fuzxxl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 17:26:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U22ON-0000DJ-UB
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 17:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab3BCQZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 11:25:46 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38687 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab3BCQZp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 11:25:45 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so2924722pab.5
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 08:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wXbKnlmv1DeqhpkgtKSrEeFpxwIrhOh4kIisHITEyWU=;
        b=QtfqmvwYOIiB/x4xg7v0t16X0sJ48fzSRA3+g9UY+6bpGQd0/3z+rTRBi1bFDmXr/o
         9HXb/pbAr9rh6MTPz06Abnj1qc3v6Qrj1Z8o4KUg+dgwwS0hLP4dxnnDhiWcOTW1i6SP
         WKuwH4pVTvbvMpokzKF27us2ed2bWpkIw4Dyyln+eDcF45QrQzgpHqvvGsFKr5NqTKdv
         +aOxJr3+GnFIk4F1I0dFuu7bawsPT7E8hnDlTflOn1WlMCYyA/dIR0O1MjV+a4Q5od5H
         4cvX/vFK4mMhwxupPBme9GAqlAqnGmqtl7aizKP6ipJM0Q510BKDm2N+0CV2H41kAwSp
         B1QQ==
X-Received: by 10.66.74.2 with SMTP id p2mr45290390pav.55.1359908744656;
        Sun, 03 Feb 2013 08:25:44 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([14.96.69.177])
        by mx.google.com with ESMTPS id ov4sm15069469pbb.45.2013.02.03.08.25.41
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 03 Feb 2013 08:25:43 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <1359901085.24730.11.camel@t520>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215317>

On 02/03/2013 07:48 PM, Robert Clausecker wrote:
> Hello!
> 
> git currently has the archive command that allows to save an arbitrary
> revision into a tar or zip file. Sometimes it is useful to not save this
> revision into an archive but to directly put all files into an arbitrary
> directory. Currently this seems to be not possible to archive directly;
> the only way I found to do it is to run git archive and then directly
> unpack the archive into a directory.
> 
>     git --git-dir REPO archive REVISION | tar x
> 
> It would be nice to have a command or simply a switch to git archive
> that allows the user to put the files of REVISION into a directory
> instead of making an archive.

Could you help me understand why piping it to tar (actually 'tar -C
/dest/dir -x') is not sufficient to achieve what you want?
