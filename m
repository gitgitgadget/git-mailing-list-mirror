From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Thu, 16 May 2013 19:07:26 -0500
Message-ID: <CAMP44s3UjDUWb_ng5NhLB2tMV0gqsRx_Ob=vj3P5RVfigD1r7Q@mail.gmail.com>
References: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com>
	<AE3E8FA3205F42C5B11F3617987BEA05@PhilipOakley>
	<CAMP44s13Q6DMX+QNteqO8D-J7bDcNyp7OkRVqj6B1Qhp0OSB+Q@mail.gmail.com>
	<D6098E29305740EE916958521A797AB9@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri May 17 02:07:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud8Cv-0004Rr-O7
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 02:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab3EQAH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 20:07:29 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:64504 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823Ab3EQAH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 20:07:27 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so3645725lab.35
        for <git@vger.kernel.org>; Thu, 16 May 2013 17:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=/M+RMnrz9E+eUMzLiOh3xlyaUW9/mCokqYSjV17Z2Xc=;
        b=rJAa/IjSlAJwEvGoY0AOCo+6uejtahp09vnCknNTyUml+nl1KcakpRlg2if+fvPlVO
         njzrGzJBBEzhkL10rAnV3/TsSJ5Y/TEWtc7RmqBWFlJbys99L9b+zqhreMg421d92owI
         cj6AAHFcp1dAd34D6k8Y1LfNd4Qo4RXZsWsYq3iJdiGRiuC+cShm9w0vj+9lTvYSmG0b
         o1aabfY+IXNg0cHdweiPOxhu85MEaJIg8Iht1ykm2w/rhuh+GHb78Pv/6yyU2XWqEzG9
         vTcPpMsSGBdMXM3bHt48X2imPoQ7vvu16+4mpxnmJDIARyByvjiBylaUcFqonmPwtSWc
         zxvw==
X-Received: by 10.112.125.130 with SMTP id mq2mr20849730lbb.103.1368749246235;
 Thu, 16 May 2013 17:07:26 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 17:07:26 -0700 (PDT)
In-Reply-To: <D6098E29305740EE916958521A797AB9@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224643>

On Thu, May 16, 2013 at 2:35 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Felipe Contreras" <felipe.contreras@gmail.com>
> Sent: Thursday, May 16, 2013 4:46 AM
>
>> On Wed, May 15, 2013 at 5:22 PM, Philip Oakley <philipoakley@iee.org>
>> wrote:
>>
>>> Sound a reasonable idea. On some patches I was working on I had to [chose
>>> to] add a tag for the base which made it easier to rebase later.
>>
>>
>> And was the 'upstream' branch somehow not appropriate for some reason?
>
>
> If I remember correctly, I had a short branch based on 'pu', which was
> rewound, so I wanted to rebase that short branch onto the new 'pu'. This
> creates a confusion between old-pu and new-pu. Having a marker for the
> 'base' at the branch point allowed an easy specification of the branch

So you were not doing 'git rebase @{base}', you were doing 'git rebase
--onto X @{base}'?

> I think I misunderstood your proposal. I thought that it would effectively
> save a marker (e.g. the sha1) for the base point of the branch, it may have
> been something similar to a [lightweight] tag, it could have been just local
> or could have been transferable, I hadn't thought it further.

Yeah, I thought about that, and I think it might make sense, but
that's another topic.

-- 
Felipe Contreras
