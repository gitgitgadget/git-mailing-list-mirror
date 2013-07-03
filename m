From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] completion: add completer for rev-parse
Date: Wed, 3 Jul 2013 16:00:04 +0530
Message-ID: <CALkWK0mB8Y9xkO6gDFghuCFZveRqhWdn59XEy4+auDcF5Kmx7A@mail.gmail.com>
References: <1372429088-385-1-git-send-email-artagnon@gmail.com>
 <1372429088-385-4-git-send-email-artagnon@gmail.com> <20130630111436.GB2294@goldbirke>
 <7vtxkfju9p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 12:30:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuKKm-0005f0-Pc
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 12:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859Ab3GCKap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 06:30:45 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56263 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab3GCKao (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 06:30:44 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so14962949iec.33
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 03:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ctUI4y+EjXvB0H3F8g/NuchTpqKGnWfAzUaRRT8xHeM=;
        b=NJY16xKiRJTAvJAb/9KEIW2a3SvkPJWtu09xNXk+7osbmDTizckKxd74WV9Ht9tuEs
         oFyKeZI250xt4D2toEa6hngaobKLZm+Wrn+Bk6nvySEfdMgbsOYslpfpKP1J9CbUaVS7
         Y89jNbC9B/1bLtZdO1/99+W7mgo/flN2LViKWJ10fd2IqMFjhrOAE1Q9hm/Zp2Vabs3A
         Bdxwkzw/gtb+54y1vHM9OiQy5xbE4AEVscXTfng+PlG63eRdy0s+T1fKuBeodQXKWkh6
         RlmVwCcBDSf6V03RS3CWU2Agc1sAy7cXyTCXaH7X4zj1XQq1vVmR3AxFOcsataVmLOtV
         EQRw==
X-Received: by 10.43.88.3 with SMTP id ay3mr110577icc.61.1372847444249; Wed,
 03 Jul 2013 03:30:44 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Wed, 3 Jul 2013 03:30:04 -0700 (PDT)
In-Reply-To: <7vtxkfju9p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229486>

Junio C Hamano wrote:
> For --short and --symbolic-full-name, I have a feeling that we
> should make "describe" a front-end for these.
> [...]

All very good.  If and when someone does write that functionality (I
personally find the task boring), we can remove this completer.  Until
such a time, the completer is useful and should be merged: so, could
you queue this series if there are no objections?
