From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Fix typo: we require Python 2.4, not 2.5
Date: Wed, 12 Dec 2007 14:04:11 +0000
Message-ID: <b0943d9e0712120604m97aac2cyaf60cb33c51cf9a7@mail.gmail.com>
References: <b0943d9e0712100340p78326b4avf2b7e64008bba6d6@mail.gmail.com>
	 <20071211142347.GA22879@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 15:32:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Sd0-00019T-GN
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 15:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbXLLObk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 09:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbXLLObk
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 09:31:40 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:21229 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbXLLObk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 09:31:40 -0500
Received: by rv-out-0910.google.com with SMTP id k20so223391rvb.1
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 06:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=quHPnLgDQgzT/+NdfFhcQ155gaLx8CNr/cHOXc9ZYsA=;
        b=JqOjZypJln+A5rS5C/ticm5Xkc3o/KLxwUEAJ1oDgsQu0CqgoCjxBRyqzme7ojIxmZwE22B7ot+q4QXRhbVCMuwRkwsEWfJtsSuJPZVmp8FTGmg+3uLFc0XT3EnQcwwcYilSCJNlqWjTdI8DpH9+HB7/kfQyrsvNEH7FFZO8Qbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GmxwI+1bPXFMvXG0sakP2h27bPjXQB5aGCsbWM/H7kIJzlNwkQoPal+3bRDIMwSzDHtw/MOymoixvhrilfzmIOKQ0c0QUa2VOu/RiN/8TjDPDu51lxLW4pRxRO47+8VY2VamJuzBdY9RHuM6HhkeO0oq7VxImkTS72uv+SfQkqk=
Received: by 10.141.88.3 with SMTP id q3mr351001rvl.94.1197468251595;
        Wed, 12 Dec 2007 06:04:11 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Wed, 12 Dec 2007 06:04:11 -0800 (PST)
In-Reply-To: <20071211142347.GA22879@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68039>

On 11/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Yeah. So 0.14.1 (to be released very soon) should probably have this
> fix. :-)

OK, done. Thanks.

On the RPM side, I found a way to specify the required Python version
on the "setup.py bdist_rpm" command line but I don't think it makes
any difference since the installed files will go into the python2.5
directory.

Anyway, I linked the SRPMS as well from the website's page.

--=20
Catalin
