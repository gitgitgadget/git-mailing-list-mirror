From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/6] dir.c::match_basename(): pay attention to the length
 of string parameters
Date: Fri, 29 Mar 2013 06:40:30 +0700
Message-ID: <CACsJy8BcRp7-6Zf6=6Snd1JO1kPaw8b-q=s1QF7TaYHPubJ-0A@mail.gmail.com>
References: <20130328214358.GA10685@sigill.intra.peff.net> <20130328214728.GB10936@sigill.intra.peff.net>
 <20130328224027.GA9911@sigill.intra.peff.net> <20130328224928.GA20242@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	avila.jn@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 00:41:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULMRp-0004uL-Hk
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 00:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800Ab3C1XlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 19:41:04 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:59972 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab3C1XlD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 19:41:03 -0400
Received: by mail-ob0-f177.google.com with SMTP id eh20so59541obb.36
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 16:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=rL0QVtuMk1mnCVXhNgMSo9lVHgTJB+4G47PqexURAho=;
        b=dMsRBvE/Rlh/oWho+3dKstfrj9Hnnr74JbeuicDzl3O7hv/3sYxRFXkkBkHgdQWepO
         3Lvg0R+fiiWEBdkuDvKiOhfWIc90jsVaxleVf5C47F/gkkFbAFT5NVCTzYmPdUe9SJlh
         z9Jjbrv3IF+Qw7//qRYpB1rvInryJZpXaPYiJJqvrm1ZFXI/8wO9FTCI3pvPloqjTAiZ
         oYmR0ErJWLegzvSgRiVo8ADZ+kLcDFuaZDWFrUN2/Z3eWro5qzzqNO6wsBuT22IdYs7B
         YKA2IuVaeP289FFBkOMDhU1o9yMxApRmDEXZqz9fHEbRoBeo2OjsTd5IC3ZgnaqnAAte
         8I+g==
X-Received: by 10.60.169.231 with SMTP id ah7mr140183oec.142.1364514060865;
 Thu, 28 Mar 2013 16:41:00 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Thu, 28 Mar 2013 16:40:30 -0700 (PDT)
In-Reply-To: <20130328224928.GA20242@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219478>

On Fri, Mar 29, 2013 at 5:49 AM, Jeff King <peff@peff.net> wrote:
> My match_pathspec fix breaks at least t1011.

Haven't looked closely at the series, but I suspect you need this

http://article.gmane.org/gmane.comp.version-control.git/219008
-- 
Duy
