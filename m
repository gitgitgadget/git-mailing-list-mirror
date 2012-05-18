From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/65] Mark parseopt strings for translation
Date: Fri, 18 May 2012 11:25:15 +0700
Message-ID: <CACsJy8DBBxt3Q7bvrC5P-28MXk8KwAno4uDwTQyiRkfictZqdw@mail.gmail.com>
References: <1336314232-21002-1-git-send-email-pclouds@gmail.com> <7vlil2v7lx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 18 06:26:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVElG-0007E0-DD
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 06:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871Ab2EREZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 00:25:49 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57547 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab2EREZs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 00:25:48 -0400
Received: by wgbdr13 with SMTP id dr13so2383375wgb.1
        for <git@vger.kernel.org>; Thu, 17 May 2012 21:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A/dkAjQURFCdHoGRYy9AYEhJaLwqkQEL8nuVSBXTfCM=;
        b=WPAdfyUVmFz8ZBt8b1gdZKEo01F/cqPOCoNZ5Ah84VYm1Z8/bSL/f8qeBm0eQXMAKc
         qdW7z5/EhjoRv5T4iIUFyoQMxfVfrCApBIt7XlUals1qPgidDhFCL8jow2iPG+l3Efzu
         Ce6tzDTEpwSq5bgh0xOCy+dBboF7uHskiBMpGKP4LRGNYQTqqiOlcffgq5XpRkftLKTa
         tndKx1uIH6cVjbwv/Fh1xdU4wmc+YBOyB9xCYUcaRaPYqHk/P6/q0qoLqQ3UaQBOz22u
         NzG00oYu2AUzPFZQHWmuBflPqgzrO/2N4lXGTJ2Cq+6sdFRHlUs91BP87cxAjOSJ2YYX
         FdYw==
Received: by 10.180.107.101 with SMTP id hb5mr24510912wib.7.1337315147206;
 Thu, 17 May 2012 21:25:47 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Thu, 17 May 2012 21:25:15 -0700 (PDT)
In-Reply-To: <7vlil2v7lx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197936>

On Wed, May 9, 2012 at 1:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Both 01/65 (the parse-options implementation) and 02/65 (sample conversion
> of apply.c) made sense, so I'll queue them first.

parseopt-i18n branch [1] has been rebased on master now that the first
two patches are merged. I find "git log --patch --color-words=." much
easier to review this series (because it just highlights the added
parts "N_(" and ")") than line-by-line diff format for email review.

[1] https://github.com/pclouds/git/commits/parseopt-i18n
-- 
Duy
