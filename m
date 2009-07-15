From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Dividing up a large merge.
Date: Tue, 14 Jul 2009 20:34:26 -0400
Message-ID: <32541b130907141734o59d224i7e0f39aa8a85e8ef@mail.gmail.com>
References: <20090714233246.GA25390@huya.quicinc.com> <3e8340490907141716j77df346es1f894d6a7f6cb0aa@mail.gmail.com> 
	<20090715002926.GA26630@huya.quicinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bryan Donlan <bdonlan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: davidb@quicinc.com
X-From: git-owner@vger.kernel.org Wed Jul 15 02:35:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQsSf-0000yy-1S
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 02:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818AbZGOAer convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 20:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756813AbZGOAer
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 20:34:47 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:56592 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756703AbZGOAeq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 20:34:46 -0400
Received: by yxe14 with SMTP id 14so4837429yxe.33
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 17:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=rMUj/EFtBJBoGGQ9Qkb+pf9EwzubfgOgGwN/9rNNCBo=;
        b=w+Ny4nn2c/R1vd/OBhKtm2czAf6k2QrYcsLz7xDsAzOZmbtSVh+1Kvncu8z6XxOH4f
         jrM8xYy1D6j4gL3YWuUHUGxhsAF7oRAchzHQ/Co02c5r9tvypcuj/xYrGYXmSmwPly70
         9+f19EN5PDGHCWns5GzdAcOl0FyEJBBD5iZZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GHPfMvwFIWdXJuadniM6fk+H8gbtFS6UCp0Qfq+oWuqVB+DRn7EiZFPi3UUbuBHTi+
         LkNwFk4K4rtpG+4IXVn5gO4a+q9LAEFvSg4ItUl640jl/6v33Jyek9erCLfjC288AZMV
         bFk01/vDsGtasTFSb19coTEi71v6yjrESDGxM=
Received: by 10.151.144.4 with SMTP id w4mr11495827ybn.0.1247618086046; Tue, 
	14 Jul 2009 17:34:46 -0700 (PDT)
In-Reply-To: <20090715002926.GA26630@huya.quicinc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123279>

On Tue, Jul 14, 2009 at 8:29 PM, <davidb@quicinc.com> wrote:
> The real issue is that there isn't any single individual who
> understands all of the code that conflicts. =A0It has to be divided
> up somehow, I'm just trying to figure out a better way of doing
> it.

How about having one person do the merge, then commit it (including
conflict markers), then have other people just make a series of
commits removing the conflict markers?

Avery
