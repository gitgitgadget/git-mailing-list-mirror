From: Casey McGinty <casey.mcginty@gmail.com>
Subject: Git automatic stashing?
Date: Mon, 8 Nov 2010 19:37:53 -1000
Message-ID: <AANLkTinwftXiZxbs_=PeM-MxQmMF4VaBCPEufH=OG6iU@mail.gmail.com>
References: <AANLkTim3MacQK6EtTPNJsYbqb=5bOM3W3BXC6p=hT+PU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 06:38:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFguV-0008Bn-F0
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 06:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab0KIFiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 00:38:17 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36786 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab0KIFiR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 00:38:17 -0500
Received: by wyb36 with SMTP id 36so4437590wyb.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 21:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=rvPVH2AVuskw2/0s5rRm/6lblm5vrY38BfqJeZhqJrY=;
        b=RaSbnaaM6HF7hFJHqqlcIYLP9UiuRbhjYLJlYqM8YrBRJkegzY10zVr/S0AH17mB9A
         uJBHNwQnTj/ZrqN+DohaLo4yhhTU3CD60WfmMue/U8PXc8BL9rnWrP80OqlMycx/bEkb
         flybcCK0mDX2rxPeuua94dseTiPYYZXS8sVXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=uQH4pAfYAL1iujObfobUCB8KB0kqVyht7/qzNAvMETyC2NK0Aw7G+cXw7EIJ42DNJK
         99tw2xd1RC9qlsr7bKuKaGvieSHCLkmtGm+p/6lxQsH5lNFtfnRN4mDHEToQrgsM4P+P
         F8HRBD6Iqi08m6rSOrEa4hx2nfN/cZ3cZ97ms=
Received: by 10.216.178.13 with SMTP id e13mr6333149wem.25.1289281095772; Mon,
 08 Nov 2010 21:38:15 -0800 (PST)
Received: by 10.216.230.90 with HTTP; Mon, 8 Nov 2010 21:37:53 -0800 (PST)
In-Reply-To: <AANLkTim3MacQK6EtTPNJsYbqb=5bOM3W3BXC6p=hT+PU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161017>

Is there any feature in git to perform and auto stash apply/pop when
trying to do a merge/rebase in a dirty working dir? This would save
some keystrokes from time-to-time, and make it easier for new users
unfamiliar with git.

Regards,
Casey McGinty
