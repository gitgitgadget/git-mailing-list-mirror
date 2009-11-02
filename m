From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Re: BUG: git rebase -i -p silently looses commits
Date: Mon, 2 Nov 2009 19:59:27 +0300
Message-ID: <85647ef50911020859l1d76d03emf1302aafab642438@mail.gmail.com>
References: <85647ef50911020818p61d0c975kd5655fa58993e07b@mail.gmail.com>
	 <9b18b3110911020833y56be8fbdoaf10b6e6259f57c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 18:03:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N50Ja-0005aR-8s
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 18:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300AbZKBRAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2009 12:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756168AbZKBQ7Z
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 11:59:25 -0500
Received: from mail-qy0-f174.google.com ([209.85.221.174]:53580 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137AbZKBQ7X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2009 11:59:23 -0500
Received: by qyk4 with SMTP id 4so2565323qyk.33
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 08:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2nu8j7/AOplLxkdssq+MnMkrvun0SVckUmQzxFwqaao=;
        b=Y0wgiFdNoVqCghggoq/H0Xsvq176zlxtBNlKkc4SPnIgv84BODWAkFd5ul5+wByNRA
         LjlTJuB0hABsK7WP3vVRuRIqzjRw4Fy8buwNZn5m1z2ybWyXospNB4xmq8zutWj0rPuA
         16bxaDcGqr0yK8umDRLvEdVRr8x6haUn9mmwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q6WwjcRp65DB6yolxJdCK5pIYh7x24I2A8bvSfJqHRRhH6lk1Yo3F1clXbzpeYcHYm
         Ff8AQQqN4a+8VgW7sg+QJ4/QrNAjcPDsIpnFdiFkWdLLE4wGxpsjGzyEVzRORe/UtW3d
         q3FgW++sSb9l2QRAP7zh4s/nnx78cIWf8XqaY=
Received: by 10.239.139.215 with SMTP id u23mr597144hbu.28.1257181167327; Mon, 
	02 Nov 2009 08:59:27 -0800 (PST)
In-Reply-To: <9b18b3110911020833y56be8fbdoaf10b6e6259f57c8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131926>

On Mon, Nov 2, 2009 at 7:33 PM, demerphq <demerphq@gmail.com> wrote:
> 2009/11/2 Constantine Plotnikov <constantine.plotnikov@gmail.com>:

> Doesnt -p ONLY work for interactive rebase?
>
> =A0 =A0 =A0 -p, --preserve-merges
> =A0 =A0 =A0 =A0 =A0 Instead of ignoring merges, try to recreate them.=
 This
> option only works in interactive mode.
>
Yep, I forgot about it. But it does not seem to work correctly for
interactive rebase either.

Constantine
