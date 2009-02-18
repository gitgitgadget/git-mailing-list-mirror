From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 01/10] config: Codestyle cleanups.
Date: Wed, 18 Feb 2009 11:18:33 +0200
Message-ID: <94a0d4530902180118j4746a690q7a42ea087e23488@mail.gmail.com>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
	 <bd6139dc0902170833r7e6672f4p831dacb2ed841b32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 10:20:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZib7-0001NU-Ce
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 10:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbZBRJSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 04:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbZBRJSh
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 04:18:37 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:55254 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbZBRJSg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 04:18:36 -0500
Received: by fg-out-1718.google.com with SMTP id 16so715291fgg.17
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 01:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PZE/iajCrGN6YUZjsG5G7ac9kzOz9Ot5cx+x3tJFrJ4=;
        b=gqHtVAhu4pZCR3hnJNhqVxTF4pvAF0UuV/7dG8SEpvwJWdGfPziK6s9EIg1LcIsRW7
         9++h7+IJRsKKNBKLr4opelH1AnLqhI6DbrY57jfuwRuvuLtQ5p+omPhnlfmKu2lo5LK0
         dgY686yNK9ij/oUyGa4k8qQ72oZf420KrzCCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=okQYh/gUNkszytpI+E0SLQbsfnXHDbHRlU2BFhgyo8ZCeq4PAxSWY0V92Yc8s1X9hD
         cOa9KPJ/WgGkeWNOZfFLe+g8V4mteKhXLuSIh9PoaFEwcUcBmYh/jqWkC2Sbyp6UZHlR
         w/hHaxaK2YY5KtE0yAmWSJeyQKwJEKk3unj/M=
Received: by 10.86.70.3 with SMTP id s3mr2624411fga.25.1234948713758; Wed, 18 
	Feb 2009 01:18:33 -0800 (PST)
In-Reply-To: <bd6139dc0902170833r7e6672f4p831dacb2ed841b32@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110517>

On Tue, Feb 17, 2009 at 6:33 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Tue, Feb 17, 2009 at 14:52, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> Did I miss 0/10 somehow? If not, it would be nice to have one if you
> send a long patch series :). That way I can ignore v3 of the series if
> the cover letter tells me nothing significant (to me) has changed. 1
> minutes to write for you, saves 5 minutes for all reviewers :).

Hmm, right. I was thinking on Junio and Johanness that already know
the context, so they don't need an introduction, but I forgot about
other people that might be interested in giving this a review.

In any case, this patch series is a try to re-organize the code of
'git config' and the main change is to use parseopt for better
maintainability and option parsing. A few functionality changes are
provided, like the fact that now the arguments don't need to be in a
specific order: (--global -l vs -l --global), and improvements in
error reporting. Otherwise it should work exactly the same as before
(except with a much better --help).

Cheers.

-- 
Felipe Contreras
