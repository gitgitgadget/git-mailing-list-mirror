From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: gitosis question: identifying/logging remote user
Date: Wed, 3 Jun 2009 06:24:27 +0530
Message-ID: <2e24e5b90906021754h14d0b2ah265070d958b75048@mail.gmail.com>
References: <2e24e5b90906012102y4e1e6281p437e4d88da517c08@mail.gmail.com>
	 <robbat2-20090602T062332-128740789Z@orbis-terrarum.net>
	 <2e24e5b90906020619o1bef150k43eba2870ff4fc4e@mail.gmail.com>
	 <20090602202118.GD3042@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, tv@eagain.net
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 02:54:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBekU-0001Oy-R0
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 02:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbZFCAy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 20:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbZFCAy1
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 20:54:27 -0400
Received: from mail-qy0-f104.google.com ([209.85.221.104]:33673 "EHLO
	mail-qy0-f104.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbZFCAy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 20:54:26 -0400
Received: by qyk2 with SMTP id 2so1417954qyk.33
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 17:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MdVnNqVchLc6Mixiy0RNLCsiBDUBHQ++qKFwJ3yasBk=;
        b=up/kxmu/RagBeqbr3x01ZvhxLMoitU5/aHarDEVc5IQjVN8fTVcd6NRnE8Q5whY30I
         oZE63rom72oPvftKK+KNzz+D8nFa9YbMKTj8a4NPfLTvECXOChTds0vouOP6/PZue8tX
         pjdYXAH8W5bUD8ZDhOWXu4VQyK971UVDwhmas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=df+yN+nEgKDDCXjsYPmzRzcC55r+ONzwVhCFoVEE0JZZAa6sVy0dPCIbmHa30wjbpL
         sRmQqFt+KILYcnXXbLtpB4tqh5BUBeM3nMgQsJEeGNb2sM1xJuAJCU+dp2yE2bj/jW4E
         CS3Nzq6hBRbX3wtbihG8n/hwyGJGB6T1LD1bY=
Received: by 10.231.38.198 with SMTP id c6mr99436ibe.21.1243990467966; Tue, 02 
	Jun 2009 17:54:27 -0700 (PDT)
In-Reply-To: <20090602202118.GD3042@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120567>

On Wed, Jun 3, 2009 at 1:51 AM, Robin H. Johnson <robbat2@gentoo.org> wrote:

> No, it just seems that you aren't expecting the extra level of
> indirection. Instead of explicitly exporting values via environment in
> authorized_keys, OR in gitosis-serve (like the other patch), I teach
> gitosis-serve how to find the keydir again, and extract pre-formatted
> data.

Thanks for the detailed explanation.  It makes sense, certainly.

However, I'll probably use/test the other patch :-) because that's
really all I need.  In an open source project, it's necessary for
people to see other details (GPG FP even, as you showed), but in the
kind of single-digit-team-size internal projects I manage, just the
userid is quite enough.

Also, I'm not even going to send emails.  All I want is to be able to
log each push to identify who did the push.  That log may never be
looked at, but if is needed, it will have enough information to go on
with.

Of course, if the main gitosis gets your changes, that'll be great :-)

Thanks again,

Sitaram
