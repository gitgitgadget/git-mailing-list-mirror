From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http: add support for specifying the SSL version
Date: Thu, 13 Aug 2015 07:58:41 -0700
Message-ID: <CAPc5daUZFEDN9OqQVwYFxsyHZYtvw8D-Ost-bopreKZmV0epxw@mail.gmail.com>
References: <1439389491-21669-1-git-send-email-gitter.spiros@gmail.com>
 <xmqqoaicmtac.fsf@gitster.dls.corp.google.com> <CA+EOSBmWqpT6zSZuCyBdW0cL0OLWbq1yvYmwqgTCUVF5T51K-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 16:59:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPtyN-0003cA-Qb
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 16:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbbHMO7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 10:59:05 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36427 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbbHMO7C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 10:59:02 -0400
Received: by iodv127 with SMTP id v127so38838495iod.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=E9GbKAJ/Bq0ZVeEDna4hTwI3tKTcXZDcI0gZ2SaxiNU=;
        b=BmNp1/KDs7zUKGMrt8xtkUXNiJsvQifwuSlNKdUGPGFj8XW2jSJoOwgb5BEczelLhh
         ptdYHoH69XqX7nz135ERa+VWJrAipi1KsjgMdfM6mXXQuDOKB9Vfol7c2t+SZEynwcYv
         ELZGTfp1YfFtDmhHx1zhrJa0kY6B8OnhzJt7KMEdTaTGUbiRoXfqVjCMyABftOKIhfH3
         BmTj2Uysb81D7dkAEuX+PUqrleMKvOCfFLO5P2Jgsxg4K0YjLoVTs3+11vyAGoT1Rr60
         4yhAlXmwhIFeJiuaSYrebxOT6xLIUBFiya6cQeERMfsVCYM6ZQRF0mgLAuNO+ujZXq7x
         1Dgg==
X-Received: by 10.107.148.7 with SMTP id w7mr15884283iod.82.1439477941218;
 Thu, 13 Aug 2015 07:59:01 -0700 (PDT)
Received: by 10.36.41.149 with HTTP; Thu, 13 Aug 2015 07:58:41 -0700 (PDT)
In-Reply-To: <CA+EOSBmWqpT6zSZuCyBdW0cL0OLWbq1yvYmwqgTCUVF5T51K-w@mail.gmail.com>
X-Google-Sender-Auth: qcTeGk99XCU2LvWCyZrjLukN_J0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275846>

On Thu, Aug 13, 2015 at 7:30 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
>>
> unfortunately they are enum constant (not #defined)

Ahh, then checking LIBCURL_VERSION_NUM is unfortunately the
best we could do. Sorry for the noise.

You still can go with the table-driven approach, though.
