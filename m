From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit new "smart browsing" feature
Date: Thu, 7 Jun 2007 07:11:37 +0200
Message-ID: <e5bfff550706062211i7a216606l8da5e9a6f1281559@mail.gmail.com>
References: <e5bfff550706031339v5ffda0a6u6f520f0c7b49f442@mail.gmail.com>
	 <200706042004.01819.andyparkins@gmail.com>
	 <e5bfff550706051148v57715bb1q88987e3fc6410899@mail.gmail.com>
	 <200706060930.49621.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Pavel Roskin" <proski@gnu.org>,
	"Jan Hudec" <bulb@ucw.cz>
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 07:11:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwAHh-00013O-1f
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 07:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756296AbXFGFLj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 01:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756279AbXFGFLj
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 01:11:39 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:25431 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123AbXFGFLi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 01:11:38 -0400
Received: by nz-out-0506.google.com with SMTP id n1so393841nzf
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 22:11:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rjVbx/mdmQxEUVDof3mZdVPRr67VBYF8H9ru4AF51W+avfwNZmJbl7SVCzPMjFf7pFKvUQIqq8cQ+xQd4xDRiGd4bj39zZJYBIMCBh6HTphS5g9njN8MVI+p2TZyyXxjjXdo/OJoOgWWhwFHFyJEaM3Q70PzpD1miLYkhxPDDBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h4IgPeh3wIzu8zMGeWZ96M5PD4zrzMuk9gCve/avdXlqkVfOuik8s6h9Nuat0l3UdZ3w8MKpUAcKS4f6P1arm4OpqzwO3UOfcLT4Gkd4LmNLZ0uiKrnpVLZHoFm60ru9dQe7zLpfwqGViKaPOP09vpoCAYMVqg56+gPnIUG1/Ks=
Received: by 10.114.154.1 with SMTP id b1mr1198282wae.1181193097304;
        Wed, 06 Jun 2007 22:11:37 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Wed, 6 Jun 2007 22:11:37 -0700 (PDT)
In-Reply-To: <200706060930.49621.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49352>

On 6/6/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Tuesday 2007 June 05, Marco Costalba wrote:
>
>
> I've experienced a few occasions when the wheel scroll goes a bit strange.
> I've not figured exactly what I did to trigger it, but it was something like
> this: when scrolling up and down a lot, and causing the page flip to the
> message view, suddenly the scroll didn't work for normal upward scrolling.  I
> flipped pages again and it started working.
>
> I'll try and narrow down exactly what I'm doing and be more precise.
>

Thanks I'll appreciate.

This wheel scroll thing turned out to be really not trivial, BTW your
tabbed panes are far easier to implement. There are many little nasty
details to take care of to make it work correctly.


> For now, latest qgit is in /usr/local/bin, so will be getting daily use.
>

Great.


Marco
