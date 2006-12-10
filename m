X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Sun, 10 Dec 2006 16:06:14 +0100
Message-ID: <8aa486160612100706y92bc722n93374e394fc58005@mail.gmail.com>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 15:06:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=abFFbfWe95ElnckjYW7nyCkhKeltMChEAYu2uful2nygzj3JvgLRjtGvykfa1zNylofXXkFmoNh/DwsNwqWqxpmhSdUSwoIzYU4RI4DXVyKkKWZIvmc0g5hROZDTZJyjRjPiVsqbw6PKyHsioKB2lOUaJsBHXt9HjiQ4nRdXxZ8=
In-Reply-To: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33894>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtQFx-0007xL-9D for gcvg-git@gmane.org; Sun, 10 Dec
 2006 16:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760814AbWLJPGR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 10:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760836AbWLJPGQ
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 10:06:16 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:51088 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760814AbWLJPGQ (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 10:06:16 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1309667wxd for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 07:06:15 -0800 (PST)
Received: by 10.70.116.1 with SMTP id o1mr10343663wxc.1165763174829; Sun, 10
 Dec 2006 07:06:14 -0800 (PST)
Received: by 10.70.46.19 with HTTP; Sun, 10 Dec 2006 07:06:14 -0800 (PST)
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Sender: git-owner@vger.kernel.org

On 12/10/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> I've recently become somewhat interested in the idea of using GIT to
> store the contents of various folders in /etc.  However after a bit
> of playing with this, I discovered that GIT doesn't actually preserve
> all permission bits since that would cause problems with the more
> traditional software development model.  I'm curious if anyone has
> done this before; and if so, how they went about handling the
> permissions and ownership issues.
>
> I spent a little time looking over how GIT stores and compares
> permission bits; trying to figure out if it's possible to patch in a
> new configuration variable or two; say "preserve_all_perms" and
> "preserve_owner", or maybe even "save_acls".  It looks like standard
> permission preservation is fairly basic; you would just need to patch
> a few routines which alter the permissions read in from disk or
> compare them with ones from the database.  On the other hand, it
> would appear that preserving ownership or full POSIX ACLs might be a
> bit of a challenge.
>
> Thanks for your insight and advice!

I have not used it, but you could try:

http://www.isisetup.ch/

that uses git as a backend.

