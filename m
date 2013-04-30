From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 23:10:46 +0530
Message-ID: <CALkWK0=GbhALxX0G-ka5oAbixoJv4uKPHAx5LPezgTyGxW_3MQ@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com> <7vppxcdjd1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:41:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEYX-0003P6-Pc
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760730Ab3D3Rl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:41:29 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:48390 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760692Ab3D3Rl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:41:28 -0400
Received: by mail-ie0-f172.google.com with SMTP id c12so980362ieb.31
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 10:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=KQpevSSyAYaacL2p45Kbju/oh96M1qqW2/7/0zKDRqo=;
        b=Mr/KPOSsxR20a6g1Oymnm6QmM6VV9njAZT0HxBMPUqU7e2//vJW0pGbYhYhewTUsNi
         FFOM/4EaZUH+1bESmvhT3pcxL8VA4k9M5a1VPjzgYgTOIqMAPakNuQVcVxIxkKaZmhF8
         dnJym/LtCmWoJEEpsIDHYWQFWrN5sBx3jb967SEl4xaNjRDUcJCsD3hj0Nyy5l4w8eH1
         Vfa0eKmRL1TGWaPcwzB2D9t8qBWM/uQraoKhsDujIOf/UEu3uO4AtiI4JVIex8Sj8S1j
         3kIc0RWHaEOAnaISlTJs8Ly62Ur3XXO47p3/ufZaylL4T4t83qV2Yafx1MQBOuegSPA+
         Fc7A==
X-Received: by 10.50.66.197 with SMTP id h5mr10623267igt.63.1367343688202;
 Tue, 30 Apr 2013 10:41:28 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 10:40:46 -0700 (PDT)
In-Reply-To: <7vppxcdjd1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222966>

Junio C Hamano wrote:
> If you accept only "@" but not "master@", that behaviour needs a
> wrong world model to understand and justify (one of which is "@ is a
> synonym for HEAD").  If your rule is "In $anything@{$n}, you can
> drop {$n} when $n==0", then HEAD@{0} becomes HEAD@ and master@{0}
> becomes master@, and @{0} becomes @ naturally.

Besides, you're going in the wrong direction this time.  You are
trying to fit an explanation to something that is useless.  How is
master@ useful?
