From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 p2 2/9] fast-export: don't handle uninteresting refs
Date: Sat, 24 Nov 2012 04:27:52 +0100
Message-ID: <CAMP44s3Gdr3W5oDL79F_LGqhB77LT6Ay7p8rWWuygbOgHzEdsw@mail.gmail.com>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
	<1353727520-26039-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:28:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6PY-0008EU-Fy
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827Ab2KXD1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:27:53 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48345 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594Ab2KXD1x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:27:53 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so9429469obb.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8YqxlsOXh610Kg2aqfIgWp6bhM5RnmI3TSDjJeOqQwI=;
        b=0MT85G6I97HF+/jV3XB8Eqlna5twzL+g4gLRXyuPnDjznBQR3a5vymrmtuuN1scok2
         ewqEsFMlDGlkhBk140TVb4TBhbggGdXVW7MF4v6vBvCN6Y4yAzg4WZDNsGqbzkS4Nk1m
         EN6NPgWmv3wWZXrcgdTWIsRVkDnLQlLj3m8khqhmRSS5qmaAXMKrYubqDkmjCrBBNc6Q
         V0qIifPStzI3cVZ7OiH4cOuNo5zPZwi0SGKtvS8AwsMUs8JIFljPCciZCp2gTPNLuQzc
         2ROdnrJ01RoaglbUmbAw+x8KdAkpC5/w3KIAykI+GZ2yg37fbmdCBlcQrLvML1S8/ayY
         WVhQ==
Received: by 10.182.21.175 with SMTP id w15mr4431949obe.28.1353727672666; Fri,
 23 Nov 2012 19:27:52 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Fri, 23 Nov 2012 19:27:52 -0800 (PST)
In-Reply-To: <1353727520-26039-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210309>

On Sat, Nov 24, 2012 at 4:25 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> +cat > expected << EOF
> +blob
> +mark :13
> +data 5
> +bump
> +
> +commit refs/heads/master
> +mark :14
> +author A U Thor <author@example.com> 1112912773 -0700
> +committer C O Mitter <committer@example.com> 1112912773 -0700
> +data 5
> +bump
> +from :12
> +M 100644 :13 file
> +
> +EOF
> +
> +test_expect_success 'refs are updated even if no commits need to be exported' '

The title should be updated: 'avoid uninteresting refs'

-- 
Felipe Contreras
