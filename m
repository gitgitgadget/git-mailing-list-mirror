From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: [PATCH v2 try2 00/14] Officially start moving to the term
 'staging area'
Date: Fri, 25 Apr 2014 18:33:11 -0700
Message-ID: <CAE1pOi23ygoCJcGWYzYqa-JTOP5kSn9Bj1QByzUKrHTcvJ0fhg@mail.gmail.com>
References: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 03:33:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdrUn-0005ZD-Ec
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 03:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbaDZBdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 21:33:33 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:41150 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaDZBdc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 21:33:32 -0400
Received: by mail-ve0-f172.google.com with SMTP id jx11so5622636veb.31
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 18:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gGvulhkRbOOqSSZmapOeULO37kHyeMGGLMDy5GGqTwg=;
        b=cl3sxMru7lt56Zw7sPM2l5bvjYeBbVAzg9prJnZbMVjV6YAE3lURJahR79StGzSwN6
         0wE8+ZW4TCRlLeQYA8u/PYwZX4UAmnhJ5ZGlA/KjVbHQ4R75ACtcUPDPyJipTCYMuqhd
         R7/a/JwLCdJpN7dIE2gwVOsBqTMIfjKrYbUIdeIj4ETvYG1UpGdgP0g8o5z4kJcPyusa
         Lc8h60skMgnin7Vk9Rzloy+/0LHeNmL7eMwXvk/b5Z3zupG+p4OjCgFJsBisorVZ3qt4
         U4PtQw8/YpNxb0B6oeldGEnQx8y130no5T7jg2RXy6cqpxIjIWvSTIdHcqHdneOE07ga
         UzsA==
X-Received: by 10.58.154.10 with SMTP id vk10mr9677579veb.18.1398476011370;
 Fri, 25 Apr 2014 18:33:31 -0700 (PDT)
Received: by 10.58.131.103 with HTTP; Fri, 25 Apr 2014 18:33:11 -0700 (PDT)
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247139>

On 25 April 2014 11:12, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> It has been discussed many times in the past that 'index' is not an
> appropriate description for what the high-level user does with it, and
> it has been agreed that 'staging area' is the best term.
>
> The term 'staging area' is more intuitive for newcomers which are more
> familiar with English than with Git, and it seems to be a
> straightforward mental notion for people with different mother tongues.
>
> In fact it is so intuitive that it's used already in a lot online
> documentation, and the people that do teach Git professionally use this
> term, because it's easier for many kinds of audiences to grasp.

While the implementation looks okay to me, I will not pretend to be a
good judge of that so I will leave that to others. But I definitely
welcome the API change this produces.
