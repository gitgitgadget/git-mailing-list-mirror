From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/6] push: honor branch.*.push
Date: Mon, 24 Jun 2013 23:53:45 +0530
Message-ID: <CALkWK0=FmOn1dcCvVpN5nh6ysMTt=swSquU1yi_mzq9QhUnXrQ@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
 <1372048388-16742-7-git-send-email-gitster@pobox.com> <CALkWK0=aDkCMB3ROSuH1crTmQKjCFyCmvJfvOTiQnBo4+NckBA@mail.gmail.com>
 <7vhagndis4.fsf@alter.siamese.dyndns.org> <CALkWK0kqyV+MTW8jDDBt-qEB1R7yvD+n4nTxwvW0QjA13J2=2A@mail.gmail.com>
 <7vy59zbjns.fsf@alter.siamese.dyndns.org> <CALkWK0=a40hACGYApN7odrTytDmoRG_00_Q=EuaHuQ_=h8LBkg@mail.gmail.com>
 <7vbo6vbgbs.fsf@alter.siamese.dyndns.org> <CALkWK0nv7On34g-zE5uHAH69TT-KcEt8z-LxhveNp1b4b+NHsg@mail.gmail.com>
 <7vfvw79xsq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 20:24:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrBRG-0008CI-2T
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 20:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab3FXSY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 14:24:26 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:56578 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab3FXSYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 14:24:25 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so26226570iet.9
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cwJ77KkVWQENvL1k9tIGd8kBLkf3J8ht98JTXcxBFUI=;
        b=CFoKbeU1DueKXmF0lBCSFCFgbxQ+8ijzf43/y3huYgJ5XZfaYWak+vWcQJawsZddJv
         RY9PIsnLeWffET5IDTM8gGXJJmA8iqrauBnaL65SnfAmD4ARxuxMDj5dZmvvNP+m/tVH
         9CT0cSviU03KFRSsw9fGgS6zOtwyKO/hKTO111/3lPcEhBb2Und5MRZzB4KSnnio7NRa
         JAF5Z0+PuIKXyosLVpoJC4rY3QCNGiKpy0rkY4mg3EbSAU2PW8rkZGv9aa+HIHL6ogU6
         wkM9aOdw5MYxeWUraano5o5koXdmzpllGCAmNVZGsxVT6IP0OkR4RD9pMyESgGmTJ8u1
         HO4w==
X-Received: by 10.50.47.105 with SMTP id c9mr6279268ign.50.1372098265399; Mon,
 24 Jun 2013 11:24:25 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 11:23:45 -0700 (PDT)
In-Reply-To: <7vfvw79xsq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228890>

Junio C Hamano wrote:
> With remote.pushdefault, I think the ship has long sailed.

What's wrong with the "early feedback" approach I suggested?
