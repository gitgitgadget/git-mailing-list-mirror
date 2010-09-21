From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: staging specific lines out of a hunk for a commit
Date: Tue, 21 Sep 2010 12:52:38 +0200
Message-ID: <AANLkTim=FQyBHcaHEX92YLgODrvpesuA7e4xwXuWcFg4@mail.gmail.com>
References: <AANLkTin4U78N_8LV8fCWuinNH9AFeOsRBjnvHM0qt2ZH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 12:52:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy0Sr-0006CW-0v
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 12:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195Ab0IUKwk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Sep 2010 06:52:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64792 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab0IUKwj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 06:52:39 -0400
Received: by iwn5 with SMTP id 5so5068189iwn.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 03:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6czmFLNk6u3rhYch+3wI95zXlEpUw7jIZVr2mgnu+WM=;
        b=aXO72XuIk8V7tcv4bOFK+bHfbcZnd1i2TI0JwX1ytPIrDQdwNOlW64+Yo0vHnoNZIb
         eMz+/0UAqLFJ9ssWGyy4+duQzlXoC2eT/F8eWUlo4URfARAHC0ZWNkADsxhH/yIfcZLf
         6Gs1cheNgEY8JMrbVT+YbdSZIYRXwQi+QTEpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pDjQ2WSTULf9+kEWG0QBdKSQm2HPIUXVmibUvU77Y3JCpcK51r1on1DFWsup2APJFF
         9t+Wf/WrTY48xaY5ldIhbzpsLRwrEA/BRmfHfhzadcAcJz4uw+UYwSDiQAjluO8mRrJO
         N2NdKp3U4VsjqVDpDc5kfhUVbl6brk3yp5lfI=
Received: by 10.231.35.138 with SMTP id p10mr11740079ibd.33.1285066358905;
 Tue, 21 Sep 2010 03:52:38 -0700 (PDT)
Received: by 10.231.171.149 with HTTP; Tue, 21 Sep 2010 03:52:38 -0700 (PDT)
In-Reply-To: <AANLkTin4U78N_8LV8fCWuinNH9AFeOsRBjnvHM0qt2ZH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156708>

Hi,

On Tue, Sep 21, 2010 at 12:40, Graeme Geldenhuys
<graemeg.lists@gmail.com> wrote:
> Hi,
>
> I know 'git gui' has this cool feature where you can stage one line a=
t
> a time. This is really handy, but also very annoying, if you have a
> large piece of code you want to commit.
>
> eg: I have a single hunk, which can't be split into smaller hunks
> because it is all new code. But that hunk fixes a few bugs, or
> introduces a few new features.
>
> Is there a way to use 'git add -i' or 'git add -p' or 'git gui' and
> tell it to add for example lines 5-20 of the hunk to the index?
> Currently with 'git gui', I have to right click and select 'Stage lin=
e
> for commit' 15+ times! :-(

Just select the lines you would like to add, and than you can stage
them at once.

>
> I'm using git-gui 0.12.0.64 and git version 1.7.0.4.

But I don't know since when this feature is available.

Bert


>
> --
> Regards,
> =C2=A0 - Graeme -
