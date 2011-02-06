From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] more portable absolute dir check in Git.pm
Date: Sun, 6 Feb 2011 23:32:55 +0100
Message-ID: <AANLkTimLCnYYv74NMumXHOdWuNBt3ontLo4v-Ey_0kay@mail.gmail.com>
References: <4D4D7890.3020906@io.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: rkitover@io.com
X-From: git-owner@vger.kernel.org Sun Feb 06 23:33:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmDAY-0003IR-HB
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 23:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556Ab1BFWdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 17:33:17 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62207 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481Ab1BFWdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 17:33:16 -0500
Received: by fxm20 with SMTP id 20so4292244fxm.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 14:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=2Njb9NBdwbnGKZ8QmR4n1M/vRumXefij57HWqmYnUP4=;
        b=mNs5ej5DgSin+9ym4uRa42XgxCfJHBHdeHM3AVTIbCeuPHJCbEDqdAwnWfrEjTYNFv
         3nOvsh3UrHuhxYtT/9u5j1L6KOlTlyXCX7lAQR+iheA3Y2qOAWSXEDH0Kki2t97G2VXL
         buZKwUbgUBEf6/5rYqNBKYIB6XLWIr+NEkuwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=TQYN6/pxz2irMUNnm6FaJK99R2TQ3WjXbHrw4oOXC+neKQ00k8MZUjJGkSKqbnBBfi
         nIVS/kvNNd5c6AmUyFqtNR+l534YXLoWRoRJsq8OXDKoEV/ss/13CmLaSEeBBqEVdzDT
         0lsi4eJkTUEcYM0th2drqdcoEbF6yDCRE4oKg=
Received: by 10.223.112.1 with SMTP id u1mr2905831fap.109.1297031595476; Sun,
 06 Feb 2011 14:33:15 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Sun, 6 Feb 2011 14:32:55 -0800 (PST)
In-Reply-To: <4D4D7890.3020906@io.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166209>

On Sat, Feb 5, 2011 at 5:19 PM, Rafael Kitover <rkitover@io.com> wrote:
> I was trying to get msysGit to work with activeperl. I'm not sure how far I
> got, I will revisit this problem in the future, but here is a patch.
>
> It removes a problematic make fragment that doesn't work on nmake (and
> probably dmake as well.) As well as a better absolute dir check in Git.pm .
>

Please read Documentation/SubmittingPatches. In particlar:
- We use inline patches on the mailing-list. git send-email can send
these for you.
- Your patch lacks a sign-off.

Other than that, interesting. But I think the make_frag-changes needs
an explanation.
