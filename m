From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2014, #08; Mon, 31)
Date: Wed, 2 Apr 2014 06:40:59 +0700
Message-ID: <CACsJy8BVXk248VDBi-pAMDY4QpDSbFuAf5qxRxCCq71yGNzpqA@mail.gmail.com>
References: <xmqqppl128q8.fsf@gitster.dls.corp.google.com> <CACsJy8A9b2eccm_BJMjW5RwWLux90xs7HfUQEn0_jrzhHWeajQ@mail.gmail.com>
 <xmqq38hw272q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:08:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVdtX-00026v-CS
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbaDAXla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 19:41:30 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:60177 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbaDAXla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 19:41:30 -0400
Received: by mail-qg0-f46.google.com with SMTP id 63so6199308qgz.19
        for <git@vger.kernel.org>; Tue, 01 Apr 2014 16:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CXIQIQ36miMDxxNGuLWxcdOhyMlF6sLWwsI66CL98VA=;
        b=RaZyOneF3A0/gpAFRHU8h5mcVQn835dIU4mI8gnbusMWqHT1ORSFFBv+DTApURVjRJ
         RMJ9IelTMEx9//okitAFLN517L/LGUmi6p7PK1lXqxi3kov7wQ3ExxBHwsojKP9ByD7O
         X4+dQBZrFj5ul1OCayh6MtazhnGvPphT1IsiQ/0NnHkgFNdN8AvzQAJItHRxqyPvVlNe
         kTXvuUXLBvt53jjaBvZtnakwUZKWYhVFBEHNdlxMNs64YTpZEUR26bzdjDMeQyqnIsjS
         +sH4W8Eby3ANgy5A8x6m9xGMm9m9imkvXjM4GEN/8ddYFDNkvOse5b6xYdi+uIFFPtdW
         4m8Q==
X-Received: by 10.140.87.5 with SMTP id q5mr16584397qgd.31.1396395689171; Tue,
 01 Apr 2014 16:41:29 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Tue, 1 Apr 2014 16:40:59 -0700 (PDT)
In-Reply-To: <xmqq38hw272q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245674>

On Wed, Apr 2, 2014 at 2:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Unfortunately, this multiple checkout thing conflicts with how I
>> use emacs (--daemon) so I'm not one of its heavy users either. I
>> only occastionally make new, short-lived checkouts to test things.
>
> FWIW, I do keep a permanent multi-checkout and I sometimes make
> edits, but it is mostly for building other branches while I work on
> something else.  When I edit working-tree files there, I do let
> emacsclient talk to the emacs I have files open in the primary
> working tree, though, so I am not sure what your issues are with
> emacs (--daemon).

The --daemon part is probably not worth mentioning because I always
have one emacs window open. The problem is switch-buffer based on file
name can be confusing ("git.c" and "git.c<2>", which belongs to which
checkout?). I ended up modifying files in the wrong checkout all the
time.
-- 
Duy
