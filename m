From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for
 translation
Date: Sat, 2 Jun 2012 07:44:40 -0500
Message-ID: <20120602124440.GA28996@burratino>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
 <7vr4u23f0i.fsf@alter.siamese.dyndns.org>
 <20120529203759.GC22151@burratino>
 <CACsJy8AGKQHKx9XU+baUagcmi6Sc-=faNshpED=Q46JpV_31WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 14:45:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaniL-0003Cp-KK
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 14:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672Ab2FBMpG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jun 2012 08:45:06 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54862 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab2FBMpE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jun 2012 08:45:04 -0400
Received: by obbtb18 with SMTP id tb18so4312142obb.19
        for <git@vger.kernel.org>; Sat, 02 Jun 2012 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aGxG3rzwNGhZdtULH2rWpR0ZDF/vhNUedFJ5B24P6P8=;
        b=rDNpozAmedpE+s5HDoL8kucLajobFj4MvDysiUcNcr5ulSPv5HqfTnQz/+WwU+mOTq
         TpctSOuVZznMHtrPFUBs8ajCHmr99J4lrrbZHc1CFIUbUTNZtYlPC8cVQaeIHAV2ZFDV
         JhCgMwcDvNMk+kFA7ZsiOp5bJoTKzTmPesJI3m+nrvN2ySzpoVXMkRf2aKC9Nq0T3QfU
         tlEwO73OVEC4XvkHl4zT871QN/Sc3ZivJ6o6Vzdn+BRVUnhIp8qaPkKZUE8mAx0czlDs
         dopEoCD2KAo4mPk1IeYLm2Mu3ABS+hQYb7XaY8EKdbSZlBaVrA6Lhg2yvvVyyY41Lo7y
         bEng==
Received: by 10.50.170.106 with SMTP id al10mr2737997igc.60.1338641103138;
        Sat, 02 Jun 2012 05:45:03 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z7sm1441917igb.3.2012.06.02.05.45.00
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Jun 2012 05:45:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8AGKQHKx9XU+baUagcmi6Sc-=faNshpED=Q46JpV_31WA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199044>

Nguyen Thai Ngoc Duy wrote:
> On Wed, May 30, 2012 at 3:37 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> At least "git archive --list" should probably be kept untranslated
>> to lessen the translator workload a bit. =C2=A0Good catch.
>
> Should it?

No, since to do so would break GETTEXT_LOG_UNTRANSLATED and it's not
worth it.  That looks like a great tool, by the way --- thanks for
finding it.
