From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Fix typo: we require Python 2.4, not 2.5
Date: Tue, 11 Dec 2007 14:27:08 +0000
Message-ID: <b0943d9e0712110627g70ad0aecyfeaafd8b8655fb57@mail.gmail.com>
References: <b0943d9e0712100340p78326b4avf2b7e64008bba6d6@mail.gmail.com>
	 <20071211142347.GA22879@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 15:28:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J265C-0002df-Vg
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 15:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbXLKO1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 09:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbXLKO1L
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 09:27:11 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:51742 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbXLKO1K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 09:27:10 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2054607rvb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 06:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Zc8QBDk//MgjvhwsmooO0UpTcRGwuKEcmipL2XJFzTM=;
        b=lCpRKWJGi29jLGkZbiTW/rvt3eRPPRav15phF+4fHe9MV1gf5JsYr0rJIZbmoRJ1Vc7NaySxmf01jRf5zp8kBU7zVICz0mZliD/MrpXkOPVy8YUselTx7SBWBzSFyz2GrtxTS3L5VZDwy0FTqS6PU+zHDofTyo2hFQP3WJaVVFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n9sdBKTkvFokpdvqC++egqScT/BMqKkS0O3RUrQkdXQfKbxPs1IZ1ivq4qoNc8rL7WeW+sMqB8+SQ9TLQy59tT1Ugw2HR3SNV/I9Csz1tEzdnGatBpIx38kTf+FzA3f5o5TAkXPBos3w/90DoMxh46OcAB5JmVbaebWMGOVz088=
Received: by 10.140.88.11 with SMTP id l11mr5026880rvb.1197383228674;
        Tue, 11 Dec 2007 06:27:08 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Tue, 11 Dec 2007 06:27:08 -0800 (PST)
In-Reply-To: <20071211142347.GA22879@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67860>

On 11/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>
>
> ---
>
> On 2007-12-10 11:40:41 +0000, Catalin Marinas wrote:
>
> > This release requires at least Python 2.4 and GIT 1.5.2.
>
> Yeah. So 0.14.1 (to be released very soon) should probably have this
> fix. :-)

Oops, I did some tests and forgot to revert it to 2.4. This would only
affect people using the source tarball. The rpm and deb packages
should be fine.

Is the GIT version OK or just too restrictive?

Thanks.

--=20
Catalin
