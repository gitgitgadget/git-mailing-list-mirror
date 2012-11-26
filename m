From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/7] New remote-bzr remote helper
Date: Mon, 26 Nov 2012 12:34:12 +0100
Message-ID: <CAMP44s1G3b3XQX+=5Ag2exdy83hULbz1m0Z6UFDrhZU2TGwBMg@mail.gmail.com>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s2F9C4cr6v===M3AWHieaiUk1adigcU8txpZPL0wN81Ow@mail.gmail.com>
	<7v4nkdxawx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 12:34:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcwxH-0006ZK-Vr
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 12:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab2KZLeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 06:34:13 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:65084 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab2KZLeM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 06:34:12 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so10637191obb.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 03:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CS+a7P8qQFXHctsot4tIWjVUv7TeRHTZehN/gI1jPZQ=;
        b=yqlz6mGwjt+lzZsqoL8Zxd1LjRyLZk98a/05PkVIXZ0HkJT58HMC+eKSa+jGUPnlOS
         nVW8uPU0SRoEXOum4SY40NxfMGV2V0uc9jarWwyjK9QxE2izRunCsZ+y5JMEnay2zYkx
         0SWZXLd6LNNk4tqbLkyq52S2YqAQUjTKwx1f+gwjHcPalZzCYshgeX8bo+yde9ohuBpV
         iMVVNxtRiqfDMkfb7vg3buJC814Lmwq5u/Z6ShsOxfeTURd+4uC5Sp0n5LlBkEsFhAdl
         Mt05d4bPUYp568QkJZSIriJCfpIrb+8n+qStByo3CZovyWJAggJ49/8N2VH8X5Pd7MsU
         kvTw==
Received: by 10.60.172.229 with SMTP id bf5mr8793079oec.81.1353929652218; Mon,
 26 Nov 2012 03:34:12 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Mon, 26 Nov 2012 03:34:12 -0800 (PST)
In-Reply-To: <7v4nkdxawx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210432>

On Mon, Nov 26, 2012 at 5:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sun, Nov 11, 2012 at 3:19 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> This is a re-roll of the previous series to add support to fetch and push
>>> special modes, and refactor some related code.
>>
>> It seems this one got forgotten, I only see v2 in pu.
>
> Oops; I think that was fell through the cracks during the maintainer
> hand-off.  As the previous one has already been cooking in 'next'
> for a week or so, I would appreciate if you send incremental updates
> to fix or enhance what is in there.

Yes, that's what I have planned for the next patches, as I already did
for remote-hg, but the changes in remote-bzr were a bit bigger.

-- 
Felipe Contreras
