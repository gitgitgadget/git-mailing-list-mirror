From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: trivial fix
Date: Wed, 29 May 2013 20:25:42 +0700
Message-ID: <CACsJy8DTKZgVM7TSBUKJq2pspkR1jH-fyG6BHr1YYz3N+Ov3XA@mail.gmail.com>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com> <1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:26:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgOS-00036Y-Ar
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965896Ab3E2N0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 09:26:13 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:55866 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935121Ab3E2N0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:26:12 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so11566811oag.30
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NFNERlWSfsDWybRNTAw3073Rh4xocnDoAnmW2tFDUuA=;
        b=0tPJJl+OvGPwZlkRlW7tX9u+oosNYyCwFOJQKzZ6GTwlQFfxJf0AdmIzpIeYv6+HlU
         XSJ2PxpLSPTc6anSDLIE3Fzr/zwdzJbWjl2gHU9ePztBEJe97KtafEYsH6tbobIVR5Dx
         ZUFHh+qUXOOE920DroD2Am3maUF51DOJHJOOwIC/B+ILNam8zcJoXnO0g2VnmW6JYuGu
         WapokTS6U/heC+C4dP+dPMVVrZmBBgDV4Z1dzSeH2VRSNLDxS8TNjESfnxU2nHdB8XQU
         E7qxC6mnjLz4letpbrDJxE+4zs5bgzv4XnlCk5vaUW87Icm2L/vBcCS42IN7mC3KOto3
         CiPQ==
X-Received: by 10.60.59.37 with SMTP id w5mr1605776oeq.7.1369833972449; Wed,
 29 May 2013 06:26:12 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Wed, 29 May 2013 06:25:42 -0700 (PDT)
In-Reply-To: <1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225814>

On Mon, May 27, 2013 at 11:52 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> We should free objects before leaving.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Micronit: perhaps you should move the "free obejcts before leaving"
(in do_pick_commit) to the subject instead of "trivial fix", which
adds no value to the patch.
--
Duy
