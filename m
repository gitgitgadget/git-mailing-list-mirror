From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] attr: more matching optimizations from .gitignore
Date: Fri, 12 Oct 2012 17:13:26 +0700
Message-ID: <CACsJy8DkF2XgwPbW=FVTi46hnhk5UmpeHy6ETotomo3e+-Huww@mail.gmail.com>
References: <7vd30si665.fsf@alter.siamese.dyndns.org> <1349864466-28289-1-git-send-email-pclouds@gmail.com>
 <7vpq4qaycn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 12:14:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMcFs-00080h-4z
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 12:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757975Ab2JLKN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 06:13:57 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:40791 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab2JLKN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 06:13:56 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so1921889iag.19
        for <git@vger.kernel.org>; Fri, 12 Oct 2012 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AZfS2kPvH742NKs/ZRNsr0o7mofUUvKmswJZsHB1xII=;
        b=xuQzUwmRuN68BNM2dmqH8ihaOyfV7A9sOD9MlcTfXBMUZ5M3c69za3bHSn7u5isbet
         k/nUOGjjcifko9ryyF3IuMHVfD8oX+CGa7S6iOJ0AGUDbD1eFHlVwU9W34YTlA3hf8jo
         WKsMmYohkyHG4tW9F5pYTvrvQEV78uVa5+FgVglEBlxSmyIDDiJGjzxeZSJbAip+vKOc
         qTqT95ZAoR2/u3evA03HVvPk2AaF95LLDVzotQr5CMJXQTXcAavV6VGNhFghAS/1dKm2
         PgHJmAdR6FroPDJKHPnJ7+J9SCAcNQv1fq/pmPEO5v7ziJjLi7Bd3rZ6yJdHxl9wv2mt
         3Z5Q==
Received: by 10.50.15.193 with SMTP id z1mr1707616igc.47.1350036836242; Fri,
 12 Oct 2012 03:13:56 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Fri, 12 Oct 2012 03:13:26 -0700 (PDT)
In-Reply-To: <7vpq4qaycn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207541>

On Thu, Oct 11, 2012 at 3:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> It would save time from both of us if you can check what is queued
> on 'pu'.  I do not think I touched the code for off-by-one bugs
> there, though.

'pu' looks good.
-- 
Duy
