From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH (performance tracing)] test git-status performance
Date: Sat, 26 Jul 2014 17:33:27 +0700
Message-ID: <CACsJy8DxyS9_L8_yFo-mXe3=SNFALV6Qx2tCaZe=q2uMKLWNdQ@mail.gmail.com>
References: <53AA0129.1080109@gmail.com> <53AA0228.4080600@gmail.com> <CACsJy8BugcnUF1AmLqZ3jnWiRtark81jOTGkDP-xCr8LBgaf8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 12:34:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAzIh-0003SQ-5m
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jul 2014 12:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbaGZKd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2014 06:33:58 -0400
Received: from mail-qa0-f41.google.com ([209.85.216.41]:47723 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbaGZKd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2014 06:33:58 -0400
Received: by mail-qa0-f41.google.com with SMTP id j7so5849371qaq.14
        for <git@vger.kernel.org>; Sat, 26 Jul 2014 03:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZuHgkEv+uPeQDdK2443gvk/Q8euz3R89HTsCXm+Na/A=;
        b=GmrfJ8USG1lj+9O/8vpICy0aXcb0XbKubFGTJ7DHGcqQDU5pnp6+yIR7tJtWOdDOZt
         b1LzJTN08oI76lOknSM7h90MQIclKd85ghEPO4ufZV/ukB34ThcID0JiX/tKuxNgjp8U
         OP0yiFjRY1kCGU35eS3r+oNWjfyrFvreAtvPjVrU5KlvszS8ttvL/3hP7n8nyLdtRJVk
         vN83hm7mb7YYFzGiyOdoaZgCgRcDc42WMHzIGumTb72WVkIHZ0g2VkWFi1rZ9IrVj9XA
         5RnPOIP6qiW/dRJeVWki2aVLNfngbtVHRY6b5DoEClPnK/cows7ZqgtB8OkzpwWp1vo2
         pouQ==
X-Received: by 10.140.30.73 with SMTP id c67mr36075864qgc.16.1406370837398;
 Sat, 26 Jul 2014 03:33:57 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sat, 26 Jul 2014 03:33:27 -0700 (PDT)
In-Reply-To: <CACsJy8BugcnUF1AmLqZ3jnWiRtark81jOTGkDP-xCr8LBgaf8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254277>

On Sat, Jul 26, 2014 at 4:59 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jun 25, 2014 at 5:56 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
>> Add trace_performance output to functions involved in git-status.
>>
>> Signed-off-by: Karsten Blees <blees@dcon.de>
>
> Should this patch be merged to git.git? It's useful for tracking
> performance (of git-status) and does not seem to have any negative
> impacts.

Hm... I don't like the changes in commit.c and rather print running
time inside read_index_from() and update_index_if_able(). So people
may prefer different ways of measuring and these patches should
probably stay private. Although if we have something like this shipped
in every distro, asking the user to run with $GIT_TRACE_PERFORMANCE
could help..
-- 
Duy
