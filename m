From: =?utf-8?Q?R=C3=A9mi_Vanicat?= <vanicat@debian.org>
Subject: Re: Ediff interactive add
Date: Mon, 14 Jan 2013 20:57:49 +0100
Message-ID: <87fw23wn9e.fsf@debian.org>
References: <50EEEE53.7070804@mpp.mpg.de>
	<CAJcAo8sNgdDg_6qRaZmmpLQMXuB22+Mm+q=uDgxoxJErBuNzNg@mail.gmail.com>
	<50EFF882.5010206@mpp.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 14 20:58:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuqAh-0002Z7-RU
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 20:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757978Ab3ANT5y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2013 14:57:54 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55706 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757719Ab3ANT5x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 14:57:53 -0500
Received: by mail-wi0-f178.google.com with SMTP id hn3so1576282wib.11
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 11:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=+NVwBcxvhE4Vt98YJpgQTIENpr1h13lfypmeAf4L8gc=;
        b=S0K3xWvau/ad1fU2ULLpZG21d3UXTIiThG1arHz7hFy0a8G0+liejzegh/y04zmhw4
         UfhqjU0NfJCrqF8B6POTBcq+MfTX+8Jz51ZQnU1trZ9P9xUZhfEfzJ3dpdKqkDqWR0vF
         zO6xzGJ+WgEgamv4MTNV5mGzQFeOa5qgM0d4JdK44d5/M++nsSgJKdkfcbWiTNMg3rEZ
         AS1vY9tqOTzP6yEeERmwY8MUtfLauHfYVNlis/NrGHdLjoMd9HpG9ayPb0RLfT7XiVd1
         ZYh51yp3GAzttugF/Unv31gTHr6t+yuhcP7/rmo7QG8TdWFFm87PsepCd8k9gbNNJMka
         m5sA==
X-Received: by 10.180.86.36 with SMTP id m4mr14632179wiz.5.1358193472468;
        Mon, 14 Jan 2013 11:57:52 -0800 (PST)
Received: from corbeau (2a02-8425-0ad3-2b00-0224-8cff-fe37-c361.rev.sfr.net. [2a02:8425:ad3:2b00:224:8cff:fe37:c361])
        by mx.google.com with ESMTPS id w5sm191317wif.11.2013.01.14.11.57.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Jan 2013 11:57:51 -0800 (PST)
In-Reply-To: <50EFF882.5010206@mpp.mpg.de> (Frederik Beaujean's message of
	"Fri, 11 Jan 2013 12:33:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213523>

=46rederik Beaujean <beaujean-rVlqnlWY17WELgA04lAiVw@public.gmane.org>
writes:

> On 13-01-11 01:47 AM, Samuel Wales wrote:
>> I have more on this, but if possible it would be best to make ediff =
do
>> that natively.  I don't know if that's possible.
> Thanks for your prompt replies. The reason I looked for this feature
> is that it is available in the package git-emacs. There I can choose
> Git -=20
> Add to index - Select changes in current file. Then ediff starts, and
> I can modify the buffer named <index>:FILENAME at will.
> After I answer 'y' to 'Quit this Ediff session?',  another question c=
omes up
> 'Add changes to the git index? (y or n)'. With 'y' I see the message
> Saving file /tmp/git-emacs-tmp6991oXZ...'
>
> So I guess all it takes is saving a temporary file and adding its
> content to the index. Given my lack of experience in lisp programming=
,
> I don't know how hard it actually is to implement in magit,
> though. But a quick look into the source code of git-emacs revealed
> this function
>

[...]

> I would be very happy if this became available in magit.

Could you test what has just been pushed in master, it should do it.

--=20
R=C3=A9mi Vanicat
