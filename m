From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 18:52:51 +0530
Message-ID: <CALkWK0=Tu7ttVqF1RPKvHiMQTH7dU+PKCfsZw9eq1H=vkRen9A@mail.gmail.com>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net> <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org> <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org> <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com> <20130410035039.GA795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 15:23:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPv09-0008DG-SD
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 15:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256Ab3DJNXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 09:23:34 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43828 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab3DJNXc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 09:23:32 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so482649iec.19
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=KoaJnWphY4hQAB5RBK/xFn20W3/VvV2QpECX3ZnwVlg=;
        b=MFtmhTzbG8eT2c+nKFr27Y+hkKza7ABc1uh3jdPJlc7d5f8Lwau3jAnXKuZ1KTowZ7
         xbxmxKD5Jkk8DgbXpOX8D+K3Yr7QjzrG2EuQ6cz1mlsKWTEkpaTiHF5qvL+wfIb/BzLT
         ZwMjCULdCZ7jX9q2wdi14OXPB9Rhh9UMf5IvX4Nz+qIUQWhj6PxgUc/459KKQoCOW64d
         1N3R266p4XhVuw+0P+n6GSbI8rPRGRRzoBOK07IjZCiG7X6mxPLKD8K7iLTs33wIqAgW
         oGl35+4b8+nutKl6QnG41IqnsavxxmQULRYTHl1DS2JtcbDvK2m5PDQONImF4KyApmOe
         PYOA==
X-Received: by 10.50.17.71 with SMTP id m7mr1503597igd.14.1365600211945; Wed,
 10 Apr 2013 06:23:31 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 06:22:51 -0700 (PDT)
In-Reply-To: <20130410035039.GA795@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220687>

Jeff King wrote:
>   git push --remote=host:some/path
>
> if we are willing to break the existing syntax. Though your proposal
> does have the benefit of breaking only one particular syntax which is
> (I'm guessing) less frequently used. But we'd still need the usual
> deprecation period, I think.

Why?  'git push host:some/path' should treat host:some/path as a
destination and not a refspec.  If the user meant refspec, she should
do 'git push -- host:some/path' instead.
