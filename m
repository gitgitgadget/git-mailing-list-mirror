From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: what's wrong wtih my rebase? (git-svn)
Date: Tue, 4 Aug 2009 23:46:01 -0400
Message-ID: <c376da900908042046p1ae1a59dr6bc50fa7812a1968@mail.gmail.com>
References: <44ceb8150908041847mbf7d238r60a59ee40ef6e232@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "G.zhen.ning" <g.zhen.ning@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 05:46:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYXS9-00056x-4F
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 05:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933080AbZHEDqF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 23:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933021AbZHEDqD
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 23:46:03 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:37927 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933053AbZHEDqC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 23:46:02 -0400
Received: by ey-out-2122.google.com with SMTP id 9so89549eyd.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 20:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Id/C+YDUlM6c75JxifuxbmSeVFlev/yQKctVyPndTRA=;
        b=xtxdhvZNKRoLmA5KEImhNk20aItl3QA2+aTIoV0tarMNPqCFz08/0yDxmlULsr2hW0
         Eobyvhj/EHRkgVQpuhNLgNrqyqSTchsn2oEKZ0hiVMRuJ7B7FwAezgFJ/fx0XheMl71a
         YAriQNWXouffFtvWW2qpyoJeEGjsDVDovxqYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BJfW/vgHZlyN6eP7zZAuCj/N1W3acuIInaLZsNZvzcrBSVvi2JG+2dd0kIzIqYC570
         Rn+Ise4t+PM0sedaY1rD6w+0VABmhW+UjANp72gdEuLqQgij3clMEFTVpqFu5rFKck76
         CyPpiNvNm/+tQ7T7DTlIvJU/90FRq6AEylqzY=
Received: by 10.216.1.202 with SMTP id 52mr1655778wed.15.1249443961704; Tue, 
	04 Aug 2009 20:46:01 -0700 (PDT)
In-Reply-To: <44ceb8150908041847mbf7d238r60a59ee40ef6e232@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124846>

On Tue, Aug 4, 2009 at 9:47 PM, G.zhen.ning<g.zhen.ning@gmail.com> wrot=
e:
> git svn fetch
> git svn rebase
> git diff
> vim my.html.erb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(resolve the conflict)

? git add html.erb   # (tell git you resolved the conflict)

> git rebase --continue
>
