From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 00/10] transport-helper: updates
Date: Mon, 11 Nov 2013 17:44:34 -0600
Message-ID: <CAMP44s3cqnZrTPede8=ARGo9ZsZjwjshWq3GBSfG_19Vmxofzg@mail.gmail.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
	<1384210507-26561-2-git-send-email-felipe.contreras@gmail.com>
	<xmqqiovyjyyu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 00:44:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg19s-0008Bv-GF
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706Ab3KKXoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:44:37 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:58091 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401Ab3KKXog (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:44:36 -0500
Received: by mail-la0-f41.google.com with SMTP id hp15so486684lab.14
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 15:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jTHLhIBbxA1YTf5l/OR4EmQy1r34lPsiKu4nEHVH0Xs=;
        b=PSK59UG8kXeNgpz9StgKCqZFc7jYN/zW9sZI8RM6XqHfL9i6z41iyn0JWefQ05R8XU
         D4iCpZDEwvPhV40Gd41OfhTVOfB/OeOpNaQATWJPQiQ6tMF8kMwuCKao6i45SQfEsPBn
         hFBSLKhJHzbOR2+wOrUBintQYkhAB9iiUe/99jY86Kaq2kQtjXS8RBJSf2bVlUNNFO3x
         ddtVQB6p3rlNO5/eooN2GiTjrTR5paF9cqiS6woR19tIh01ghXrZ5Gb5G8J4HmKB8ZZ3
         FPMLiQNJ+JVMyP0rJBpOetDINswCx58siHmYr9U8u3ZebxPgiSUIsLuGg72KuYV8B9/b
         1mpQ==
X-Received: by 10.112.171.228 with SMTP id ax4mr24042463lbc.6.1384213474919;
 Mon, 11 Nov 2013 15:44:34 -0800 (PST)
Received: by 10.114.201.69 with HTTP; Mon, 11 Nov 2013 15:44:34 -0800 (PST)
In-Reply-To: <xmqqiovyjyyu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237680>

On Mon, Nov 11, 2013 at 5:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Here are the patches that allow transport helpers to be completely transparent;
>> renaming branches, deleting them, custom refspecs, --force, --dry-run,
>> reporting forced update, everything works.
>
> How are you sending your patches?

% git-send-email --no-annotate list-of-patches

However, I just noticed that the list-of-patches is in the wrong order.

-- 
Felipe Contreras
