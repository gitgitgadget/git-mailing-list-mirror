From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] The images from picon and gravatar are always used over
 http://, and browsers give mixed contents warning when gitweb is served over
 https://.
Date: Wed, 30 Jan 2013 17:28:53 -0800
Message-ID: <20130131012853.GD15680@google.com>
References: <1359416492-8597-1-git-send-email-admin@andrej-andb.ru>
 <7vtxq0u1v3.fsf@alter.siamese.dyndns.org>
 <CAGyf7-GJkKDWdykq8iv90tU3TUR5ZKUf2bQc9sJokbq-RFYBYg@mail.gmail.com>
 <20130129041206.GA15442@google.com>
 <7va9rrq1o3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org,
	Andrej E Baranov <admin@andrej-andb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 02:29:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0ixt-0002NJ-4h
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 02:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756052Ab3AaB27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 20:28:59 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37418 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab3AaB26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 20:28:58 -0500
Received: by mail-pb0-f46.google.com with SMTP id mc17so1298185pbc.33
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 17:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=F0F6XNBurQZkJMYwRNH8xoIcncVToWFDAj0ghWd62Ac=;
        b=kbcko0cknR52c/JhS/06arHoYbopU76vkF8edJ52aXUwd9HyLVGvLaphBdPgTcih9P
         CM3JCPTA1+q6MboSzmbDAVWaM+juG+epj4eEohGoHJls8Bdz1+u6GT3cMOLJFViT4y6f
         2gTkcONy1MG5Zx0iJvpftjEYb/c5r+w6vYD2v21yXjCoofyZyZgdsR0woZugDrgqEySa
         YmL4s4S+DUnqaQnhokt+2KNHuUwcqMNjqXu4Q/3l12JpfAeKqK5ucU0BwTT71PE6wpF2
         bGe3/fwwMTWdWEA9aStJjhcU4+Gxndr/QVQ2lsx5ThgfvUpIv20OZYBFz+7aEL4pgu5f
         d54g==
X-Received: by 10.66.81.68 with SMTP id y4mr15936909pax.66.1359595737709;
        Wed, 30 Jan 2013 17:28:57 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id qb3sm3194041pbb.35.2013.01.30.17.28.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 17:28:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7va9rrq1o3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215081>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Odd.  "https://www.gravatar.com/" also seems to work.  I've put in a
>> technical support query to find out what the Gravatar admins prefer.
>
> Thanks; will hold onto Andrej's patch until we hear what the story
> is.

Good news: a kind person from Automattic answered that
www.gravatar.com should work fine over SSL, both now and in the
future, and promised to add updating documentation to their todo list.

Thanks for your help and patience.
Jonathan
