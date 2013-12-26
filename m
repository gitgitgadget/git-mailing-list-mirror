From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] cat-file --batch-check='%(deltabase)'
Date: Thu, 26 Dec 2013 12:20:09 -0800
Message-ID: <20131226202009.GU20443@google.com>
References: <20131221142336.GA28649@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 26 21:20:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwHQA-0001mZ-0u
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 21:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab3LZUUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 15:20:15 -0500
Received: from mail-gg0-f180.google.com ([209.85.161.180]:45739 "EHLO
	mail-gg0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab3LZUUO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 15:20:14 -0500
Received: by mail-gg0-f180.google.com with SMTP id k1so1764315gga.39
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 12:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PGBTzlw4UkDtwftz941LMbQgr1PInv4dBjTRpJuhVuU=;
        b=uSr3Ly78RJthb/O+GRRKbggT/XziKLuYywZNfB+kubZSJQE2uoTLrm7Tv6bBjZoNIo
         5dRitWJV3/N7b0yZXacyGvLNwQPyqieqX0U7JAWfKPk3svE6qvgMNa+QEsejPsPje+v/
         KMcSNQQVy6F/JksELs1imwLLBANzJy3icL8b2eldFUeJwjs9db4ymOJrWPTqD+aYRayf
         AUFYHFSyyGbKToUQYemQmYOFf09bdCT+tia8buSM0th4CDDsZBIO6TM/rRy7z9uVEZOT
         VmjNYCg3AiYuxK19QhmsBgJLt4XlMY8frRZGAHJUtJCT7YdkMfyEi/2y7/D9VflSJp85
         NE4Q==
X-Received: by 10.236.143.10 with SMTP id k10mr3172312yhj.116.1388089212756;
        Thu, 26 Dec 2013 12:20:12 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id o27sm43130023yhb.19.2013.12.26.12.20.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 12:20:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131221142336.GA28649@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239711>

Jeff King wrote:

> I needed this recently to write tests for another (not yet published)
> series. But I think it stands on its own as a debugging / introspection
> tool.
>
>   [1/2]: sha1_object_info_extended: provide delta base sha1s
>   [2/2]: cat-file: provide %(deltabase) batch format

Neat.

The error handling looks right.
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
