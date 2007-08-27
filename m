From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: Confusion about diffing branches
Date: Mon, 27 Aug 2007 15:21:32 +0200
Message-ID: <38b2ab8a0708270621l63f3da56j4667014e62a5de92@mail.gmail.com>
References: <20070826233555.GA7422@mediacenter.austin.rr.com>
	 <7v6431omn8.fsf@gitster.siamese.dyndns.org>
	 <20070827014056.GB7422@mediacenter.austin.rr.com>
	 <7vlkbxmp50.fsf@gitster.siamese.dyndns.org>
	 <20070827075009.GA31438@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn Bohrer" <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: "Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:21:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPeXA-0000iV-E6
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 15:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbXH0NVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 09:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbXH0NVd
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 09:21:33 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:55921 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbXH0NVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 09:21:32 -0400
Received: by wa-out-1112.google.com with SMTP id j4so2047024wah
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 06:21:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OWBfrDHH6RZp89kbUffDG2OimtqybrPX+m3pLcQkqUS3LxwhZ+otZT3aiajrXpz2X4nOvsX1yNSO1DKeW8S3KtYALzs6TC+KkZC9+lsG9NLh5Hj6A03IIzCpcy+O8M4W3URVk6YOVyQ07j9fuPN2TVPupl2CwiatAxszgYg/ypA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AIZUeM1EI/25ls0xeXjkb9NB2NiwcaMJRo+a3zv6/wAyfdZFrp44aZVauYTThFFhCp0VzU0zrkx9sbVM/Iy6YOsWAWvxtOUtcBiZhb+IGqwoVaNXD4M9HdHyTWJ8MT/NCbZ7OhoqTcPSMkrCyV4ZZYWkvCgu48bZW4vyH0FOZh4=
Received: by 10.114.193.1 with SMTP id q1mr849184waf.1188220892312;
        Mon, 27 Aug 2007 06:21:32 -0700 (PDT)
Received: by 10.115.47.5 with HTTP; Mon, 27 Aug 2007 06:21:32 -0700 (PDT)
In-Reply-To: <20070827075009.GA31438@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56829>

Hi !

On 8/27/07, Mike Hommey <mh@glandium.org> wrote:
> On Mon, Aug 27, 2007 at 12:07:39AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > Both semantics of two-dot form and three-dot form are useful,
> > and choice between the two depends on what you want out of the
> > command.  You just need to know which one you want.
>
> The problem is not about usefulness of these 2 forms, but consistency
> with the rest of the tools.
> If I go git log a..b, I won't get the set of commits involved in
> git diff a..b. In fact, git log a...b does. And git log a..b gives the
> commits involved in git diff a...b. Confusing, isn't it ?
> Moreover, this inconsistency isn't even documented in the manual pages.
>

This "inconsistency" had already been raised before. Please refer to:
http://www.gelato.unsw.edu.au/archives/git/0612/35354.html

I shared and still share your feeling about that but it seems that
Junio and Linus don't...

good luck ;)
-- 
Francis
