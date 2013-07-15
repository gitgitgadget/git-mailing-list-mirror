From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git-clone.txt: remove the restriction on pushing from a
 shallow clone
Date: Mon, 15 Jul 2013 13:33:49 +0700
Message-ID: <CACsJy8DELmhBwBCk9hmg4EpQxGeCRDPaSEr5rYp=CiMjq8j54Q@mail.gmail.com>
References: <1373607462-12836-1-git-send-email-pclouds@gmail.com>
 <20130713212541.GA10951@google.com> <CACsJy8ATX8aJJ40sF5XSoVpy=X1ZTLj5qpthrTQ52fv40QNn7w@mail.gmail.com>
 <7vfvvhgeif.fsf@alter.siamese.dyndns.org> <CACsJy8Bx_o+9S1N_uieQaV8NBbc3T_MR_VCvF+fM==Dy-vt7tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 08:34:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UycMa-00029y-W9
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 08:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab3GOGeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 02:34:21 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:37279 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973Ab3GOGeU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 02:34:20 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so15487999oag.28
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 23:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oF4MiQxd8sfK9G0/GLsxiz6BdpksbpX1Gsuk07R9KZs=;
        b=i4UTlcgt8uHHddEeyG+JcMibCjgxzdobxOHoz62PMWraenYq9LBAbadTd5+DWbE0Mj
         Xr+MnK81XVB5oVPUaxBkpCFzgL8wa+SgrQnXxTHvfVBQr0bIa8VMwNzvy/IBtocKpgb8
         tl1onMmMLic0Kkmc+MxmZLLhHyDBPKKzLplg0bJGPhLkB+15OtF26yu73ZCl8GzmBwSZ
         kcNOBY+O1d3IzhdC7XgxUqYQafCFelw2tjkOgG+Sk049CES7QJMgALBC3TozHICcpq9w
         bn3xU2jZGbZsqIiI4I2ruQXDnY+xK0aY0GMf0W+PE3O/4LKcOtrjmHjvaNQ+LwEJxXd/
         b/Pg==
X-Received: by 10.60.83.116 with SMTP id p20mr42039801oey.83.1373870059969;
 Sun, 14 Jul 2013 23:34:19 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Sun, 14 Jul 2013 23:33:49 -0700 (PDT)
In-Reply-To: <CACsJy8Bx_o+9S1N_uieQaV8NBbc3T_MR_VCvF+fM==Dy-vt7tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230423>

On Mon, Jul 15, 2013 at 8:01 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> Also, the sender may have cloned from the receiver (fully) and then
>> fetched a different history shallowly from elsewhere.  The receiver
>> may have no commit on that history, including the shallow-bottom.
>>
>
> Hmm.. right. And the receiver needs to setup proper graft to seal the
> shallow bottom. So it's really not safe to do pushing from a shallow
> repo without 52fed6e

Because this makes pushing from a shallow repo fall into "mostly
works" category, I withdraw this patch.
--
Duy
