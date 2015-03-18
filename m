From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git pull & git gc
Date: Wed, 18 Mar 2015 21:41:59 +0700
Message-ID: <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com>
References: <5509836D.2020304@aegee.org> <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org> <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 15:44:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYFD2-000446-VP
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 15:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbbCROob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 10:44:31 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37232 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933327AbbCROma (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 10:42:30 -0400
Received: by igcqo1 with SMTP id qo1so45797761igc.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LBAt7yeyPTaZ3Bgwn0Dqs70iHbJVVP/rw8hUhRdhUy8=;
        b=NeP4BFFnN24OAvnIm4zLsrMDMp2MMBfUVpI5F9mMYSOq14TbbjK56yewjFqMn+pnnD
         gVkNeWqZSZcnYOocJBbTRjEOaWuk7VCR5IvVg2AVButfSVm560wpPxZocZobx6Azyc1d
         4S6nG1BpRrLdT2XM1VJQcvdR0XSobBJBnNGpWzOoje+SQIBn1q9TafmjPSU2tTbUIG1L
         dtw7ZP14fE2iQtIuXI9BSt2dNoN3W60grKcYAdgrwrQkBogZt35SzqbF6Z7IhfAjNUpn
         r33/vaJ6ULBckjpnl5CxMhtsKpCukZlKUEt1nFDVeas+cZMhnOPvTrHH3UUgD50mdqaV
         jvGw==
X-Received: by 10.42.10.209 with SMTP id r17mr31912831icr.61.1426689749263;
 Wed, 18 Mar 2015 07:42:29 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 18 Mar 2015 07:41:59 -0700 (PDT)
In-Reply-To: <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265734>

On Wed, Mar 18, 2015 at 9:33 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> If not, I made some mistake in analyzing this and we'll start again.

I did make one mistake, the first "gc" should have reduced the number
of loose objects to zero. Why didn't it.?  I'll come back to this
tomorrow if nobody finds out first :)
-- 
Duy
