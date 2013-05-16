From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Thu, 16 May 2013 20:35:26 +0100
Organization: OPDS
Message-ID: <D6098E29305740EE916958521A797AB9@PhilipOakley>
References: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com><AE3E8FA3205F42C5B11F3617987BEA05@PhilipOakley> <CAMP44s13Q6DMX+QNteqO8D-J7bDcNyp7OkRVqj6B1Qhp0OSB+Q@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 21:35:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud3xc-0001nw-EI
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 21:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab3EPTfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 15:35:30 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:12187 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751967Ab3EPTfY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 May 2013 15:35:24 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuINAFQ0lVFOl3Gk/2dsb2JhbABbgweDc4U/uEgEAQMBfBd0ghoFAQEFCAEBGRUeAQEhCwIDBQIBAxUBAgICBSECAhQBBAgSBgcXBgoJCAIBAgMBh2kDE6peiHcNiE+BJosigW1qgkkyYQOOaIZqjgOFI4MROw
X-IronPort-AV: E=Sophos;i="4.87,686,1363132800"; 
   d="scan'208";a="409924914"
Received: from host-78-151-113-164.as13285.net (HELO PhilipOakley) ([78.151.113.164])
  by out1.ip04ir2.opaltelecom.net with SMTP; 16 May 2013 20:35:20 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224613>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
Sent: Thursday, May 16, 2013 4:46 AM
> On Wed, May 15, 2013 at 5:22 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>
>> Sound a reasonable idea. On some patches I was working on I had to 
>> [chose
>> to] add a tag for the base which made it easier to rebase later.
>
> And was the 'upstream' branch somehow not appropriate for some reason?

If I remember correctly, I had a short branch based on 'pu', which was 
rewound, so I wanted to rebase that short branch onto the new 'pu'. This 
creates a confusion between old-pu and new-pu. Having a marker for the 
'base' at the branch point allowed an easy specification of the branch

I think I misunderstood your proposal. I thought that it would 
effectively save a marker (e.g. the sha1) for the base point of the 
branch, it may have been something similar to a [lightweight] tag, it 
could have been just local or could have been transferable, I hadn't 
thought it further.

Philip 
