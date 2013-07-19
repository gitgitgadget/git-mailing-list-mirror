From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Cygwin has trustable filemode
Date: Fri, 19 Jul 2013 16:09:56 -0700
Message-ID: <20130719230956.GB14690@google.com>
References: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com>
 <1374245631-15955-1-git-send-email-mlevedahl@gmail.com>
 <7vtxjqwlj2.fsf@alter.siamese.dyndns.org>
 <51E982D0.5040505@gmail.com>
 <7vtxjquzqm.fsf@alter.siamese.dyndns.org>
 <51E9C69F.7080309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 01:10:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0JoN-0005F0-DQ
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 01:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab3GSXKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 19:10:00 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51034 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab3GSXKA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 19:10:00 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so4926316pad.5
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 16:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=O4CIYjzxoURWvbOXfky/hqPjLLzJGzOwzAq/lhqJ9Ww=;
        b=mGOqRElKk5EHs/0ssspBsL5D98LLxMI3KpZLZYyqzC1+FzH/PiO7sWP30Cc9a5W/x/
         poPEEd0n1jv0xraTNb7/MHDBH8rjfxzJELdCvS/sZjzG5tC0PSfy52hWC9LDO93AOc+5
         1Tgy81nWaavm1x9rQZXi/HITNN6RvHjE7DrKlKimma0tZ2owJkEV1wGdvXxE7CztE3k1
         9oKRalHd2sOR0jbe+/Vmh1cEindbJyiPqhnLaVRUlAzVJV1OCfyo+zsKmz/lGYtKqTLj
         so4yGPtWAgMsaGh+DJJJulqaCtwM1Cn9czlGtfEJ3Nd2DnyTNK3w9WbKb8gWNjbTYkXy
         BlIg==
X-Received: by 10.68.209.196 with SMTP id mo4mr19508706pbc.114.1374275399489;
        Fri, 19 Jul 2013 16:09:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id jb2sm21758266pbc.8.2013.07.19.16.09.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 16:09:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51E9C69F.7080309@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230863>

Mark Levedahl wrote:

> After merging the following into current pu, all tests that run by
> default pass on Cygwin 1.7, i.e.
>     prove -j 8 t[0-9]*.sh
> reports "All tests successful."
> I've *never* had this happen on Cygwin before.

Nice.  Thanks for your hard work.
