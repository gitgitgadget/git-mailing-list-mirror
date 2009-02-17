From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: FETCH_HEAD question
Date: Tue, 17 Feb 2009 12:34:18 -0500
Message-ID: <76718490902170934u5e2c17ffl7599ddeb5ee59812@mail.gmail.com>
References: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>
	 <7veixxaale.fsf@gitster.siamese.dyndns.org>
	 <76718490902162221i31e02052j48c9f620a2d47985@mail.gmail.com>
	 <7vr61x8ra4.fsf@gitster.siamese.dyndns.org>
	 <76718490902162341y2f122427i470c77d3915ff554@mail.gmail.com>
	 <7vy6w5795h.fsf@gitster.siamese.dyndns.org>
	 <76718490902170914p6258b77ak81318f13757f0dfd@mail.gmail.com>
	 <alpine.DEB.1.00.0902171821190.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:35:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZTrJ-0007oy-ID
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 18:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbZBQReV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 12:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692AbZBQReV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 12:34:21 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:29867 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbZBQReU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 12:34:20 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2102469rvb.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 09:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CkrJoJcGe1gChwcxV+DX94mt+Xc4/ELtp5HXTfoiPBA=;
        b=OQOHzdOSDUeTK3wxWTYPvXtqI+6OrZvBiTr0j4T2gOPpaDBtSJ52NOngoWHxBjQd+M
         OHGxx8J6sBVIkBPl/2smqCOWzd/FVUapWF77YFtA9m9kkEtoayqJthPQNS0/tEOwfquz
         9hWzSvlaatBtubc2i45oSKQ6OIv8C3CUHsb0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gy31Y7lWs9PhH9jlNccDeIz7sRoH8uC2sO4HnklT55/W1jzxvon542bO0sGtFDyIYe
         FMgQ53C/vE4VCD4XKjah0GxsdnJW7eVfu49pVbHMyyJgis4wa+bG4SdXATGCfXq5Yt9O
         T3kgIZI/XDJh+W+0SrgnRLucl5ngQZBkyOe7w=
Received: by 10.141.133.14 with SMTP id k14mr2255300rvn.98.1234892058915; Tue, 
	17 Feb 2009 09:34:18 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902171821190.6185@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110421>

On Tue, Feb 17, 2009 at 12:22 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> Unless dwim_ref() is updated to handle FETCH_HEAD specially, and
>> return not the first SHA1, but the one not marked "not-for-merge".
>> Then the UI would at least be consistent, but this would not be
>> backward compatible.
>
> You cannot fix parsing FETCH_HEAD as a ref (and neither will you be able
> to do with PUSH_HEAD), as it can contain _more_ than one SHA-1s.  This
> still holds true when ignoring the not-for-merge lines, as an octopus is
> a quite real possibility.

An even better argument against than it not being backward compatible. :-)

And there is no PUSH_HEAD.

j.
