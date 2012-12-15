From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Sat, 15 Dec 2012 03:24:35 -0600
Message-ID: <CAMP44s0ou-8u1N7k8U9qHfagFJR4Jn6HYWZ8_jWgXgRUuzUJEQ@mail.gmail.com>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org>
	<CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com>
	<7vvcc6z801.fsf@alter.siamese.dyndns.org>
	<CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com>
	<BF9B1394-0321-4F1C-AD1B-F40D02DBE71A@quendi.de>
	<CAMP44s3Es-rLjwe6sgOi9OmwQouM4AbFKAbGB5UgS6sUtYRgKQ@mail.gmail.com>
	<F151B265-7E3E-4989-AA16-EB7CAC298126@quendi.de>
	<CAMP44s0r_KAKt7Lm1cdumN1cOWzjab3ruYqxp-s6OR1g1qqbcQ@mail.gmail.com>
	<50CC2244.4040103@alum.mit.edu>
	<CAMP44s0=R3rdnD-Zpzz_7wY6HKKsAL1sPVYh4pc3z1CBbX2ODg@mail.gmail.com>
	<CACsJy8A=-3-C29LKQasfUih24cSZrRuQRJ28WjP0zKg=NaFuUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Max Horn <postbox@quendi.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 10:25:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjnzY-0001Rs-NL
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 10:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061Ab2LOJYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 04:24:38 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37281 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab2LOJYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 04:24:36 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4386256oag.19
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 01:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D92+FS3fO7Y/vEG73NjRgqKwPmcBeJ8omw1HUr4Ix4A=;
        b=kybDvhxNlS4fCeGx/LlmyTQ+h6BsG/QwkkvP3NE6VxA1pPi1riiTeV2SYAd2jbBhC8
         85D8IGFLhHL6ySkjNUbCaVn034TzpcD5uqGbuCwM7G0d071nzbIfZlaJAbqaVrb2Vta9
         H2p9OUy5vO6jFoPTp8hJtXNVZ8YzTef4sRf9p6oVgXOlimk+qY9DcVhyp/6+uxVIaRg0
         04inY8d0I2Xqo/quenVqf+6M+S0Hy8Xu5TVxrfQpyA5v9V4mRBCVYH4GNpOsHHZpT4DS
         NvzcCHaHCjhEhEzLD5spsTFLCCBQGBEXciRIYVX5r30kET7kI4L3yNVOU335iGFmZYTp
         JHJw==
Received: by 10.60.1.132 with SMTP id 4mr6716680oem.140.1355563476072; Sat, 15
 Dec 2012 01:24:36 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Sat, 15 Dec 2012 01:24:35 -0800 (PST)
In-Reply-To: <CACsJy8A=-3-C29LKQasfUih24cSZrRuQRJ28WjP0zKg=NaFuUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211525>

On Sat, Dec 15, 2012 at 2:44 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Sat, Dec 15, 2012 at 2:45 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

>>> Cruft in the codebase is a problem for git *developers* because it makes
>>> the code harder to maintain and extend.
>>
>> A problem big enough to warrant the rejection of the patch series? No.
>
> May I suggest you maintain remote-bzr as a separate project? You have
> total control that way without anyone's disagreeing with you.

Which disagreement? We have all agreed how the code should look like
in the end. The disagreement is on how and when this code should be
merged to git.git. A separate project is not going to help there.

> And speaking from someone whose series may take months to get
> in, why the rush?

Why the delay? Junio had already merged this code to 'next'.

-- 
Felipe Contreras
