From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] Add pretty format %aN which gives the author name, respecting .mailmap
Date: Sat, 12 Jul 2008 01:30:15 +0200
Message-ID: <bd6139dc0807111630j306f0225m90b501296a508552@mail.gmail.com>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>
	 <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>
	 <alpine.DEB.1.00.0807112215050.8950@racer>
	 <alpine.DEB.1.00.0807112238350.8950@racer>
	 <bd6139dc0807111455s127c5a35hfd3f01cc75614f65@mail.gmail.com>
	 <alpine.DEB.1.00.0807112310140.8950@racer>
	 <bd6139dc0807111514j75d1ae6dl3c3f5dbfb55961c7@mail.gmail.com>
	 <alpine.DEB.1.00.0807120000580.8950@racer>
	 <alpine.DEB.1.00.0807120027330.8950@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, "Git Mailinglist" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 01:31:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHS57-0008I1-Ao
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 01:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbYGKXaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 19:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbYGKXaT
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 19:30:19 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:17741 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbYGKXaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 19:30:18 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2001667ywe.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 16:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=85d6GbkZfRnTdlKC8+9Kwd3cHIQZZw3kzBJDqZw0Y5E=;
        b=BuS/8hhTbu13SGqEvtaMdfG2gByGVaX/dch1Q5aF9t+IAsJmjvSXVEttrSEk+bf6/I
         ygcySUTr3+RZcQhZtnTMgry/OcGlM/x7ageOR2icYZwisArRNN/mZV08S3pkvGPPU3or
         y+Ipt06rPzWTb2RgWqo11FPouOl46hzhJZg9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=miva8Xclcq/DSTbJtTk9DDzIVD5aY/5RzeGvcxF9jq3N2BjE8R5wPAFONWaqECuxEr
         llbZ/Viqd/tkuCmqJ4RQuudA4nD3gG7OB5K13f3++lNBJj0tHX+u3oQEnRHozgoLD4TJ
         4iEPt8Bcn2VLEAZhrnTs32U14lL0LBkYhwE6U=
Received: by 10.150.50.1 with SMTP id x1mr1947479ybx.39.1215819015210;
        Fri, 11 Jul 2008 16:30:15 -0700 (PDT)
Received: by 10.150.53.8 with HTTP; Fri, 11 Jul 2008 16:30:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807120027330.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88199>

On Sat, Jul 12, 2008 at 1:28 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> The pretty format %an does not respect .mailmap, but gives the exact
> author name recorded in the commit.  Sometimes it is more desirable,
> however, to look if the email has another name mapped to it in .mailmap.
>
> This commit adds %aN (and %cN for the committer name) to do exactly that.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Whoah, that's fast ;).
I'm not sure what to do though, if I use this new %cN GitStats will
only work with the latest git version... :(

-- 
Cheers,

Sverre Rabbelier
