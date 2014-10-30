From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: Editing git changelog automatically
Date: Wed, 29 Oct 2014 23:14:05 -0700
Message-ID: <CAM_iQpW-_src0W2-WkDRTMobua6UAQncvPqcxfqi6T82TdC7eA@mail.gmail.com>
References: <CAM_iQpWNQbv_GTT+H5KNCqqRS3qWfBuBge4+ZTAS_WiaREku4w@mail.gmail.com>
	<1414389944.7883.2.camel@spirit>
	<vpq38a9lxnu.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 30 07:14:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjizs-0005hk-UI
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 07:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757013AbaJ3GOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 02:14:08 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:63814 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbaJ3GOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 02:14:07 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn1so3666069obc.32
        for <git@vger.kernel.org>; Wed, 29 Oct 2014 23:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AR4oqzEH9jgI+8RvVU9qc2mAPhtJ3vGh4KzS16rarMU=;
        b=wtqiaXav+IrHfxDsZP/WdCo/2I4mUmISy6W7IgOw2GA4nIAoNoSUw89UqAPOGBuSX2
         ZrLeUHbl4sxq1dB7RXMdS0miYvsk6lDEMoOWagUvFL519hUb/pJxeCoMEWXPAyhGhv2A
         jbf5PZdM2wS/jav4q8LVuY5/qFN+kRXuFj9nPl47FJ8Ix3+ADdwR1AFFEYbYcjsMwq8v
         LelFl+6iSNKZ/OL+wrU4V2Yn/YVH1dHmAbSOUBwVhyhiLgGMNh1NyXv65o2CAHc+xti9
         x1yxvbH73o37DDLo3W0B07yV99MgNhw1osn0fTOpKPclUtCgfZEVtPw/1ZMJ9er+A5Gs
         ZrNA==
X-Received: by 10.202.3.70 with SMTP id 67mr248464oid.69.1414649645882; Wed,
 29 Oct 2014 23:14:05 -0700 (PDT)
Received: by 10.182.27.72 with HTTP; Wed, 29 Oct 2014 23:14:05 -0700 (PDT)
In-Reply-To: <vpq38a9lxnu.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 27, 2014 at 1:33 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>
>> On zo, 2014-10-26 at 22:27 -0700, Cong Wang wrote:
>>>
>>> My question is how to edit dozens of git commit changelogs
>>> automatically?
>>
>> You can use git filter-branch in --msg-filter mode.
>
> Note that in any case, you'll rewrite the history hence change commit
> identifiers. If the history is already published, it's probably better
> to live with the typo than to try to fix it now.

I am aware of that, it is my local branch, so no worry.

Thanks.
