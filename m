From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Tue, 30 Apr 2013 00:47:46 +0530
Message-ID: <CALkWK0=QviF2TbY3hePQJxkmG1QPpG=EyUVqoCbmj7uqFJ29ow@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <7vvc7baahc.fsf@alter.siamese.dyndns.org> <CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
 <CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com>
 <7vppxj6thv.fsf@alter.siamese.dyndns.org> <CALkWK0n9xqQr30QWEuhuM9c1xrAJ=SpYVBjkiRk+tP5E7DtBGw@mail.gmail.com>
 <7vhaipl2ks.fsf@alter.siamese.dyndns.org> <CALkWK0npQwFnFNpEzT5mgh5HvGUKf=Jz7v4Mn62BDBzb+qjY_A@mail.gmail.com>
 <7vmwshi3dv.fsf@alter.siamese.dyndns.org> <CALkWK0nNb1CSR6EHxtnvBd3VXVPNb_JDqk2Kfa5VA1RMG1u0Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 21:19:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWtbH-0003Qo-KW
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 21:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920Ab3D2TS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 15:18:29 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34746 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759458Ab3D2TS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 15:18:27 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so7808097iea.10
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Ef+v2wQtA0KXhBUdZFtXRQcCMmA7Ge6eri4ahAidl+M=;
        b=oMalOPa7QZykKhuBCXtnSOot+2RoVhA8ec/gnQoFD5W8IirqHXN7tm2/QRiEstzSVi
         05l+XM8lR7lrODWFe9CVPR4doHFyzAIyW44vaXT0igC0kjr/P8IDPzacrcAqEXVYjMMh
         VQgo8dUOyxW5nx3DyoVINf4LAjR6UsSg6KnHf+rixiVJDKnByQ+wNvFymAzJZ3pgVpmt
         eblKrgSJ87nG5UoENmQ5gOBF8xDJrwqUQLC4M8eofDyLnCtIDSswPxXErtNtXBkvK+aR
         /QmP+pjLI9Ys61rdzH/c/KMOjT7rlhOW+WYS6I81SzXvR7XOOebpxaBmco+gkS8+1XOM
         1T9Q==
X-Received: by 10.50.3.38 with SMTP id 6mr1669980igz.44.1367263106662; Mon, 29
 Apr 2013 12:18:26 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 12:17:46 -0700 (PDT)
In-Reply-To: <CALkWK0nNb1CSR6EHxtnvBd3VXVPNb_JDqk2Kfa5VA1RMG1u0Ng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222849>

Ramkumar Ramachandra wrote:
> What are your thoughts on overloading it for rebase?  git rebase
> master~ to rebase onto the merge-base of master and HEAD?

I just realized that I meant

    git rebase master..

and not

    git rebase master~

I want to rebase the merge commit, not the merge-base along with it!
