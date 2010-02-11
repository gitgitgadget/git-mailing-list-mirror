From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Problem adding a symlinkg
Date: Thu, 11 Feb 2010 13:01:59 +0100
Message-ID: <81b0412b1002110401mc77bd68w28034ca0e7fc537@mail.gmail.com>
References: <1265869060330-4553010.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Arnaud Bailly <abailly@oqube.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 13:02:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfXkI-0004if-Jp
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 13:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab0BKMCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 07:02:05 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46616 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab0BKMCB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 07:02:01 -0500
Received: by bwz19 with SMTP id 19so260986bwz.28
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 04:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=MpfwPGF5IsERYtGRo6939/USngCwBwlzNaVjWSayoEk=;
        b=LVedxEA9TgS4VcX80pxYITE7U7a5KCbO1HaRtaQHyiyPYBy8jRrF07a8UE+VtgKsl6
         QG0OgVQzhPt54XHXN2L3VOgxfitl3ZGW1n+lLt5RokTmYtMnGRjq3Cv4H/PVrAmd4H2S
         2W8MTeeUpOOXuM0cFOu77bOzus/p2q5hADRGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=J8Y3S1UgzjFuRrpEh71c4SkoghLo10V9Pv8ooZ9oDjkfTsKFVg7jDAW78Xzofihh76
         qKtK8yFeY2UIDwZuFKePOiJpdOVLESlBHoPS3iJYiACzCOEOxK6t9fIh7DPX3YFTFHLV
         ToJZrstKtLZXLem4fEyPDCzBytKGZq1UruqY0=
Received: by 10.204.175.68 with SMTP id w4mr1059899bkz.213.1265889719893; Thu, 
	11 Feb 2010 04:01:59 -0800 (PST)
In-Reply-To: <1265869060330-4553010.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139585>

On Thu, Feb 11, 2010 at 07:17, Arnaud Bailly <abailly@oqube.com> wrote:
>
> I am trying to add some symlink to git and got the following error:
>
> error: readlink("protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so"): Invalid argument

Is the file in fact a symlink? Maybe it was replaced by a file while
Git was adding it?
If it is reproducable, could you strace "git add" and post the trace here?
