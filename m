From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] t7012: Implement test for git-checkout
Date: Wed, 30 Mar 2016 11:21:31 -0400
Message-ID: <CAPig+cSF-8pV08PeVVtRcmoZvV-013MJPmzJ6+hsci5vYsi86Q@mail.gmail.com>
References: <56F6BADF.4000005@gmail.com>
	<56FBD4C9.7080904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Chhatoi Pritam Baral <chhatoipritam@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 17:21:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alHwG-0008OE-VP
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 17:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbcC3PVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 11:21:34 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33440 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754321AbcC3PVd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 11:21:33 -0400
Received: by mail-vk0-f67.google.com with SMTP id a62so7218205vkh.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=kXcd7Zv+8c0bYrtHly/5BYgSPzg4KUZD4Ya8VLnIWuo=;
        b=EcUDjYYwyEJqvjCdlZIiS1uwBqTkV4AeOpoeVsJIPqZtSWn2XODvNQPJmLLPFzfSpn
         kipB2QJUxB5lW8QK3FkYF2XvvorvO/VlJYzbd3GLAOVCxf8fCjupfgoV5FILXNTUV3hg
         0aYYBlSZdOz1pua8a/VQnHgtH96NYoHHaLhZGz1/Q0aZU9BTB8DweT5v94wr//zwhYd8
         6J99Ado/Mtl1GQkJCgEecDy5yPLw74zS5nZChyo/q5HMqV59Cj31aR7/BtpnhdbS7SOf
         Ha9yqRyTSTcAZhECej5t6PIQ85ngUsSOfROr0m+IexBH+K1pGj/YFGLEjMMZM42nRZeS
         pKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kXcd7Zv+8c0bYrtHly/5BYgSPzg4KUZD4Ya8VLnIWuo=;
        b=DbuEKTb9vs4lgOMfABodW0SAguOHb7sXAGe79WTW4gIXJrApMF4R+VZYPStwLWNPCC
         ZBTMKSCrPuH1rtKdv1DrmXsZ1epVCgJmjAtJDX+m636ZYoqUOpynXJPt5jBJSDl5M0jV
         q54rPi067BlCTtU+zrWz5Nl9QJHChBjmZi+V92s2TmahRuozuRkB1LUP/VQt0x5Xx9de
         m7vYQcyt1wUXOP2p2Ru20l//dES1W/atuDqhL2LjKkcEWXPS9pvAlCDK84QbD8RRyeh1
         Bz7xCUWp6f5VQVNIHBVCFD8r41J40w5QEu1yFYNCqbsPIxM/gBR3tu/SF2vuX4SNCZTy
         PNtg==
X-Gm-Message-State: AD7BkJJhedhbKvHmLS3dv4fHtg2kYwgZyXAkNnOOa0zzbAgsh2f8M8oMt6IAk9lJk7WFWeK3kkDGdidyP6LyTQ==
X-Received: by 10.159.33.206 with SMTP id 72mr5033633uac.14.1459351292044;
 Wed, 30 Mar 2016 08:21:32 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Wed, 30 Mar 2016 08:21:31 -0700 (PDT)
In-Reply-To: <56FBD4C9.7080904@gmail.com>
X-Google-Sender-Auth: TfbnK5Yrv2M3ndWPaGC9LOcQWzE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290308>

On Wed, Mar 30, 2016 at 9:29 AM, Chhatoi Pritam Baral
<chhatoipritam@gmail.com> wrote:
> Forgot to mention in the previous message, this is a microproject
> for my GSoC '16 application.
>
> (Is that redundant to mention after v1 and v2? )

Readers of v1 knew this since you mentioned with that version, at least.
