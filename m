From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: allow extra breadcrumbs to prefix the trail
Date: Thu, 4 Jul 2013 00:11:01 +0200
Message-ID: <CANQwDwcneUzzXS-Du-3Aca3-Vp8ycSzVqUv1rVRVhaNUWfeokw@mail.gmail.com>
References: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk> <20130703215930.GT408@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tony Finch <dot@dotat.at>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 00:11:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuVGq-00059J-Iu
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 00:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933142Ab3GCWLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 18:11:22 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:47481 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932486Ab3GCWLW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 18:11:22 -0400
Received: by mail-qa0-f46.google.com with SMTP id ih17so3888431qab.19
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hFMzTE+B5TNbkCTEJ5PxNNJOKEgwcijBv/z0k0CHKzE=;
        b=bOANFTEGJAFPj0z7uznuwE+ych3M6fUimJL0fMiDkm8w0Y71XuCqywTCowZqAA+4yi
         toVioeNK/Z6XECrncrZMK7VMxTYsS+WjGdX19PGtmukG0xGMD07XbVtiYMtUA57IPcVi
         PNguIobpWk69nVbJlG84a+CJs/gH7r6E9BxwBrHrZsT3UVlSMeYj0bJCcp91GBPfg5KH
         pjR/12+JyucP8W1rDYEfF/SBAL7MDgcgPHgQotljFkoFMB8Bf0aGT8DeFpBQTUV8NHL5
         HLkJLNkjvCDLFcZvGaJCST8qbmYl0bNCWT43uJ6ND2EByLFbqLYG6K8mFxHQkH02lIer
         pjaQ==
X-Received: by 10.49.38.105 with SMTP id f9mr3741277qek.63.1372889481265; Wed,
 03 Jul 2013 15:11:21 -0700 (PDT)
Received: by 10.49.75.169 with HTTP; Wed, 3 Jul 2013 15:11:01 -0700 (PDT)
In-Reply-To: <20130703215930.GT408@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229539>

On Wed, Jul 3, 2013 at 11:59 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Tony Finch wrote:

>> +@extra_breadcrumbs::
>> +     Additional links to be added to the start of the breadcrumb trail,
>> +     that are logically "above" the gitweb projects list. For example,
>> +     links to the organization and department which host the gitweb
>> +     server. Each element of the list is a reference to an array,
>> +     in which element 0 is the link text and element 1 is the
>> +     target URL.
>
> Is arbitrary HTML permitted in the link text?
>
> I think it makes sense to permit it for consistency with $home_link_str,
> but it might be worth mentioning in the manpage so the administrator
> knows not to set it to something user-controlled --- e.g.:
>
>         The link text can contain arbitrary HTML --- to escape link
>         text generated programatically, use esc_html($text).

Nb. it would be nice to have relation of @extra_breadcrumbs with
$home_link_str explained.

-- 
Jakub Narebski
