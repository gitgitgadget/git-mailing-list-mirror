From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Tue, 22 Apr 2014 01:56:33 -0500
Message-ID: <535612a197c81_268bd0b3089a@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <53558AD0.3010602@gmail.com>
 <53558a663ea74_604be1f30c2c@nysa.notmuch>
 <53558F6F.7080306@gmail.com>
 <53558f285f379_640076f2f094@nysa.notmuch>
 <CADcHDF+XcWEkvyP3tL4ibicnaMVJpixUZu1Ces0BXWkzPGsodw@mail.gmail.com>
 <53559a8333aaa_6c39e772f07f@nysa.notmuch>
 <535606A3.8040704@gmail.com>
 <5356100296994_268bd0b30839@nysa.notmuch>
 <5356138D.9040409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 09:07:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcUne-0002yo-Qb
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 09:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbaDVHHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 03:07:14 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40171 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbaDVHG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 03:06:56 -0400
Received: by mail-ob0-f174.google.com with SMTP id gq1so5290303obb.19
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=FtkFZBCtqmH/IZ5ZS51xnfTrQ/WEDLxvicG05zn3Flk=;
        b=AtPEkd/8Jqh0YUlO8d1dyZTT085LKqx0pG6djVf9vegeXqciiI305BxUsFLqz/8ds1
         hCtkhQguhxMTZ7I9YlhsK/Lc8DXAa44ZQk00N+FbxppuBb8+CxMcwvhQ/y/DU7ziYctY
         QmkQQClxeOkuI4N9kKQ/VLXhdpjoAKZpOucaAsscI0JjTpyDs0u7zSak2gr/RzN5SgB3
         ZNqKKy2AsY6zr1O5wkVORXXRc7zJXsMFLlnNTtYRVD8auwZqDWGu2WPHCss203a5wpGu
         WqelzktWW9/ICP9o6ux4uIT7nDvXBwgrdfKLGsrx8ZDk8+P1aHr0uHXT16c3RajW9RY8
         UBRA==
X-Received: by 10.60.125.195 with SMTP id ms3mr35834319oeb.3.1398150416182;
        Tue, 22 Apr 2014 00:06:56 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id oz15sm174405664oeb.13.2014.04.22.00.06.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 00:06:55 -0700 (PDT)
In-Reply-To: <5356138D.9040409@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246706>

Ilya Bobyr wrote:
> On 4/21/2014 11:45 PM, Felipe Contreras wrote:
> > [...]
> >>>> This is how it is suggested by t/README and how it is done in the other
> >>>> test suites.
> >>>> I can not see how your case is different, but I might be missing something.
> >>> Let's take a cursoy look at `git grep -l "'EOF'" t`.
> >>>
> >>> [...]
> >> So the point is that some existing tests violate best practices?
> > I don't know what you mean by "best practices", but these are Git's best practices.
> 
> I am talking about recommendations in t/README that I quoted.

Those are *guidelines*, best practices are defined as things you actually do,
as in "actually practice".

-- 
Felipe Contreras
