From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 22:37:52 +0530
Message-ID: <CALkWK0mK9uW-Z7YfUY_Ms1WO9vkEKRV31H5dqAOFgb_7SrDG+w@mail.gmail.com>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
 <87zjwguq8t.fsf@linux-k42r.v.cablecom.net> <20130430150430.GA13398@lanh> <7vehdsf19m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:09:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXE2p-000413-6m
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933524Ab3D3RIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:08:41 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:56898 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761275Ab3D3RIe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:08:34 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so919481ief.35
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=dzpFXvDuB99U7IZ3i//WxgOId+XzoQ5aCTRPkYPRXKI=;
        b=AL9etsz4LgN4P7nxUOF9WEAh+Yuha+/cYHNeg/Zg7eb9WqXqciFl3lCvuhDRNVwaXI
         aUlcuBaZMtyHwhpHia0bqU9HVBiun8IOhzGdHtAhqSg6TrdLzZh1dxc1Sg3+WTrfcVRx
         52ob5U+NICCJS01OMDjK7iCJ8mM2lN02RI8i0hP7czsXjOBD2V+wJ3SNPryLqT4aR8L1
         FISpwqawE4iH+fJNaGBr70E8xovMiCPz78Jj5jTrtCIW5iLwhTUi6CYSkSJ8PNNAeJ4Q
         dJ0Ggf2uJ6Ql3MGZ7Pj7RtyNVjNiB34GtGdd+exhjRzIKB5zDKXPe9WvHJ8/m30UPpGj
         rofg==
X-Received: by 10.50.73.65 with SMTP id j1mr4555598igv.49.1367341713364; Tue,
 30 Apr 2013 10:08:33 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 10:07:52 -0700 (PDT)
In-Reply-To: <7vehdsf19m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222951>

Junio C Hamano wrote:
> We need to see if we can make the explanation we will give
> to end users is understandable.

I'll make an attempt.

@ can be used in two contexts:
1. When used without the {}, it means HEAD.
2. When used with a {}, it means what those three forms individually
mean.  @{} already implies HEAD: don't put an extra @.

I think it's the cleanest.
