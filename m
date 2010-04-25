From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Bugreport: Git responds with stderr instead of stdout
Date: Sun, 25 Apr 2010 11:10:47 -0700
Message-ID: <v2m8c9a061004251110paf7ba4e5r1997bc6262afcb1d@mail.gmail.com>
References: <20100425130607.2c92740f@pennie-farthing>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jack Desert <jackdesert556@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 20:11:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O66IZ-0003fS-55
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 20:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763Ab0DYSLJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 14:11:09 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:44637 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694Ab0DYSLH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Apr 2010 14:11:07 -0400
Received: by qyk9 with SMTP id 9so16021991qyk.1
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0IMhsXVvZSNlZbL0fpqv8yOOT0LvwCyZgxIM2oPesSs=;
        b=LW3f70rl+ny7OTKatnAi84KFaWn23Z4L1fsQ+2rE098C2NpeTH9arHTxDiOdQ00Uak
         LLS6siCukK5+PhfNq7KXeqixDLB/U6zT3BB6KYUTm05NFEzcUnyf3EDN4wPMjBgFx33g
         OEBkrbuhVI0TgDVVplIe51GgZ0HaLOYFSlpX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NGp9oUuKk0Q1MPLDXFvJykeRzN6VdJ14uhwXNyWvf/PZw1k6zd08xa/X6Bng3YlUjt
         7a4cCoWXAdu3MvnMK6BeWwbGVA2I72cDMa1tRE8QyPThuaf3DndQturs5ncM6tiYIaSD
         RfRFRRxki4OkKz6N2tRAjSVhq7hCPPWoILtU4=
Received: by 10.229.225.7 with SMTP id iq7mr3397388qcb.26.1272219067087; Sun, 
	25 Apr 2010 11:11:07 -0700 (PDT)
Received: by 10.229.50.72 with HTTP; Sun, 25 Apr 2010 11:10:47 -0700 (PDT)
In-Reply-To: <20100425130607.2c92740f@pennie-farthing>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145755>

On Sun, Apr 25, 2010 at 11:06, Jack Desert <jackdesert556@gmail.com> wr=
ote:
> I think I found a bug in Git. When I run the command
>
> =C2=A0git checkout -b new_branch
>
> Git does exactly what I've asked, except that Git's response:
>
> =C2=A0Switched to a new branch 'new_branch'
>
> comes through the stderr pipe instead of through the stdout pipe. Whe=
re do I file a bug report for this?
>
> I am using Git 1.6.3.3, Ubuntu 9.10
>
> -Jack
>
>

I can't really say if it's actually a bug, or not, but as to your
question about where to file a bug report: You just did.  This mailing
list is the correct place.
