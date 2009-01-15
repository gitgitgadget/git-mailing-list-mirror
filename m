From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Thu, 15 Jan 2009 23:20:08 +0100
Message-ID: <bd6139dc0901151420j4ae62433uc0cc70d86dc45cfa@mail.gmail.com>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	 <7vfxjlxuu5.fsf@gitster.siamese.dyndns.org>
	 <20090115153529.GA13961@neumann>
	 <7vvdsgql17.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?SZEDER_G=E1bor?=" <szeder@ira.uka.de>,
	"Anders Melchiorsen" <mail@cup.kalibalik.dk>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 23:22:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNabQ-0002AV-QA
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 23:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935215AbZAOWUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 17:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935292AbZAOWUM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 17:20:12 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:19492 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934871AbZAOWUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 17:20:09 -0500
Received: by yx-out-2324.google.com with SMTP id 8so578546yxm.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 14:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=XuPX3NDKej/+9kEc+QTogzmJRYVGgKGS0t27inX6FP8=;
        b=YAasKpyUK/UR3LCDDPw8qmvxhMPVel3rsVQqI1BPHWUQkkIeobqkI3qMSxvvI1qtuk
         VpoR75xwvBHX9fg5Yti89s3aVMVTbT4d+zNNEJfP68D/vjdYnw3szo+XFSZcTO9oAKQF
         FB/sUJ5A88qix7UlagnVGyRf5O24TMJQNFZRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=XI8g4xDa5AUtDV8pZkhz1vMD+mmjnnUx5ragx1GX5HarlktLxLMtKYzhUMzAFm+1T8
         dTLLcT6+dHVlSfx4FQXh4vQVCWO+hkhndWn5CpaUnW5bsKMhHl3XecLoBqVZNG7xsCsq
         731+E4qdbmCpr1z5SdvjwqSLQzzjSX9Jd/9nA=
Received: by 10.151.83.12 with SMTP id k12mr4762471ybl.196.1232058008316;
        Thu, 15 Jan 2009 14:20:08 -0800 (PST)
Received: by 10.150.121.4 with HTTP; Thu, 15 Jan 2009 14:20:08 -0800 (PST)
In-Reply-To: <7vvdsgql17.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 8117cec1c0becc44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105886>

On Thu, Jan 15, 2009 at 23:09, Junio C Hamano <gitster@pobox.com> wrote:
> I agree that is a true disadvantage that shows "reset --soft HEAD^" is a
> bad idea (you could still say commit -c @{1}, though).

But it's not:
"It also makes sure that a pre-filled editor is fired up when doing
"git rebase --continue", in case the user just wanted to fix the
commit message."

-- 
Cheers,

Sverre Rabbelier
