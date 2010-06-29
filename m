From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] fast-export: Add a --full-tree option
Date: Tue, 29 Jun 2010 07:02:02 -0600
Message-ID: <AANLkTinwiFgFBKu7JGaS9WEHGOhkW50iE4pmvXlA3y-W@mail.gmail.com>
References: <1277774525-12530-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes.Schindelin@gmx.de, Elijah Newren <newren@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 15:02:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTaS7-0007cA-Aq
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 15:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab0F2NCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 09:02:05 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36621 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206Ab0F2NCD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 09:02:03 -0400
Received: by vws5 with SMTP id 5so1416375vws.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=audO2PiaA1Lj+5eAgJXUhM4t5P4vO3zUhUDww5KDhhc=;
        b=iQzp4iJEnA2I1VenXr16ni2wT75ew0PTww005DMWuvnLQrs2T7G1uN/uujZyAhZifL
         0RNFsgOKE3+jQnOen4Y+n7xUbOmSStXKX4LVWG5Y3pP91rEbAmLlPat0t147VLyM+67s
         0X+KG79IhYy3a4Xso0mv8VJujhp6lfisaVO3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Xu/HrT6A8ieo1ZhHKsDMVo197I6dDovtyyQPuE7e5FPHFMEzpfYogI3R/HCnNXfzQk
         yFJYM/4RGktqwKOvwda9NqxxSc9qrpC6g7psKMtu3Ea1XEw+h7zL59i26ZNAhNAR6aV6
         GcEiRyOHRXMgf4jsWyrFNIXSbxiuAHwZlkAoI=
Received: by 10.220.63.4 with SMTP id z4mr3810622vch.245.1277816522266; Tue, 
	29 Jun 2010 06:02:02 -0700 (PDT)
Received: by 10.220.83.138 with HTTP; Tue, 29 Jun 2010 06:02:02 -0700 (PDT)
In-Reply-To: <1277774525-12530-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149903>

On Mon, Jun 28, 2010 at 7:22 PM,  <newren@gmail.com> wrote:
> From: Elijah Newren <newren@gmail.com>
>
> This option makes fast-export issue a 'deleteall' directive and then the
> full set of files that make up each commit, rather than just showing the
> list of files that have changed since the (first) parent commit.
>
> This is useful in at least two cases:

I just noticed looking searching through older list emails that
Johannes has apparently left git development
(http://kerneltrap.org/mailarchive/git/2010/4/27/29263), is that
correct?  If so, that's a big loss for the community.  :-(

I guess that also means I need to cc someone else to review this.
According to shortlog --no-merges, I'm the top committer to
fast-export, followed by Johannes (though his patches were bigger and
included the initial write of the file), followed by a string of 2-3
commit persons.  Hmmm....  Shawn: could you take a quick look?

Thanks,
Elijah
