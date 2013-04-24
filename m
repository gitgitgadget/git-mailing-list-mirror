From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] git-diff.txt: fix ordering of the [--no-index] form
Date: Wed, 24 Apr 2013 13:50:46 -0700
Message-ID: <20130424205046.GK29963@google.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-6-git-send-email-artagnon@gmail.com>
 <7vmwsndbve.fsf@alter.siamese.dyndns.org>
 <CALkWK0kaFc8cj-=1NbEwC_61U7qUCye70d9MZR66TpKB3i9XyA@mail.gmail.com>
 <20130424190638.GE29963@google.com>
 <CALkWK0n2zFp1t7qtKp8-Ohoz0QEn4BQrfvxzqt+qwLS5+sNdHQ@mail.gmail.com>
 <20130424191453.GG29963@google.com>
 <CALkWK0=KWu3=j5sLK3hr=Gx5xLnLaPAY+E=J0_izRCj9YcBTEg@mail.gmail.com>
 <20130424203732.GJ29963@google.com>
 <CALkWK0=-Bu-x=zg2f-uY7qUkwCp_8AdDAVv6=k0oyV4xYvBuWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 22:51:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV6eg-0002ol-SV
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 22:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758257Ab3DXUux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 16:50:53 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:42615 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758059Ab3DXUuv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 16:50:51 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so1431321pab.10
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 13:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/hNEsVX5ZcUVffthNMuAyQyDDBYVSE6aU1plKAd+XjE=;
        b=J86XWkvRr71/OyjWVKOTCUXmBx3L+dnbBCBkisv5jshErqLpfEmUufEsDD51Y5gvvk
         2slKkV0vAPlnuUawnEGx/0YDP5hebeCp35YfpoTMfTj+QCNJNCPUJzWEjb/XZvEyl7/K
         sjD/8UKIl+/C8QFME9iExFD8bXXAWqvf1h2ndN0/Fbvayc2aQ/ihDMj1M3VnoOcReDPB
         V3krK4ZIi3Th6rwtOAz/0gyY8aP7czG+Hvr6ac+SU1ptUrRfgjDGx4wbLM1dwY7nazk6
         8nSVMDlj4s8evDCIbdsCM0XdjRiNCe318s8vIxq4yh+uNOAp/LMxtVZ8PAWr2LwujN/f
         gmSg==
X-Received: by 10.66.197.136 with SMTP id iu8mr25587271pac.0.1366836650743;
        Wed, 24 Apr 2013 13:50:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dg5sm4309139pbc.29.2013.04.24.13.50.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 13:50:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=-Bu-x=zg2f-uY7qUkwCp_8AdDAVv6=k0oyV4xYvBuWQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222320>

Ramkumar Ramachandra wrote:

> I completely disagree, but we don't have to agree: make it a
> configuration variable.

I thought we had discussed before how every configuration variable
costs quite a lot in terms of Git's teachability.

What would that configuration variable even mean?  "Set this to make
other people's scripts work when they assume --no-index won't be
triggered automatically"?
