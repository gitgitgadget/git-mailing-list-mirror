From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 12:17:57 -0700
Message-ID: <20130514191757.GP3657@google.com>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
 <7vwqr1jw67.fsf@alter.siamese.dyndns.org>
 <CALkWK0kJ7aksRbtjOesEPvsdx6wZyxxdVHUm_F-jS+Nb3WLSxg@mail.gmail.com>
 <7v8v3hjt57.fsf@alter.siamese.dyndns.org>
 <CALkWK0na1pDi5DnKUcWRnt0v9iQmeaLdrs7uQMDZzCKAazaNFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 21:18:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcKjg-0005g5-Jo
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 21:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab3ENTSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 15:18:04 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:43927 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032Ab3ENTSD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 15:18:03 -0400
Received: by mail-da0-f46.google.com with SMTP id e20so485704dak.5
        for <git@vger.kernel.org>; Tue, 14 May 2013 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9V5aE60iONY3S13iQi/P5dThsftd0Zh6glW36+lwLMY=;
        b=dhNJuUErM58Z90s8Kvti1E4LFpFZd9BlyoLRNVnhF1VGCN6HTG+bWFD7LkDKF/i58Q
         FZ0ECYjvxviPwuX6fBf9jFakd6ktxZY2QKYx2syr9lwQIO4IHlNonWjCVj0Z97GSMgk8
         thY0yWEYEmYXbWxlKxSoIoOttctW2Kicf5vhVYLWSkx4EI4ousZxPtcrInA5488d9VEb
         7muiB77vj5PzpPgUp+lbAqph28BiiivDt78H9cftoXcFytNz/F/MDdPIEUuvcCzznLPN
         38d0+6SY5AbFvzu+nBWR9x1apUlLYQoBfwDbuXK/VEfuWEhIvVGqfaa8Hkja/BKGEzOM
         VOmw==
X-Received: by 10.66.89.65 with SMTP id bm1mr35288519pab.179.1368559082001;
        Tue, 14 May 2013 12:18:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yj2sm15599477pbb.40.2013.05.14.12.17.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 12:18:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0na1pDi5DnKUcWRnt0v9iQmeaLdrs7uQMDZzCKAazaNFg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224318>

Ramkumar Ramachandra wrote:

> What can we do to improve the interface?

Write a better shell?  Teach "git gui blame" to blame on arbitrary
regions instead of single lines?  I'm not sure what you're asking,
mostly because I'm not sure who "we" is.
