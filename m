From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for
 translation
Date: Thu, 7 Jun 2012 07:41:55 -0500
Message-ID: <20120607124155.GB12987@burratino>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
 <7vr4u23f0i.fsf@alter.siamese.dyndns.org>
 <20120529203759.GC22151@burratino>
 <CACsJy8AGKQHKx9XU+baUagcmi6Sc-=faNshpED=Q46JpV_31WA@mail.gmail.com>
 <20120602124440.GA28996@burratino>
 <CACsJy8A+FTjD3dzBWtL7X35YE9E3t0Gcx-DA6T_+Nt=X3Wp1jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 14:42:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scc2P-0002DL-3j
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 14:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab2FGMmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 08:42:00 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34865 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024Ab2FGMl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 08:41:59 -0400
Received: by yhmm54 with SMTP id m54so334178yhm.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 05:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HfiNVI+DRjZQ9C+RXR7fBI33iDiBfLR867XZ+9hHpII=;
        b=PZ4VGN7GGjWXRvKDY0mt1dor36qD45v1aIFVOsSjhzkTBJ0QXA5WJzZNyhs/45Vk8W
         bOjPHpu4MoQ3nQecb3xEKjuJ+MBUjhGqeTJKBoQCdpbEBrxeD2mfqgw7+uYElu3iv2iM
         1LE7Z4/C6H7ZJJyRRWbnNynn9Py7Qi9GzkF7Nkum/3lXx/Ez2zIVBZM7ucXeOPVtRyxE
         rq+181hIKwWYI9nFsIxwmP0OrvRR3VEI4/R1f6t2qf2bDMKnZF5PIPixMJdqJwbnGCbA
         +VpTOFkV72v+ytF2ZHcbgTCuoUnEfv7D7rrRh93KD3LWQKYy9pviXO8NPkjvvFfk+sMx
         k+6A==
Received: by 10.50.213.1 with SMTP id no1mr481996igc.71.1339072918977;
        Thu, 07 Jun 2012 05:41:58 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id ut5sm619281igc.13.2012.06.07.05.41.57
        (version=SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 05:41:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8A+FTjD3dzBWtL7X35YE9E3t0Gcx-DA6T_+Nt=X3Wp1jQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199402>

Nguyen Thai Ngoc Duy wrote:

> No changes to the series then. Junio, pu material perhaps? The
> breaking gettext poison thing is different and I plan to kill gettext
> poison soon (whether i succeed is another question of course).

If you mean to kill it by replacing it with a facility to run tests in
another locale, wouldn't all these testsuite bugs still be testsuite
bugs?

But I don't think that should delay your series.

Thanks,
Jonathan
