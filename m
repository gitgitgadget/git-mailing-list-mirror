From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 20:21:43 -0700
Message-ID: <20130609032143.GA18678@google.com>
References: <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
 <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
 <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
 <20130608164902.GA3109@elie.Belkin>
 <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
 <20130608173447.GA4381@elie.Belkin>
 <CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
 <20130609014049.GA10375@google.com>
 <CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 05:22:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlWCn-0007Gf-IV
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 05:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab3FIDVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 23:21:55 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55078 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab3FIDVy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 23:21:54 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so1057939pbb.19
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 20:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eQTHrpuuo39r6ix0KmzhiAzAMvMAbjN3fflTlDHsmFw=;
        b=GdfWGdj3fhGWCsr+V25R2CFRkcOaKQn0/2pDF2F/k7X/ex1kZfMJPApiHhU9azNxAb
         utH4xqFVyxbpEvamxRpuGbKJUKSItBoWpuJXH4NMBTZsyESo6glvDcPGx3NCEE/d+XXL
         oy40ta6qlX3i096Br+PMqB6qRkowaOXrJAOfiAO1yB0aPSAmL884tfu4qBCt0spHJSBa
         ggLQXa6wWYsf5O5bMv6/iHTMmvABklKtDqcx+9JQcrkzV6OxOY/vcS4L2mGwGC3LD3CJ
         dbXb4/QPHS/L6ReEk4B+1odP6NS8qIXQ12cgUkm0OzFAEBkAuvt7OZ0xBcDXSXNBESx3
         qEJA==
X-Received: by 10.66.8.69 with SMTP id p5mr8866852paa.57.1370748113943;
        Sat, 08 Jun 2013 20:21:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id cq1sm5011853pbc.13.2013.06.08.20.21.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 20:21:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226877>

Felipe Contreras wrote:

> A collegial work environment is overrated, and proof of that the Linux
> kernel, where honest and straight talk is the bread and butter of the
> mailing list.

An aside, since it doesn't bear too much on the topic at hand:

For what it's worth, in my experience the people working on the kernel
are quite sensible and friendly on-list.  Probably you are referring
to some high-profile cases of flames, which perhaps I have just been
lucky to avoid.  I do not think the way the list works normally is a
counterexample to common decency being useful.

So no, I don't find "But they are mean, and look how well they are
doing!" to be a compelling argument here.

Jonathan
