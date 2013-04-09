From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 9 Apr 2013 23:38:44 +0530
Message-ID: <CALkWK0=tHitdEsC8OLrhhjvL+1NoPDHtLAOEbn3MqBLG5wcbow@mail.gmail.com>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net> <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org> <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org> <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 20:09:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPcz7-0001eJ-9M
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 20:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934854Ab3DISJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 14:09:28 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:45819 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934634Ab3DISJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 14:09:25 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so8788821ieb.17
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 11:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=lMqbXLN4A8F3OCUH09tsSqUulmA9b6Ppq829x40EdB4=;
        b=LVwAb3SHnTU0LXLZs2+rM48sFY34g2ylMOfFHc7edd18gqj5miWEVR8UkohLh6AP4r
         dNIImlgSP3HFI3mvKYllFLbOVx18IjMEbyD+O6TlyMpGhPclIN9kituOec3upuNaygQj
         IYTAIqtcnbEZV3GmWj1TovDvbYxTbsi8oNUNQbELuSDyFMNScHXh4UzhDYDK4ZSDPX9X
         WHUx3xQMlNyaGF8RDz6nfA8ARFJ46N/LYV3gIT9SrTREiYeQ+bzyJAg12/4/f2YgArvM
         nnNNuNwDXDNFo8WH0dUZYJkgx1aGZ6dnBTWBP4c3bxej8YIS0S+1sxqBn4h7EDAchooQ
         Zr+g==
X-Received: by 10.42.50.202 with SMTP id b10mr15523840icg.7.1365530965507;
 Tue, 09 Apr 2013 11:09:25 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 9 Apr 2013 11:08:44 -0700 (PDT)
In-Reply-To: <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220607>

Ramkumar Ramachandra wrote:
> [...]

Let's not do anything too complex, and just aim for a more pleasant
experience for the simple case of force-pushing some refs without the
:<dst> counterpart.  Then, all we have to do is verify that what is
specified is not a valid remote, and is not a valid local path (to a
git repository, but we don't need to check that), correct?
