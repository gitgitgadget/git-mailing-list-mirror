From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 13:00:02 -0800
Message-ID: <20130131210002.GK27340@google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org>
 <20130131190747.GE27340@google.com>
 <7vip6dgmx2.fsf@alter.siamese.dyndns.org>
 <20130131200434.GI27340@google.com>
 <7v622dgl2o.fsf@alter.siamese.dyndns.org>
 <7vobg5f55t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 22:00:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U11FH-0002kV-Bz
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 22:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab3AaVAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 16:00:10 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:64173 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab3AaVAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 16:00:07 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so1791851pbc.3
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 13:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VrIjQZn+MzXEfd7lqO7q+VmG8ntI9bZHed5d3j6J6HY=;
        b=LgnwS4FLqFSW0RebG1cVpeJVGwY+oQhAo0MnV7CCaNjgQpyEPJB26IPldpEVZ6SjNi
         i6kjWZZ7go4vi6qgNIZ5WY9WmySHhk/fg1mI0Wgiec85wJ2l6/TGaGZWu317hYadMXKI
         Z2HuMV9fUPKcktS/+civdsoNzTWB9g228Z1+p7A3rLM8TKYv+X+CwFk6SWWO0uRpwpne
         JipEMm+ga2vUKCJ6glHm3LsE22mxknYjhVVa++okKKt35K5AVjkwB2BsZxZIwu5VmN6c
         g5coApKbFpYOrjQskIemPrJPYsO0pw1XQRe0QTCkNrMsQ5lyyunKqgms0SEj9Wsj2V7c
         /sIg==
X-Received: by 10.66.73.105 with SMTP id k9mr23944829pav.37.1359666007334;
        Thu, 31 Jan 2013 13:00:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id d8sm6612327pax.23.2013.01.31.13.00.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 13:00:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vobg5f55t.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215171>

Junio C Hamano wrote:

> How about doing it this way?
[...]
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1795,7 +1795,8 @@ push.default::
>    +
>    This is currently the default, but Git 2.0 will change the default
>    to `simple`.
> -* `upstream` - push the current branch to its upstream branch.
> +* `upstream` - push the current branch to its upstream branch
> +  (`tracking` is a deprecated synonym for this).

I have already explained that I believe this is a bad idea and why and
proposed an alternative.  I take it that either we are
miscommunicating or we fundamentally disagree about the role of
documentation. :(
