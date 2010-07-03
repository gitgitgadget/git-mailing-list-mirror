From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [GSoC update extra!] git-remote-svn: Week 9
Date: Sat, 3 Jul 2010 16:36:10 +0800
Message-ID: <AANLkTintNXXpyS5LpG6K7ltg-t6Mz0IuYT7GxMkFkVwa@mail.gmail.com>
References: <20100702215752.GD2306@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <da
X-From: git-owner@vger.kernel.org Sat Jul 03 10:36:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUyCw-0007Jf-JI
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 10:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568Ab0GCIgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 04:36:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53890 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089Ab0GCIgL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 04:36:11 -0400
Received: by iwn7 with SMTP id 7so4000780iwn.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 01:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=gwxLzI3HmOaLz8bY2GuDl4tIqQU1D8eYprnSRsvAQl4=;
        b=Z8hA7PyXjuRCG9xFsWhzwKxO4awdVumhZc3dfWVjudPmlABJ+aksbauqWNlS+gkOLx
         M5KS5yTEZDpaOuxOgA6JbXlF1PksAOAIy8Kt5z/rk7byTEHj1za49pd8zBUDKpAFc8Fs
         uIWsITT+C206KdrJjBlZAL/xrCtrV73VbE2ZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=eoic8MBmsyMAb8VlyUcEloDzuurdo7AsEmoFDFhkYDRsz31Rh7AAEgXVZsnPoV3ygo
         U9hc6Vl45IE6OrQVhzzPofVXecDCFGSAV7MxUoxe0B5TgutQHKSdJPVnASII2eS/FEF2
         T7Dg3TSHRCIqr565n8jPnL0TfnU5h9eCiZGPI=
Received: by 10.231.161.68 with SMTP id q4mr118091ibx.78.1278146170127; Sat, 
	03 Jul 2010 01:36:10 -0700 (PDT)
Received: by 10.231.210.135 with HTTP; Sat, 3 Jul 2010 01:36:10 -0700 (PDT)
In-Reply-To: <20100702215752.GD2306@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150182>

Hi,

On Sat, Jul 3, 2010 at 5:57 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> [snip]
> The client runs successfully and
> manages to dump 5000 revisions of the ASF repository:
>
> 11.34s user 3.50s system 21% cpu 1:07.69 total
>
> That's about 75 revisions per second, which isn't too bad I hope. This
> is over the network, and my internet connection isn't all that fast.

I wonder if you could mirror the test SVN repository locally with
svnsync so that we can a) spare their bandwidth b) minimize the effect
of network bottlenecks on stats - I'm sure you could get more
impressive stats that way.

Even better, having the SVN repo and the "exported" git repo on
separate hard disks to minimize I/O as a bottleneck.

(Great work, by the way.)

-- 
Cheers,
Ray Chuan
