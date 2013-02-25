From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [RFC] git rm -u
Date: Mon, 25 Feb 2013 20:21:27 +0100
Message-ID: <CALWbr2y-CN9A346avc4AG+FN9NHgPXKvWuU-nbcyjt08DavVjw@mail.gmail.com>
References: <50FB1196.2090309@gmail.com>
	<1358632037-ner-2564@calvin>
	<CALWbr2zhxkZEGWc5iN-8MivzV7viEdfwV_Q-iH0xSUWkwnSmyQ@mail.gmail.com>
	<50FB1673.8020808@gmail.com>
	<7vzjys28a0.fsf@alter.siamese.dyndns.org>
	<CALWbr2x9=+PEaGTpGWoqGiiupGsPhLoPcGknPb1WtSgxdpBkdQ@mail.gmail.com>
	<vpq7glw5i20.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:29:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA3jf-0004Cj-E2
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 20:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759661Ab3BYT2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 14:28:52 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:42283 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759596Ab3BYT2t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 14:28:49 -0500
Received: by mail-qa0-f53.google.com with SMTP id z4so1801118qan.5
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 11:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6r7UgcKXRTsokWl9DYuDWCT/J6/vmK7gjxX3VWtolgo=;
        b=BDUDTuPAw7xLmOqTJuFvhm/BlJrJhF7Ej+re8GUSULEUQ7DkXIDJXE/RoEDA1VqOCt
         e5+BF1SOxmDmnYoCLbj9PsUljmsMMtigJAvPRfRN74xdwUUZtepAb5pmI7QvvBREtLeA
         QloalvBjtMLYdMeJrOoyTUQTR9yz9qDcwumd80upENKbCvhdVviKm5TNvttylSJ7P3Nd
         lhTqsm1pWNkaWcukVP7Cv7BhwLRkv0XENJuq9bd3Jw3Ymrg4eb/p9ap45c9siUnftdGp
         3nFVtpIU2Z6BxoCvw1M0PopIRSi57U7+Ed8EU0NpjYyR48n0Wy/dws2ncJFh2rFvnpFa
         RYTw==
X-Received: by 10.49.62.42 with SMTP id v10mr15356629qer.2.1361820087670; Mon,
 25 Feb 2013 11:21:27 -0800 (PST)
Received: by 10.49.70.163 with HTTP; Mon, 25 Feb 2013 11:21:27 -0800 (PST)
In-Reply-To: <vpq7glw5i20.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217090>

On Mon, Feb 25, 2013 at 8:07 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> I must say that I'm not very interested in the feature. In my opinion,
>> there are already many different ways to stage changes.
>> Assuming that the feature would be needed, I would keep it under the
>> scope of git-add, as it's the reference for staging. I would suggest
>> something like:
>>
>>     git add -r   "Stage removal of deleted files."
>
> Would "add -r" stand for "add --remove"? That would be weird ...

Yes (for --remove),
It would not be weird if you consider the opposite of add to be reset
(and not rm).

> "git rm" really seems to be a better place for removing files from the
> index.

Then, I don't exactly understand the meaning of git-rm but being a
_shortcut_ for "remove and stage". Here the files are already removed,
we only need to stage and the best command to stage changes is add.
