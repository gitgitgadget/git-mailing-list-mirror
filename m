From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3] Add push --set-upstream
Date: Sun, 17 Jan 2010 00:13:20 +0800
Message-ID: <be6fef0d1001160813o674ed93dn33843813be6f45be@mail.gmail.com>
References: <1263633827-23720-1-git-send-email-ilari.liusvaara@elisanet.fi>
	 <20100116203557.95340c00.rctay89@gmail.com>
	 <20100116134656.GA4504@Knoppix>
	 <20100116233043.26a5636d.rctay89@gmail.com>
	 <20100116155612.GA8383@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Jan 16 17:13:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWBHG-00063p-V3
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 17:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859Ab0APQNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 11:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752832Ab0APQNW
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 11:13:22 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:56746 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab0APQNV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 11:13:21 -0500
Received: by iwn32 with SMTP id 32so1244075iwn.33
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 08:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=SSThG+1Z8aaykCUUP7RgyHrsjfGOVuW/0T//HDk8DUY=;
        b=iHrBjolo6+0vuh1nBIS+IZF4NEu5v1kDd+w41wboT3Ylt2iBv6LZB0NqxEpNQ3g85A
         6RjYsvnC9zlgVrGW4vPYMengSB+tLA+jQYaMlnwj5ndjKi5AkaTlTO7ETqAHaCbFhAHx
         bL9J6IbqHdeumjYVSNlvin1j4O569yI6dVvLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=r5bEGAe+rclABdnYwE8pRId5XwH02YjJUIu5v/n3jAt6q7mG1M8zWEs4Q8gaoqirBY
         TvYzutU4AMdY1YFJXQByR+9sGLT+rmCDZs1Ng1FfHl97GAmjvlYaGQRiWNkBg0cSh+Sj
         wfbuQbwDrci93rKLg91cvgM4JNshgvMqGC9os=
Received: by 10.231.168.136 with SMTP id u8mr610376iby.56.1263658400460; Sat, 
	16 Jan 2010 08:13:20 -0800 (PST)
In-Reply-To: <20100116155612.GA8383@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137233>

Hi,

On Sat, Jan 16, 2010 at 11:56 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> Hmm... In what conditions ref->status is 'none' after push operation
> has completed?

when a match between a local and remote ref is not found.

For example, the local ref 'master' will match the remote ref
'master', but not 'retsam' ('master' spelled in reverse).

-- 
Cheers,
Ray Chuan
