From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for translation
Date: Wed, 30 May 2012 19:50:34 +0700
Message-ID: <CACsJy8A7cT7F2kb8TuHtazYYL4iJ9W_QgfJ0+A2Tk7-ONRdK=Q@mail.gmail.com>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com> <20120528224729.GK14606@burratino>
 <CACsJy8ANyMxLNCP1P28AKywssGdSQP3QnE_HZHHGzkX-4oqFtw@mail.gmail.com>
 <20120529121428.GD14697@burratino> <7vmx4q4ycj.fsf@alter.siamese.dyndns.org>
 <CACsJy8BvZSbsXyh3ct-M3rcWQf9Fw4VDX2VYVy+0Hv+53AQWnw@mail.gmail.com>
 <20120530062424.GA19114@burratino> <20120530122533.GA28235@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 14:51:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZiMq-0004QJ-AG
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 14:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab2E3MvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 08:51:07 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56427 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571Ab2E3MvG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 08:51:06 -0400
Received: by wibhn6 with SMTP id hn6so3833200wib.1
        for <git@vger.kernel.org>; Wed, 30 May 2012 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WKdC04DMV4EMr3++7yAjJ+DJ1q2rvkocqshx20lMnbw=;
        b=J+RDKxVFNTwzk0EWk5RZB+IYjtH5Bxu4uz3C1jwx2GWy3aI9Puc0Kpg//jvWktiQBm
         NK2ppYdF/cnH1oOEmLfZFy7KukKuwp6LvGlIAT/IyCyQ9X5as2UEEuYjKCG4fTgrVLT0
         NLm3EPEz5KL/R5HYT43MjoNxSMB/T8T0I7CrRPlaBQfzv2H9LRtGx0vV0BsEe4zna0NY
         kSeksXXavBJ/w/1YDWXS6KZoDoqOINM7tjPLjahhVUnINf8cjSciTuHwKvqDqWUhbPGr
         FlkACkjFhZPvQ5veM4T4iy4fyoLNmatQoFfzECdMvpPNfJ89VPd+VvlG8rbIRrMDume8
         27PQ==
Received: by 10.216.194.196 with SMTP id m46mr1244036wen.197.1338382265161;
 Wed, 30 May 2012 05:51:05 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Wed, 30 May 2012 05:50:34 -0700 (PDT)
In-Reply-To: <20120530122533.GA28235@do>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198808>

On Wed, May 30, 2012 at 7:25 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> We also need to improve the shredder to recognize shell variables,

Oh another idea for the shredder, we could replace the first and last
letters of a string with something different than the rest, maybe
brackets. That way we see clearly how fragmented a string is. Two many
brackets on a line is a good indication of i18n legos.
-- 
Duy
