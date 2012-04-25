From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/10] i18n: mark relative dates for translation
Date: Wed, 25 Apr 2012 12:26:05 -0500
Message-ID: <20120425172605.GA2578@burratino>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
 <1335184230-8870-4-git-send-email-pclouds@gmail.com>
 <xmqqd36wgam5.fsf@junio.mtv.corp.google.com>
 <CACsJy8Ae_9wEoNmP81Gqu5kOMGrEKSN9PMvoRXbKh8TnwGVt0A@mail.gmail.com>
 <20120425152558.GC31026@burratino>
 <xmqqzk9zdbf7.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 19:26:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN5z8-0006jy-54
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 19:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487Ab2DYR02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 13:26:28 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33357 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab2DYR01 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 13:26:27 -0400
Received: by obbta14 with SMTP id ta14so345080obb.19
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WPfEJREdYxiUS/RjXhiCioOcmU0h20AaO5xdnl3I2/o=;
        b=sx0/LDRTWJRRbLHnUvshZH1/LwBffjLxCTajA74lNIsxI2fdm7LeF5GW3ugmxSjSLF
         UFyvgAm284LuMmaXX0/bhOzetswmWdZ8z9f6woVMITlYaZSM1kXMYqU6xDMzMW4ECEIM
         R2/EXT3ozHKaDiPvavMBoeUXt5iaSJtFiRmH0yLSfibsP1ZOgeci+fbUhQprZvDgIirg
         FwKED0MvvmtCk6PstfD6gknk1G05udBrGIjEW1h0+N9d9Lm4vC3Dx6dahXNmb7Xki4y4
         HovCX+ebfTpJF457VR8iwkDhs+J+UUEqianwvdItBpLi3KMxz1FCM8yLd7uBElAqDdZY
         8RIg==
Received: by 10.182.113.106 with SMTP id ix10mr4376712obb.26.1335374786585;
        Wed, 25 Apr 2012 10:26:26 -0700 (PDT)
Received: from burratino ([64.107.3.126])
        by mx.google.com with ESMTPS id w4sm321652oeg.12.2012.04.25.10.26.14
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Apr 2012 10:26:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqzk9zdbf7.fsf@junio.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196323>

Junio C Hamano wrote:

>                               what I meant was that diff will be so
> large that this will always be feeding more than 1 to %lu, so the first
> template string will never be used.
>
> But it cannot be N_("%lu years ago", number), as others correctly
> pointed out.  We want to use ngettext() here, because it is not enough
> to know that number is always greater than 1 to correctly phrase this in
> some languages.

Ah, I see now.  Thanks for a patient explanation.
