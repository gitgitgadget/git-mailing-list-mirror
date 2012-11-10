From: John Szakmeister <john@szakmeister.net>
Subject: Re: Bizarre problem cloning repo from Codeplex
Date: Sat, 10 Nov 2012 07:15:39 -0500
Message-ID: <CAEBDL5W0Y85dE5_vjuzBbJh6tm_ZNdKDBvsQyWJucAEhTU07Fw@mail.gmail.com>
References: <508B133D.3090300@game-point.net>
	<6c843260-6190-469a-aa53-243ac440b0fd@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeremy Morton <admin@game-point.net>, git <git@vger.kernel.org>
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Sat Nov 10 13:22:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXA4Z-0004Oy-1M
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 13:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327Ab2KJMPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 07:15:40 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46954 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab2KJMPk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 07:15:40 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so7124027iea.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 04:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=sGByK6b3yZPE0HesgiFLO+Che0/MHN8tkYmifol9sNM=;
        b=xVeK0N5g7yj8C9DNgg3elIXoVzDdjnUVCMounyOWkB3Mcu97um3hqZ3H7+Q5AU8+Z8
         nsnDFJkc4DGjuO+ggmY1bwpVhX4yyf2J1zBYNJEaDIIXFj9XsAwUIkjSqQvLfLU0nOLy
         BzG0c1tIV542tPx5C66uOfZ72BVpjXT9U+VHYjILmBKWl6rf0UaVDKPz6BPU0dnN/fjt
         oPJ5cXHUuRJfs7TYuJ7ArcNouFsKpEAK/UA9Y89BFoycxNrZTNfa0/SrdwOvdqhLGYxt
         b2eZEjqBi2tQHujfn4EK4IyHw5suR56VLLEk0t2oDtlUnmWr3DpZB2JfuavozJrfy3AJ
         eLGQ==
Received: by 10.50.217.195 with SMTP id pa3mr671791igc.19.1352549739484; Sat,
 10 Nov 2012 04:15:39 -0800 (PST)
Received: by 10.50.2.106 with HTTP; Sat, 10 Nov 2012 04:15:39 -0800 (PST)
In-Reply-To: <6c843260-6190-469a-aa53-243ac440b0fd@zcs>
X-Google-Sender-Auth: xwABGirQ6SVmrUGR18IgRIASpDs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209272>

On Sat, Nov 10, 2012 at 2:49 AM, Enrico Weigelt <enrico.weigelt@vnc.biz> wrote:
[snip]
> Their webserver seems to be configured quite restrictively
> (eg. cannot access files like 'packed-refs').
>
> Is there a way to trace the actual HTTP calls ?

Try GIT_CURL_VERBOSE=1.  GIT_TRACE_PACKET=1 can be helpful too.

-John

PS Sorry for the duplicate.  I meant to respond to the list as well.
