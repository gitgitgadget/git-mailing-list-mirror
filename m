From: Deskin Miller <deskinm@gmail.com>
Subject: Re: [PATCHv2 5/6] gitweb: last-modified time should be commiter, not 
	author
Date: Tue, 10 Feb 2009 22:10:02 -0500
Message-ID: <86d4c5e00902101910k5512efel2c9165f75d61ba53@mail.gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200902050038.57999.jnareb@gmail.com>
	 <cb7bb73a0902060314u4741528bs196a43d45ff7f283@mail.gmail.com>
	 <200902062212.08857.jnareb@gmail.com>
	 <cb7bb73a0902061500x12105a13la78703918937fe4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 04:12:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX5Ww-0007Qu-AI
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 04:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbZBKDKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 22:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbZBKDKG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 22:10:06 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:63771 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbZBKDKE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 22:10:04 -0500
Received: by qw-out-2122.google.com with SMTP id 5so273958qwi.37
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 19:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lhoWtzQdHl6cHwpkEWHXuBQnaBkQG8vOGJPm3SHHXYU=;
        b=D+dwhRXiHBsG/s8j5AIcYL+k2XsW/fTnHtNI9bWePuwUhWmQfWuerm6GGu+mhNbPWR
         1aQlD/hNYA8A6ysOHn/w9xFErWcmaFaegbVcWTS1lmxkiceErLtYUJG7Jl7+uQxr+OTl
         7rnlGO5bDj/xgbPQruh5DR5+J5A5XAhVVoFNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=l5Gqh8PtZGqSgshA+e1REpJQ3hkoDNGqxXAKH/l6ShFPPH78auf6i3Kk2ut9/3Sdru
         fl9NSAkVFY/m/cUrytCuf/xj6MRDCQ/4nrNCyZROSj+yvyMUFIclapSrz7NebtVmos5z
         XqevQEKlO987+2cWZhUDlty+QJKfIeCb6lFLE=
Received: by 10.143.29.17 with SMTP id g17mr535452wfj.109.1234321802869; Tue, 
	10 Feb 2009 19:10:02 -0800 (PST)
In-Reply-To: <cb7bb73a0902061500x12105a13la78703918937fe4b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109369>

On Fri, Feb 6, 2009 at 18:00, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
>
> The real question is: _how_ do you get the (branch) update time?
>

Sorry the topic's cold, but...

git reflog?

Seems like one could find the oldest time the commit appears in the
reflog, for the branch one is interested in.  You can use the commit
time to limit the search through the reflog, but there would be clock
skew concerns.

Deskin Miller
