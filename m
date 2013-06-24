From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Tue, 25 Jun 2013 01:00:23 +0530
Message-ID: <CALkWK0ngNrxT1MrdhXyz8ViN9an1XQsRD=DnxXYXqhDRmGO8EA@mail.gmail.com>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
 <1372077912-18625-2-git-send-email-artagnon@gmail.com> <vpqhagnwraj.fsf@anie.imag.fr>
 <CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
 <vpqhagnv9xq.fsf@anie.imag.fr> <7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
 <vpq7ghjtpv1.fsf@anie.imag.fr> <7vk3lj9xwn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 21:31:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrCTm-0004Li-7C
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 21:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824Ab3FXTbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 15:31:05 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:44123 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab3FXTbD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 15:31:03 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so25743549iea.17
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 12:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Y0ILZ9nAG6QpdBmz1tgNSo+ZiUbDqnQ0Quiz09NrNXU=;
        b=GRK4h7DH6HJlV4EU4o/xjq2FMklFsmiLnLKxcl6sYEItCdjVKo808qmfHPLm0C+dDE
         wft2Wjbn+fTx5j19kiW7aJ9fIBzYy5hZj0PYCyE9Sfu/fUbFMd+FW2Tb0C4MuzpiiZw7
         w+2cL6/WES6x4KzARejYNpoTpTnJfgKpGQ4PJRct9X3K6JkYz+HVJ/tu72cNVN/eOY35
         8A9mqZvxsv6kP6TOhx4JPCGR4ZkMltyE3foRk3Yylm3Ko+LcM4guO4DcoPOFnfNuqeaB
         olN9iVxopkbLbRQGgeIes9hT+iStLNclpPbIlBsJVNxgL01797NBRGetsReic0KKdesq
         qciQ==
X-Received: by 10.50.225.66 with SMTP id ri2mr6446814igc.55.1372102263352;
 Mon, 24 Jun 2013 12:31:03 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 12:30:23 -0700 (PDT)
In-Reply-To: <7vk3lj9xwn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228906>

Junio C Hamano wrote:
> If we want to continue that tried-and-proven approach as a
> short-term fix, a patch may look like this.

I don't like this special-casing for show_branch at all.  What is the
problem with skipping branch configuration altogether and going
straight to diff-ui configuration, like I suggested earlier?
