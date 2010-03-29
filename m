From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: RFC - "git editlog" feature for fixing up local commit messages
Date: Mon, 29 Mar 2010 07:41:13 -0600
Message-ID: <fabb9a1e1003290641s27306373k3a2669318a7b67a8@mail.gmail.com>
References: <20100329133132.GA12201@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Mar 29 15:41:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwFE6-0000Ui-Gn
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 15:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab0C2Nlg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 09:41:36 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:35189 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab0C2Nle convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 09:41:34 -0400
Received: by bwz1 with SMTP id 1so3563297bwz.21
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GuqiuX14kmaFfSnQbUukM2PYKKBS3GVJIUe0MrtbA50=;
        b=vs2FufVGaHlJ1q9qIjVLEM3y6+y2KqCQk5UEe5LwfD//BR5LdRxYmqBtOaiE9aAiNP
         mmeC60TMhHW7BLm7I9K3obAvZXoPsFlhfz5z51iO4cQ5iakhWPsdUD4precA8hAvSboy
         /1MEDnxmlE/Xfl/hTwma/2pz8zYLQ92dBM+cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WWYZp0nDBMMX3D5gU9LKeHd3NodUHSxmhwkxegqnfiBmFyBXXKNWjbAinGiW2BDpA6
         USmN/VKvyAI5hlDVhNfms4g3ZnILZdpSD2EuJrRcg/K4S93/J/dRkeyNjC80cDHg9eGJ
         vZpRpTDgqI1JPvrQOozhQSXgVjrmgNSR8Hbvw=
Received: by 10.204.142.7 with HTTP; Mon, 29 Mar 2010 06:41:12 -0700 (PDT)
In-Reply-To: <20100329133132.GA12201@thyrsus.com>
Received: by 10.204.1.136 with SMTP id 8mr578197bkf.92.1269870093186; Mon, 29 
	Mar 2010 06:41:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143473>

Heya,

On Mon, Mar 29, 2010 at 07:31, Eric Raymond <esr@thyrsus.com> wrote:
> Now, about step 3. =A0The official git command set only directly supp=
orts
> amending the tip commit. =A0There is a semi-documented procedure for
> amending previous commits using an interactive rebase, but trying to
> understand it makes my brain hurt. =A0Don't want to go there.

Go there anyway. These days it's as simple as changing "pick" to
"reword" on the appropriate commit. Really, give it a try.

$ git rebase -i origin/master

--=20
Cheers,

Sverre Rabbelier
