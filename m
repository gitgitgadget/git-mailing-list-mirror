From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Any command to simplify 'git fetch origin && git reset --hard origin/master'?
Date: Sat, 19 Jan 2008 16:03:39 +0800
Message-ID: <46dff0320801190003x622a4f81j1c156f346f5bac03@mail.gmail.com>
References: <46dff0320801182122t1581b366yad123407aaad6326@mail.gmail.com>
	 <7vr6ge9tvh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 09:04:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JG8gU-0004As-SA
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 09:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbYASIDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 03:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbYASIDl
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 03:03:41 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:21472 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbYASIDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 03:03:40 -0500
Received: by py-out-1112.google.com with SMTP id u52so1915876pyb.10
        for <git@vger.kernel.org>; Sat, 19 Jan 2008 00:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+jC1wk6Vac33Qb+KB5UxwxMsiH7cUQI85zbzhvYToCU=;
        b=Dqs+Gu+P8FRUrni5ZOwZPE5SR+ZxxEqprn3k9Izni7f5u7f3LKn+qWzLacOA39ZXp98o7DQ0sTL1Db2qNt5UggHWyD5DXe+XCeNcvNNkX5Sdy1FXTrbampAV1tluH7gXx4nZSdvVuAvGfbuY5qlGq57eUyHdG4dw0NdSfi4CKa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cVB+UYDGPtE4qXKog1i/xK0u0fnEjlnQ9HmByEBFTtOdLPN7kKCfl8YRN6H/5/eIwbLw6pF0kCjgS82R3ItIdZyfylthA/BIYbjOqZ1XTXlUZast3zDIqXiemksf0PUsoQvKorbQXvh8bLrBEuQfUAcqWuP1vJfXLbpj2pQ5be4=
Received: by 10.35.38.17 with SMTP id q17mr4862224pyj.47.1200729819493;
        Sat, 19 Jan 2008 00:03:39 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 19 Jan 2008 00:03:39 -0800 (PST)
In-Reply-To: <7vr6ge9tvh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71085>

On Jan 19, 2008 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
> > I often encounter the case that the origin reposotory is rebased and i
> > make sure i want to use the origin head as my master
> > Now I have to do
> > $ git fetch origin && git reset --hard origin/master
>
> The fact you are resetting means you do not have anything
> interesting in your own branch yourself (--hard will lose your
> changes and you are willing to lose it), which makes the use
> case much less interesting, but I can understand a workflow that
> is based around rebases, as in:
>
>         $ git fetch origin && git rebase origin/master
>
I know 'git pull --rebase' and use it frequently. However, in the case
i mentioned above, i never do any change in this local branch, i just
use this branch for deployment which should always keep the same with
the origin head (just like the remote tracking branch). So i need a
'fetch & reset --hard' equivalent, not the 'fetch & rebase'
equivalent.




-- 
Ping Yin
