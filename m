From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [PATCH] Fix 'Cloning into' message
Date: Thu, 27 Oct 2011 20:34:36 +0200
Message-ID: <CAD77+gQWhatFyo22au-k_ygjohPJ_HhkNvNSgqzX1wRaoiWgBw@mail.gmail.com>
References: <1319648748-9150-1-git-send-email-richih.mailinglist@gmail.com>
 <1319734013-8956-1-git-send-email-richih.mailinglist@gmail.com> <7vvcraz64i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 20:35:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJUn9-0002bS-To
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 20:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535Ab1J0Se7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 14:34:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42079 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221Ab1J0Se6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 14:34:58 -0400
Received: by wyg36 with SMTP id 36so3150060wyg.19
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 11:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=W10v52VZA0lJkjjwWVCaYx+E5yn17UjUuxfsH0khTjg=;
        b=g9SssSmNv9x2D0HYlweHGMei4bQHdxcSwSwSdg2AGOItxpphMkai+sDHlpuXJ24Cpx
         y1yfZv71mbEBwpQxFe4/mXHndu/zlEDT1EClLU0RoFoQhsrE2prbjU8EHK9mzR3N8pQf
         nqho5OBhNl88ZulclMuooFSCCC246re7NqCzI=
Received: by 10.216.134.93 with SMTP id r71mr9733996wei.59.1319740497081; Thu,
 27 Oct 2011 11:34:57 -0700 (PDT)
Received: by 10.216.24.136 with HTTP; Thu, 27 Oct 2011 11:34:36 -0700 (PDT)
In-Reply-To: <7vvcraz64i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184313>

On Thu, Oct 27, 2011 at 19:39, Junio C Hamano <gitster@pobox.com> wrote=
:


> We try to be consistent and many places do quote user supplied paths =
in
> pair of single quotes in human readable messages, and this is in line=
 with
> that pattern.

Exactly. That is why I chose single quotes. Sorry for not including
the signed-off the first time.


> =C2=A0 =C2=A0$ git clone foo "joey's foo"

In that case, the user has other problems ;)


Richard
