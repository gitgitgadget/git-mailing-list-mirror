From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/PATCH 10/11] branch.c: use 'ref-filter' APIs
Date: Tue, 28 Jul 2015 00:57:33 -0700
Message-ID: <CA+P7+xpU4KdmutkGDdiAaXFpzs4zq=f2rXhqxqogAPJqopjdRQ@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438067468-6835-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 09:57:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJzlt-0004pC-Is
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 09:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbbG1H5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 03:57:53 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37301 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbbG1H5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 03:57:52 -0400
Received: by igbpg9 with SMTP id pg9so110699865igb.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VMUzeHkEq7uuXo7vtBZ6pPktulXGmWh6Sv7fZjhdVg8=;
        b=eGtv5j4L4VLKvs3g6INyUnzkfzp6mrgbrLhvKgOgRy9UH+CGYf3cXj90XMni3pCX2c
         v1rNvmlUc/279t2PveZgt+RxvzTEU/3SUJv50eAfjNk9OyPWVdR8grO+87lFPYprj45N
         JryvqJH+ZNU74JK1TBq1LFVuxx4gjkwDSFPolWUd3txdaCbp4aiVa5KQb80JWpY+tXV4
         TBaienMFiOqGbJar2uwQzlq7sNk0Did2uN8DTmAJb7CHfbU4z56yhkd7fSsTfOh/wHWw
         2wD5COPrZCROwt6wh5Q7vX1KScSz64kQ/6clFxDmNw+8yDu/0soKbtmnXhVTpqZGscqt
         YOvA==
X-Received: by 10.50.23.98 with SMTP id l2mr4051570igf.25.1438070272335; Tue,
 28 Jul 2015 00:57:52 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 28 Jul 2015 00:57:33 -0700 (PDT)
In-Reply-To: <1438067468-6835-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274754>

On Tue, Jul 28, 2015 at 12:11 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Make 'branch.c' use 'ref-filter' APIs for iterating through refs
> sorting. This removes most of the code used in 'branch.c' replacing it
> with calls to the 'ref-filter' library.
>
> Make 'tag.c' use the 'filter_refs()' function provided by 'ref-filter'
> to filter out tags based on the options set.
>

This patch doesn't do anything to tag.c, so you should update the
commit message to remove this or replace it with s/tag/branch if it
was intended to be about branch.c?

Regards,
Jake
