From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/7] New remote-bzr remote helper
Date: Wed, 28 Nov 2012 01:42:14 +0100
Message-ID: <CAMP44s1NrmhVaTgAs_Y_C3BXpX205L=yBigxp+k9qxz4tOEKag@mail.gmail.com>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s2F9C4cr6v===M3AWHieaiUk1adigcU8txpZPL0wN81Ow@mail.gmail.com>
	<7v4nkdxawx.fsf@alter.siamese.dyndns.org>
	<CAMP44s1G3b3XQX+=5Ag2exdy83hULbz1m0Z6UFDrhZU2TGwBMg@mail.gmail.com>
	<7vehjelizc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 01:42:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdVjS-0002pM-RJ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 01:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab2K1AmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 19:42:16 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42129 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab2K1AmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 19:42:15 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so13039915oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 16:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N27Z+FAIgRZFYefSoWfloMbJ95l3gr0lpSU6rE7lKQA=;
        b=rFYEkCecRE45VK7I/J0NcgYqPuWa95fAj9Tndk2U6bt4GhhRMRty3DmcxKpOsRgUzP
         U8hTIj7v03KCA97runIw6eDMy4p/ErG9xakC/GP/WxXzk4tP9sy6JZojyA0q3gB3z+4F
         39Av5PmJPALBQQcgzZgLV91JbApSgND1LFTOT9mXsxkeHFM0r9hmNMBh5to5n9UWfK1i
         UXhsfERHyCy0N0SpSDB9+kNRmrfHHrBoFdirurTGJ/V5cpoZFg/BLzqn6hl0nugkCpTX
         iauFm+yJggPirX98CrFx4coejpEay9ZsksttbW6L+lkehQtNvDDvGweOOzmqByzhWmb6
         2tAw==
Received: by 10.182.98.19 with SMTP id ee19mr1406630obb.90.1354063334934; Tue,
 27 Nov 2012 16:42:14 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 16:42:14 -0800 (PST)
In-Reply-To: <7vehjelizc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210645>

On Wed, Nov 28, 2012 at 12:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Mon, Nov 26, 2012 at 5:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> On Sun, Nov 11, 2012 at 3:19 PM, Felipe Contreras
>>>> <felipe.contreras@gmail.com> wrote:
>>>>> This is a re-roll of the previous series to add support to fetch and push
>>>>> special modes, and refactor some related code.
>>>>
>>>> It seems this one got forgotten, I only see v2 in pu.
>>>
>>> Oops; I think that was fell through the cracks during the maintainer
>>> hand-off.  As the previous one has already been cooking in 'next'
>>> for a week or so, I would appreciate if you send incremental updates
>>> to fix or enhance what is in there.
>>
>> Yes, that's what I have planned for the next patches, as I already did
>> for remote-hg, but the changes in remote-bzr were a bit bigger.
>
> OK.  Both fc/remote-hg and fc/remote-bzr are slated for 'master'
> soonish, but I take the above to mean that fc/remote-hg is ready
> while it is better to wait for updates to fc/remote-bzr before
> merging it.

Please update remote-bzr to series version 3. The rest of the patches
will be on top of that version.

-- 
Felipe Contreras
