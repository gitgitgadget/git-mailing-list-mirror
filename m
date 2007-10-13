From: Tom Tobin <korpios@gmail.com>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 15:26:46 -0500
Message-ID: <1192307206.6103.18.camel@athena>
References: <471045DA.5050902@gmail.com>  <1192306873.6103.14.camel@athena>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 13 22:27:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnZd-0002j4-Jl
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbXJMU0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753870AbXJMU0u
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:26:50 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:46084 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbXJMU0t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:26:49 -0400
Received: by py-out-1112.google.com with SMTP id u77so2251423pyb
        for <git@vger.kernel.org>; Sat, 13 Oct 2007 13:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:to:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding:from;
        bh=xJlODvp7mrU0JDAlRkB2zClDYxXjI+ONEOT5nYyb65w=;
        b=uabaY0okojWch9L0EFAI6GabCVWyCz+d1/mGF2ut8P/ySET4taUp44wds6NaVFLNr88O3ipd+NpafHV4JUGklB/S9pC6VkZSz+pcc1714GxpzWALyI5G0rYeUGrKUTmxFkoPfFeNsGJXFK3cONcVjelDoMMseLrr6tLLD2ylDOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:to:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding:from;
        b=s8S6AYTa3/t8BVLKRZsn1Rru+JakyJONsWL/JPD++d+WUdWC9qyyYonXp8dXPkJcv6zeQIkZ/tNdOkkwwWdpg6geYwXLy9HHdKHeIKtBVxU4EXkrOqVEySylbWg47hSNlnrxlm43yymh6hNhKrkXD5mRJxHJsZxQRMN935dNN08=
Received: by 10.35.51.19 with SMTP id d19mr5375545pyk.1192307208074;
        Sat, 13 Oct 2007 13:26:48 -0700 (PDT)
Received: from ?192.168.1.197? ( [24.124.68.243])
        by mx.google.com with ESMTPS id z80sm4668165pyg.2007.10.13.13.26.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 13 Oct 2007 13:26:47 -0700 (PDT)
In-Reply-To: <1192306873.6103.14.camel@athena>
X-Mailer: Evolution 2.12.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60773>

On Sat, 2007-10-13 at 15:21 -0500, Tom Tobin wrote:
> Meh, I really need to start posting the stuff I've hacked into git.
> First the git-stash changes, now this.  Sigh.  ^_^
> 
> I have a variant of git-add--interactive that properly adds coloration
> to diffs, taking the config file values already set for the color.diff
> key and colorizing the unadorned diffs internally (rather than expecting
> the output of git-diff/git-diff-files to be colorized).
> 
> Give me a couple of hours (still setting up my Macbook after repaving it
> and installing Ubuntu) and I'll post what I've got for others to tear
> apart and point out where I screwed up.  ;)

... and now Evolution is screwing up my From: address (it should be
"korpios@korpios.com"; probably since I'm routing everything through
Google Apps).  Ah well, one more thing to fix first....
