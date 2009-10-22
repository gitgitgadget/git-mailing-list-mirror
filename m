From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Updating a branch.
Date: Thu, 22 Oct 2009 15:26:04 -0400
Message-ID: <32541b130910221226t78f27976t69d0093aa7ba417c@mail.gmail.com>
References: <26015707.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: elyod72 <elyod72@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 21:26:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N13Is-00084O-2C
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 21:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717AbZJVT0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 15:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756363AbZJVT0T
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 15:26:19 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:36028 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942AbZJVT0T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 15:26:19 -0400
Received: by yxe17 with SMTP id 17so7298677yxe.33
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=XDT430iGhCBlVBbrngFFK4JowUkwafuy6VXcKiJ3J8Q=;
        b=CVAPjaqCPDoosxhp/hR9lJAYQv77eDvo/Dn2geuTRv1IMC/AjyL3mDbbIfqhWGhyK/
         xwfKyrpVy0Is+iWbOs3pD92686LmA2eGyo0m+ng5/yv6SaQ7ame0p9VXUZT1VxQCuW03
         TQzfwnWsKErXtq9KjMVyxy4ip3b9bWNmxng3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hTU0zIeJpac5EnxM4j2lUD2yuRA1jjy6fRtpUMvyYj0f2bjUgC+byffIOO5EKj1BxW
         tN7ifF7s52Cu8wTlqUsRJwl3zY07RO33yJf4ShaNw0QZYzRDQQ+4DumwYR2wg2QqB2H9
         iDsFaGa3M4SQ7ND/upR/G1dmVkZtnPPLek81g=
Received: by 10.150.87.28 with SMTP id k28mr16303440ybb.275.1256239584054; 
	Thu, 22 Oct 2009 12:26:24 -0700 (PDT)
In-Reply-To: <26015707.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131047>

On Thu, Oct 22, 2009 at 3:21 PM, elyod72 <elyod72@gmail.com> wrote:
> I have my Master branch.
> I then create a new branch named Test.
> I then make changes and additions to the test branch.
> At the same time I make changes to the Master branch.
> Now I want to update the Test branch with the latest information from the
> Master branch.
>
> How do I go about doing that?

git checkout Test
git merge Master
