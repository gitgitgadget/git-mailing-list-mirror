From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Fri, 26 Apr 2013 17:05:04 +0530
Message-ID: <CALkWK0mLdGPAJZC=KgYrTS3pCOacEdNyS3XT1eOPKjTbvRk3cQ@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <7vvc7baahc.fsf@alter.siamese.dyndns.org> <CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
 <CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com>
 <7vppxj6thv.fsf@alter.siamese.dyndns.org> <CALkWK0n9xqQr30QWEuhuM9c1xrAJ=SpYVBjkiRk+tP5E7DtBGw@mail.gmail.com>
 <CALkWK0kSWHS0JJ9E4PPihRru0-H13mNffJ5Hndg+LqvFzsYG8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 13:35:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVgwQ-0007UD-1K
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 13:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933Ab3DZLfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 07:35:46 -0400
Received: from mail-ia0-f171.google.com ([209.85.210.171]:48968 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab3DZLfp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 07:35:45 -0400
Received: by mail-ia0-f171.google.com with SMTP id r13so3489725iar.30
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 04:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RmiZZkzhvnFbcuqRIJ/bqJHuDxWvLNa5gaCgUL14Nwc=;
        b=XRzOPT2Oo8eI3RVN82triRTJlf5P0iwZKx653nHUNPPxWnynHcrHfrVDHfPOTXSSdz
         wTovbSGjojkhfGASukKqBwA3OfvuDdj4TLtG8HP7M12xj591Xf0+4xwGwbWNW0x6VAWS
         Ojx5lalSoQF18QNsm3f4IYb2O1hEiTC9S6WOA+OY+7k/eXWVol+aMgviCr2gKoeYAjuo
         /fAg6omt91EY15puZWvxOGUqNgm2t5hK7e/C6Ib1fDnvL7DL0E0Jy91EF+0ouz83m/yy
         uaCMIDUZN/GzT206162EOZFvtbPBK6xnEnV8+lRsmP7HPfSWQF0MY1Av8Qa0J64ZetZa
         w+Cg==
X-Received: by 10.50.57.116 with SMTP id h20mr1598419igq.49.1366976145119;
 Fri, 26 Apr 2013 04:35:45 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 04:35:04 -0700 (PDT)
In-Reply-To: <CALkWK0kSWHS0JJ9E4PPihRru0-H13mNffJ5Hndg+LqvFzsYG8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222527>

Ramkumar Ramachandra wrote:
> Think of it as a time-truncated version of git log pu: it has
> nothing to do with reachability.

Er, scratch that out.  I don't like talking in vague terms, and this
feature has nothing to do with git log --since (which is what
time-truncated is).
