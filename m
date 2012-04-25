From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/10] i18n relative dates, help, remote, apply,
 index-pack and bundle
Date: Wed, 25 Apr 2012 18:42:00 +0700
Message-ID: <CACsJy8AsmvfTLhAKWfijNcuz868L+KvdJuw5CPUj7KDBVKrL8A@mail.gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
 <20120424121953.GA25944@do> <xmqqobqggb8e.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 13:42:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN0cH-0004UE-Hr
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 13:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab2DYLmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 07:42:33 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:61676 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab2DYLmc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 07:42:32 -0400
Received: by wibhj6 with SMTP id hj6so4948189wib.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 04:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DSDl9lSsAm9NLYSEcLBJV87SPqpRXgvLXkYNgAZdXT8=;
        b=do+4VTiEj8TBoGN0zAYOaJP1+1TfV5z3QCf+vcrEUZZwt0ZZ5awidcjATNujjFFmJg
         fcTIfKiA6urV8ViUoZgQZIcmu+M+n+8gLAsv5cuCMWY+WMN1TEQh8ZacqrveSiM/hpbS
         qpaixpgGUkjmFuQNG0215WtE6XJqnBUqRh1HwBZ6Yg5/4MU/N+lpm5Xo0SMhjCUQgAoH
         bTeEgk6j1BwfQDHskIlXYmVeV34SmkLVUjsyCGF61c12AT+IyHtUcmu6um5sV6GnHt4l
         gwkhwBw90Y2uITOA9JtYeYEtXzh+lA3wqBpqu7zfUriBVuVq3RnUjmOgxO5BPsCij8eN
         nXSg==
Received: by 10.216.135.105 with SMTP id t83mr1413712wei.105.1335354150774;
 Wed, 25 Apr 2012 04:42:30 -0700 (PDT)
Received: by 10.223.16.194 with HTTP; Wed, 25 Apr 2012 04:42:00 -0700 (PDT)
In-Reply-To: <xmqqobqggb8e.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196312>

On Wed, Apr 25, 2012 at 2:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> The idea is modify all git commands and output all marked strings in
>> "struct option" and usage strings, instead of manually marking them
>> one by one. The marked strings will be collected by xgettext just like
>> another source file.
>
> Gaah, my eyes, my eyes.
>
> No thanks.
>

Good. What burned your eyes though? Are you ok with an approach that
does not change source code (much) and still marks strings using an
external tool? I'm looking at sparse, but perhaps a simple perl script
to look at "gcc -E" output and search for "struct option" would be
enough.
-- 
Duy
