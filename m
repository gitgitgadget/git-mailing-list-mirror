From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Tolerate zlib deflation with window size < 32Kb
Date: Thu, 4 Aug 2011 09:45:20 +0200
Message-ID: <CAGdFq_jZNWxZmxuG_04O4CzdX_ipg-RDruiqdsKDXBxAaApoRw@mail.gmail.com>
References: <1312410730-12261-1-git-send-email-roberto.tyley@gmail.com>
 <7vsjpi82x7.fsf@alter.siamese.dyndns.org> <CAFY1edZyO7oYDi+tV2mxbhBHY_cf2F0bD7+KF9rxmKYygSFAjA@mail.gmail.com>
 <CAFY1edZLAjVRs0LUx6CvD9i5aZu6kZ1ecJdUsvZgmtGkajOqow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 09:46:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qosd6-0004ZM-AN
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 09:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644Ab1HDHqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 03:46:03 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51416 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab1HDHqB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 03:46:01 -0400
Received: by gwaa12 with SMTP id a12so904123gwa.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 00:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sQnIW+ROnDDJJLmstuceVS5aHvMs++y7+GBXqPaoGOQ=;
        b=vHgK9ysvTaAqODTj1Q1+B1HrY6H++8wpzqeKMn5TV4qpMNQXRxhrQv1T8wqFb090Oh
         Ao0oXxlRkgA7C9uv/YN11u2Ial+IkI33uR/d654pQ3ohtzB0z5xUS9dBQ5HYFVcLm9aX
         oPHy8sRVxGF4Pod7j4Xi3qFj7qRfs5uAyRcbs=
Received: by 10.142.153.5 with SMTP id a5mr545164wfe.121.1312443960122; Thu,
 04 Aug 2011 00:46:00 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Thu, 4 Aug 2011 00:45:20 -0700 (PDT)
In-Reply-To: <CAFY1edZLAjVRs0LUx6CvD9i5aZu6kZ1ecJdUsvZgmtGkajOqow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178706>

Heya,

On Thu, Aug 4, 2011 at 09:40, Roberto Tyley <roberto.tyley@gmail.com> wrote:
> Thankfully the rest of the logic still applies - I'll submit an
> updated patch in a minute, once I've conquered my embarrassment :-)

Perhaps you can include a test to increase confidence that it works now? :)

-- 
Cheers,

Sverre Rabbelier
