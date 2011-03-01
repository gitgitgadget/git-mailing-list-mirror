From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git-grep to operate across who repository and not just CWD?
Date: Tue, 1 Mar 2011 15:16:05 +0700
Message-ID: <AANLkTim78nQgS7NPXWErQyrqmt41OUXY6gzJmMwjtxo9@mail.gmail.com>
References: <AANLkTimnOSzF1o-fX-n7b26Qx2aLP3aU3pTMGY_f5hKy@mail.gmail.com>
 <4D6B6A8B.20709@drmicha.warpmail.net> <4D6C20F6.3070905@cisco.com> <4D6CA8B7.5000608@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <hordp@cisco.com>,
	David Chanters <david.chanters@googlemail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 09:17:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuKli-0005Ig-U2
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 09:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482Ab1CAIRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 03:17:14 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46249 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251Ab1CAIRN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 03:17:13 -0500
Received: by wwe15 with SMTP id 15so4126626wwe.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 00:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=EV2E7NsisVIkvXDNDgom9rVmA52QSfPYsJDx6e52ntg=;
        b=O4pZzREdWGj5DZ9UexjOEVhnGWBzdYR691J5BC7Yd0OL91ZGHDEUDi+O6I3THBtxzG
         Rt+YaLMXpjG3R+cHNVSyKWsEgOGtReZhQFVRGMaT21ncYGR457FTNwCb15Z+PbxCUpcr
         T39lSPOsmlXy+T/72zTsJAkbwuLWP4h0TXPzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XLwFuzo3FjyZ7IeLMs5Lt3tA2qehex6PZbwUMeytrGtspQ2iO6yKrE0VwX1XiU39x9
         KL9RFKeo34sMVo99CA/rqmJJMGVcCNGPcVaYhag0bmKQza8YFSPkMBnl7BZVl1rwILsz
         YEuyhk29SbNKOTpwPeRH5xAuWe0zpu1grsX8Q=
Received: by 10.216.35.83 with SMTP id t61mr3201731wea.1.1298967395104; Tue,
 01 Mar 2011 00:16:35 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Tue, 1 Mar 2011 00:16:05 -0800 (PST)
In-Reply-To: <4D6CA8B7.5000608@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168189>

On Tue, Mar 1, 2011 at 3:05 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> I would love "git grep" to be repowise, with the simple "git grep ." to
> make it relative to cwd. We've discussed making more commands repowise,
> and the consensus (which I've stated above, accepting the majority vote)
> was that some should stay, e.g. git-grep. The discussion started with
>
> <http://permalink.gmane.org/gmane.comp.version-control.git/166135>
>
> and the consensus is stated here:
>
> <http://permalink.gmane.org/gmane.comp.version-control.git/167149>
>
> This does not prevent you from submitting a "--full-tree" patch for
> git-grep, of course.

In fact Junio wrote one:

http://mid.gmane.org/7vk4xggv27.fsf@alter.siamese.dyndns.org

If I remember correctly, it was dropped because of the interaction
with pathspecs (relative to cwd vs to worktree's root). I'd be great
if someone can pick it up and finish it.
-- 
Duy
