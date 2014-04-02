From: "rocketscienc01100101 ." <rocketscienc01100101@gmail.com>
Subject: Re: Bug in git-diff output
Date: Wed, 2 Apr 2014 12:59:43 +0200
Message-ID: <CALgQ2n8fNf4kSJhA2w0Us+SdDJMRzgeBkEis3Rs=q_Hp9fK4jg@mail.gmail.com>
References: <CALgQ2n-vPK6_0LnWA_AAD2GLvepjLN4A3UZFCAWzEp9r_=XOVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 12:22:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeMf-0000xS-PS
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758052AbaDBK7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 06:59:45 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:45528 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbaDBK7o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 06:59:44 -0400
Received: by mail-ie0-f171.google.com with SMTP id ar20so16482iec.2
        for <git@vger.kernel.org>; Wed, 02 Apr 2014 03:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=hvg95NzQAmggPeAkCq36SHceAZLooiFqbE1yFdx8sT8=;
        b=WrDdSl4jJreoFIqL0Pid9A1lV9m7tjMZaEthRjNLmZsGKBkwm+tq7O+a++iwrpx04S
         1e1/sKBrtf+iowlvz3kO72ZR6dk9RD5/9S4nQqtMEJeTd0YMJaFeJ+KffUp3RnyJ6FrZ
         AKtfXqv43mmNyMwKXA50gOXxrhIUO5P4vWLyYizvr73xjetkXYq59qS38HAqEnYQhIjG
         bllZV3S/0WVrCx81lTE8kXlBZIPRBrSqDl3Qi4vuJCzD6XiWuU78lef9vtd2HXsFyQRp
         k/UdewkliithGNqYmnw1N/ChVK5481m4/4YrODwpm3ORLVBQQ88L1i7gS8vdWlZ/Yitq
         f48g==
X-Received: by 10.50.56.109 with SMTP id z13mr724803igp.6.1396436383798; Wed,
 02 Apr 2014 03:59:43 -0700 (PDT)
Received: by 10.50.25.165 with HTTP; Wed, 2 Apr 2014 03:59:43 -0700 (PDT)
In-Reply-To: <CALgQ2n-vPK6_0LnWA_AAD2GLvepjLN4A3UZFCAWzEp9r_=XOVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245675>

On Tue, Apr 1, 2014 at 12:49 PM, rocketscienc01100101 .
<rocketscienc01100101@gmail.com> wrote:
> I tried to get a diff between HEAD and the current version of my
> project, so I did "git diff".
>
> It's a web project with a CSS file that contains the following CSS rule:
>
> a[href^=tel] {
>     color:inherit;
>     text-decoration:none;
> }
>
> Now, whenever I do "git diff", it will always show the a[href^=tel]
> part and mess up the output, even when I didn't change anything near
> that line. The problem is easily reproducable in a newly created
> repository.
>
> git --version
> git version 1.9.1
