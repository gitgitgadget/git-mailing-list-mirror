From: David <bouncingcats@gmail.com>
Subject: Re: [BUG] rebase should desambiguate abbreviated hashes before starting
Date: Thu, 27 Jun 2013 21:09:46 +1000
Message-ID: <CAMPXz=pbdarPBPjVzLXdgN6rgqw9msoQcX44RqDFuH-d6KXHug@mail.gmail.com>
References: <20130627105513.6bf84060@chalon.bertin.fr>
	<CAMPXz=pSseQKebNVPVYogTZ2FUc1LqubgmS+pN76sveV=eqC0A@mail.gmail.com>
	<vpq1u7n3jdh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Yann Dirson <dirson@bertin.fr>, git list <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 27 13:09:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsA5G-0006lz-VP
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 13:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541Ab3F0LJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 07:09:47 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:32898 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab3F0LJq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 07:09:46 -0400
Received: by mail-ve0-f169.google.com with SMTP id m1so521641ves.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 04:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ybs4aJD6R3rWDHcuizPq6rNkG5oHecGkOQzaGYL7kgg=;
        b=p7mkBqfCyyFqSGLNzDK1IKUyWqg1JGMQh3GAi7dV0wh4Db2qletw0QlaCfOQSnz/a0
         8AWvWmSe4eJP7llUzRtV4FrIjGGgPHrfrfDnx2TKe3ui5r48nFgeeI14tba4R7gkwLg/
         ppWnTEV+PqYlQcmK7S6kahYF7y+dW4WqROWofHiBvYH8ZKP68LFxuFXuHfo+tiCG3fZd
         UGWSSg43mhBg+nvRylGPmPTAzECIKUzo7HRjkX1PEKVhNf7gl0JOdVPLZXICEQKVdTJK
         vnsfSilJEsQczTNV4zcwy4AjOMMBwB6VaFmeKb0T7tbdvFi0q/LZJxOvtJS01HcrkjnR
         RpZQ==
X-Received: by 10.220.7.134 with SMTP id d6mr3346225vcd.56.1372331386085; Thu,
 27 Jun 2013 04:09:46 -0700 (PDT)
Received: by 10.220.145.145 with HTTP; Thu, 27 Jun 2013 04:09:46 -0700 (PDT)
In-Reply-To: <vpq1u7n3jdh.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229095>

On 27 June 2013 21:04, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> David <bouncingcats@gmail.com> writes:
>
>> I'm not sure that rebase could predict the new hashes without actually creating
>> the prior commits? So maybe the "short" SHA1 is "too short"?
>
> It's OK to show the short sha1 to the user, but "git rebase" could and
> should expand these to complete sha1 right after the editor is closed. I
> think that's what Yann means.

Yes. I realised that just after clicking "send". Thanks :)
