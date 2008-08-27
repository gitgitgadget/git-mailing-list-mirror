From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: newbie question about git push
Date: Wed, 27 Aug 2008 11:52:28 -0400
Message-ID: <eaa105840808270852s5d5804b4md9a78efd6691f01f@mail.gmail.com>
References: <48B574B0.4030607@boboco.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Bowman" <ebowman@boboco.ie>
X-From: git-owner@vger.kernel.org Wed Aug 27 17:53:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYNKw-00077k-L6
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 17:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047AbYH0Pw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 11:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755087AbYH0Pw3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 11:52:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:57573 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043AbYH0Pw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 11:52:28 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2690322rvb.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=0LdE3sMCacjTVIxoRyCODTEdaoNAwwU3zztZ7vGTSI8=;
        b=KBWIz8KBfPdBdiblr0WwFRmqUOfMnn5/lPmxNMaGppsmOseVJVkj73rae1wXTyFMNZ
         PPK4nEFFFQtPiP8mdYyzxX9lBlbUEl8Y1lcvwh8+yefQslS4I4B8JWVI+w3mI6Myd75+
         K9JdKnb0/PN2z4C9VntPkX5gEEI8g+eot4f74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=ih3S8C8FAJwVcLzO6tz3k/U/gQa7+mb0FKorhBU11uBRolgwDvC2IP3EwRVvFPRsEv
         zZ3BMAnFMWRq/OOHfxSqt1kWgdUSHnFUjLVrxSkCHObtsPWtx0QiYeGbvpD5T00BWmoa
         oxq5iETtZ5J1QCGsj+OCX8kWcHKrojwL7FvpA=
Received: by 10.141.176.4 with SMTP id d4mr84216rvp.14.1219852348109;
        Wed, 27 Aug 2008 08:52:28 -0700 (PDT)
Received: by 10.140.158.1 with HTTP; Wed, 27 Aug 2008 08:52:28 -0700 (PDT)
In-Reply-To: <48B574B0.4030607@boboco.ie>
Content-Disposition: inline
X-Google-Sender-Auth: 54c1faa6f01e719e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93898>

On Wed, Aug 27, 2008 at 11:37 AM, Eric Bowman wrote:
> Where things get a weird is when I push a revision back to itchy from one of
> my other clones.  I feel like I must be missing some fundamental concept,
> and I'm wondering if someone can help.

This is a FAQ.
http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73

> I'm starting to think that I should clone the repo I cloned from svn for
> doing development work on itchy, but this seems kind of wasteful.  Am I
> missing some fundamental concept?

I always clone my svn mirrors for doing development work.

It's not particularly wasteful, especially if you set up the svn
mirror as an alternate for your working repo. ("git clone -s", but
make sure you read "git help clone" so that you know why you can't
delete anything from the svn mirror)

Peter Harris
