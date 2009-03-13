From: Imran M Yousuf <imyousuf@gmail.com>
Subject: Re: Not pushing all branches?
Date: Fri, 13 Mar 2009 14:12:02 +0600
Message-ID: <7bfdc29a0903130112w17d40473s14a895d518dbf8ae@mail.gmail.com>
References: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Mar 13 09:13:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li2WP-0000Tg-2D
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 09:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbZCMIMI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 04:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbZCMIMH
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 04:12:07 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:40992 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbZCMIME convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 04:12:04 -0400
Received: by wf-out-1314.google.com with SMTP id 28so299503wfa.4
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=goddbajMRiJ0BUCxaFXxLDhSrdgiSS+i5NzngqGGvAg=;
        b=HPXJD08ipOi9X1wTyD1IcoH+Pp2c60rXZyu11ETnc2Ku3DzwFSBfCftN3MkDY+cSZD
         2SyuSdI8LaqMIjw3i1TIuNppIr6abyPsI/g34RGNVgOFQJjsEzbXKowUKz6oWl/lcKhE
         +gMUi78m4zISsZIvhGUJlgfL8mSzRcP11IViM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UrkZ8fXlYDSND928mSusAQEWlA4ypMGqIdcc4CgPDT2UEsswCJpeica/Fdw2MBVHuo
         VgpWH2RW7oHK4ZHjkJcsfweSzz0/Wmw+WZ1BUmgP1yy1sSsE4NlxKVe0wGxKkvlOHCvM
         MvvpCzJR+jLbUlSZqAFv3K3nk8eMgwlrE3cp4=
Received: by 10.142.242.8 with SMTP id p8mr430957wfh.60.1236931922767; Fri, 13 
	Mar 2009 01:12:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113154>

On Fri, Mar 13, 2009 at 1:48 PM, Peter Krefting <peter@softwolves.pp.se=
> wrote:
> Hi!
>
> Doing "git push remote" pushes all my local branches by default. Is t=
here a
> way to set it to *not* do that, and (for this particular remote repos=
itory)
> just push the current branch? Or failing that, not allow me to run "g=
it
> push" without specifying a branch?

Just try -
git push remote branch :)

>
> The git-config manual page leads me to believe that I should recofigu=
re
> "remote.<name>.push", but it points me to the "refspec" spec on git-p=
ush,
> which is a tad cryptic.
>
> --
> \\// Peter - http://www.softwolves.pp.se/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
