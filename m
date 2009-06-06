From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [PATCH QGit 0/4] enhancements for the context menu of the Rev 
	list
Date: Sat, 6 Jun 2009 15:50:23 +0200
Message-ID: <e5bfff550906060650p691bd6d0o136a981159b5050e@mail.gmail.com>
References: <1244289471-698-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sat Jun 06 15:50:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCwI4-0004rp-Dd
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 15:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbZFFNuX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 09:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbZFFNuW
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 09:50:22 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:35142 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbZFFNuW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 09:50:22 -0400
Received: by ewy6 with SMTP id 6so2917721ewy.37
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fdzarYlJh0xOrINYQBWXCtQ9sZLaq13BkpNkCrxcrQI=;
        b=Ln4j40/YpsanEIgF6iDu90DcDPLvoLy4+c5YuW2f4xiOiSgZoIgWPdviBGv3afrUyV
         JStYgIcMiwkWuYrTk2rHvvJSHiJXQeQj7YyyGXt6Zv1VQFok5KtEiGcjFelFdNILVdY0
         VJapD+XtuYNhvJEpfeLEldfgGf0kk/YF5Ou6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cs+e1GgYNZSd2nKbuytQSProcx4Jc9zLvUz25WO0imgtWwlAfcgbn4SijwDyC4HXzr
         aruiFwgxZm58JDCGiQyWHYbRZiMYrpfAblPuu3SGoTrVKsh4nzF70BlZ3sm7go+DPqpX
         hUpuOgY3fTXtea3rDRrf3p57Aa25bHrQ2oOU0=
Received: by 10.216.28.193 with SMTP id g43mr1587022wea.192.1244296223533; 
	Sat, 06 Jun 2009 06:50:23 -0700 (PDT)
In-Reply-To: <1244289471-698-1-git-send-email-markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120917>

On Sat, Jun 6, 2009 at 13:57, Markus Heidelberg<markus.heidelberg@web.d=
e> wrote:
> Markus Heidelberg (4):
> =C2=A0Don't count the submenu entries for checking if it is empty
> =C2=A0Correctly count the entries in the revs context menu
> =C2=A0Avoid submenus with merely 1 entry
> =C2=A0Create a separate submenu for tags
>
> =C2=A0src/mainimpl.cpp | =C2=A0 51 ++++++++++++++++++++++++++++++++++=
+++++------------
> =C2=A01 files changed, 39 insertions(+), 12 deletions(-)
>
>

Thanks for this series. Context menu really needed some love.

Patches applied and pushed to

http://git.kernel.org/?p=3Dqgit/qgit4.git;a=3Dsummary


Marco
