From: Andrew Benton <b3nton@gmail.com>
Subject: Re: Configuring git to for forget removed files
Date: Sun, 21 Feb 2010 13:32:34 +0000
Message-ID: <4B8135F2.3000709@gmail.com>
References: <4B7FBB73.70004@gmail.com> <20100221024746.GA9628@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 15:36:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjBvT-0002iS-RO
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 14:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab0BUNcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 08:32:43 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:1293 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab0BUNcm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 08:32:42 -0500
Received: by ey-out-2122.google.com with SMTP id d26so368043eyd.19
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 05:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=++46fCiK5FfD+4TJ6+oB2f5X057nH+2gbnaAMyAWPMc=;
        b=vTdxIuyhL4j/K6qWgUuKzfiNSVf+8Ssjfx9wUJX9o3CrKtsRPMvghCkczlMN4bA5Ga
         LWShG785IA9VGXbEsVq6XTehjdAbRwW3+MoX79EpZ7Cqlkya9RttQYlWf8ZDKebvzBvj
         XaviMt0OYsSkCSWMlAwBqYOfVAkYWrywvtUkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=uBZSmfRWtW0MeSrHWZcCN3dVs4VFbXGqZGt6hSUj00HyQXc9LGvbqSEe614RuFKiVu
         RsE4glsjbLU49u4zzKz4fJv013NvIw/5n0euhEy47cIFfBak7ccUYPrVbaX77fuzDGw2
         bEAyombVDsTXYjqz25cECfWxsj0xxxkiBWc4k=
Received: by 10.213.97.85 with SMTP id k21mr2994942ebn.79.1266759158155;
        Sun, 21 Feb 2010 05:32:38 -0800 (PST)
Received: from ?192.168.1.5? ([86.112.48.122])
        by mx.google.com with ESMTPS id 16sm1487004ewy.2.2010.02.21.05.32.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 05:32:37 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.3a2pre) Gecko/20100212 Shredder/3.2a1pre
In-Reply-To: <20100221024746.GA9628@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140618>

On 21/02/10 02:47, Jonathan Nieder wrote:
> Maybe you could keep the build scripts in a git repository and
> synchronizing the tarballs out of line with some other tool, such as
> rsync or unison.

Thanks, that seems to do what I want. I'll use git to keep track of the bash scripts and
rsync -r --delete --ignore-existing --progress --exclude '.git'
to synchronise the source tarballs

Andy
