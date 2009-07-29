From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: External Diff Tool
Date: Wed, 29 Jul 2009 22:45:25 +0200
Message-ID: <36ca99e90907291345r188a2182n77a2fd5cb55a8bc4@mail.gmail.com>
References: <4A70AE1F.7070004@idmcomp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Stegemoller <estegemoller@idmcomp.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 22:45:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWG1p-0003Xt-Dx
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 22:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115AbZG2Up1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 16:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756045AbZG2Up0
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 16:45:26 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:44349 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100AbZG2Up0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 16:45:26 -0400
Received: by bwz19 with SMTP id 19so214207bwz.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IN740GoZAlmUFEO+RtMuEMJGH+YUyhQcvQEZpLaAZiU=;
        b=nBJ6965pvk+RRUIWodasAtGyI08dHA92Nx9NMsgdf1Q7LHZx/L60YXN0NrnHkJ2beJ
         omPPt9RcOZ0+JSfmdUknw3VV/CsueK07rsrwF8TkPQU5SIKUWQ6kgQFaYCl2dEyK5ELa
         JiKtOooW0+nasr8FgZi3wqPoXVLZu0j4A6z44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BEB2aNAuCDn3GRT2QWW6UPECmOuvTXzpje6TrDKSIyd6MB0Bg1a8zvCKDGEjVfGXOW
         4NG7yBaaEb0GEyYFhPeWU/OsnHzmKYP7YXWlJvhGG4HpuDiIZ7/KYSBGzegOMWlVu5NE
         EYUeSBzVq8fTl181LBr0Wiaoj95e0KB/clTEM=
Received: by 10.223.119.5 with SMTP id x5mr219401faq.40.1248900325407; Wed, 29 
	Jul 2009 13:45:25 -0700 (PDT)
In-Reply-To: <4A70AE1F.7070004@idmcomp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124388>

On Wed, Jul 29, 2009 at 22:16, Eric Stegemoller<estegemoller@idmcomp.co=
m> wrote:
> Hello,
>
> =C2=A0git config --global diff.tool TestTool
> =C2=A0git config --global difftool.TestTool.cmd ""c:/TestTool/test.ex=
e" "$LOCAL"
Try with quoting the " inside the config value:

  git config --global difftool.TestTool.cmd "\"c:/TestTool/test.exe\"
\"$LOCAL\" \"$REMOTE\""

Bert
