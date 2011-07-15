From: Yang <teddyyyy123@gmail.com>
Subject: Re: "git apply" can't add new files to repo ?
Date: Fri, 15 Jul 2011 16:00:07 -0700
Message-ID: <CAAnh3__UeYTjk4U=s2PZkUoV7SvE440zq-qmwoLxoodisTrZ=A@mail.gmail.com>
References: <CAAnh3_-ayozWnHR-ViJ3zjXQvPQA1kd9spGV_TEU=-kFzBytvw@mail.gmail.com>
	<7vd3hb1ggd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 16 01:00:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhrMl-0006q8-Qz
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 01:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717Ab1GOXAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 19:00:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38858 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab1GOXAI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 19:00:08 -0400
Received: by gwaa18 with SMTP id a18so737762gwa.19
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 16:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z1CQkNPkvuhyoZddOxoQ2Ij1kR+qTftq0B0+WMFDTY0=;
        b=rhvPQcFNJcqxHC7XRXR58tHvXojlPK9k3HMh5bfKqdX8sfhIzCjg0Gh3Nl4gI49C8Y
         0VGQZKNqE3/DjhAwKEObys055ht5h6Ok+Pr/FH85TCoS8GnkaZwWYhWJwRhQNFXih6fu
         QoVe5nDAPOvMHbNoTVYq+sVj2yvxVwjehEgOc=
Received: by 10.236.78.102 with SMTP id f66mr5514606yhe.7.1310770807833; Fri,
 15 Jul 2011 16:00:07 -0700 (PDT)
Received: by 10.236.202.166 with HTTP; Fri, 15 Jul 2011 16:00:07 -0700 (PDT)
In-Reply-To: <7vd3hb1ggd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177240>

thanks all for your replies.

yang

On Fri, Jul 15, 2011 at 12:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Yang <teddyyyy123@gmail.com> writes:
>
>> I created a patch by "git format-patch", and this patch includes some
>> newly-added files.
>>
>> when I got back to the original branch, and apply this patch, the new
>> files appear, but they are not
>> added to git repository, so I have to manually find all the new files
>> and do "git add" for each of them.
>
> You are doing and thinking wrong.
>
> $ git apply patch
> $ git commit
>
> would not add any new contents to existing paths either.
>
> $ git apply --index patch
> $ git commit
>
> would be the way, but that is why we have "git am".
>
