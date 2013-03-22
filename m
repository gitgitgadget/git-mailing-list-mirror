From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] remote.c: simplify a bit of code using
 git_config_string()
Date: Fri, 22 Mar 2013 11:26:48 -0700
Message-ID: <20130322182648.GG12223@google.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 19:27:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ6gT-0007gC-8p
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 19:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709Ab3CVS0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 14:26:54 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:58049 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422649Ab3CVS0x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 14:26:53 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so894965dae.9
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZrZEa+SWcz17KoHQUWEgbN1ze3Dt995ipxdtK/BukFw=;
        b=a8MDRT0d4ugVtY8iQrCekk+2ADz9ovqanC5+7Hy4ySQ5MgmmlxdCdGSXXSyxTUd4eR
         PzMc4YK8Uppm8o2nQnVMS+3V/dx7d3CM921ZVTE8xs+UUf+CwqWLWj0vcl9idpIxL815
         7I+85txaeRrXutjtR3SGqhFSS/QKFceYbcuTertjZG+/uqHEBmU0IXimCTGNZaMau6uc
         VDrYHz6ZmvoUDTXPBFWhFD74TgUx5/Bf9C0eTqXuQ/t6dUya2y8Wqxmav6fb9UJw+ng/
         YxzkeC+ibnVxvtJcIfygOLhNnDeH39D/Vf3xsWQUaIikqQN+LdoDQOdJNC/iX04rUoMk
         Q77Q==
X-Received: by 10.66.193.227 with SMTP id hr3mr4806119pac.45.1363976813028;
        Fri, 22 Mar 2013 11:26:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id qb10sm3191508pbb.43.2013.03.22.11.26.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 11:26:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363938756-13722-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218832>

Ramkumar Ramachandra wrote:

> A small segment where handle_config() parses the branch.remote
> configuration variable can be simplified using git_config_string().

Looks correct.
