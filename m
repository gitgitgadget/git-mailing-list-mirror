From: Ping Yin <pkufranky@gmail.com>
Subject: Re: How to setup bash completion for alias of git command
Date: Mon, 21 Jan 2013 11:55:27 +0800
Message-ID: <CACSwcnQu0qgKPhDXeDTFTZgh7FBVmaTCTkoJmEsCTUtaM9HU6g@mail.gmail.com>
References: <CACSwcnQu8Rx83mcGYR6NGzEhoreNR6DfiK876LF7pa9PGm30JA@mail.gmail.com>
	<20130120111424.GG16339@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Marc Khouzam <marc.khouzam@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 04:55:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx8UG-0000u5-OD
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 04:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab3AUDz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 22:55:28 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:50065 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab3AUDz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 22:55:27 -0500
Received: by mail-ie0-f178.google.com with SMTP id c12so8978580ieb.23
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 19:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=GD2dYnNPl69X5YnQxipEi5oEuVoH5cEBXMQ5YTMcwzE=;
        b=DeGkxkkaQ99K0m1Rwszx250s0csHFq8uQsWCFRa7vnRaOukeVM3mMMURgUaLt8p8BA
         htrGHwYJE2kzZ08uYtMOka2JcCBA9KRliF72rI5tfIruxoIssqZJ+0q3s8aJeDZ5pmpo
         tfVMNsTsKn2KVsyL/BxbH1BdiVhG78eEHxHg9hqlEqJPgv6fqGFTbfmanz3kSNBG5fyH
         0rpUnm2YUxZteQ+koOgjaXc3V4s69vXpH9z3+q2UrAuskdw2SO8jlcl4qjQAfjBrKF0k
         05Ij+PtiVKrnwxjaiKArsyLWMi0r1ucJUj3hV2S34doRKoNfNGplShoAluE5pYO8mVZS
         Y3Pg==
X-Received: by 10.50.195.135 with SMTP id ie7mr7927035igc.8.1358740527301;
 Sun, 20 Jan 2013 19:55:27 -0800 (PST)
Received: by 10.231.156.200 with HTTP; Sun, 20 Jan 2013 19:55:27 -0800 (PST)
In-Reply-To: <20130120111424.GG16339@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214079>

On Sun, Jan 20, 2013 at 7:14 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Ping,
>
> Ping Yin wrote:
>>
>> However, in debian (testing, wheezy), it doesn't work
>>
>> $ gtlg or<TAB>
>> gtlg or-bash: [: 1: unary operator expected
>> -bash: [: 1: unary operator expected
>
> Yes, I can reproduce this.  "git bisect" tells me it was introduced
> by v1.7.6-rc0~65^2~4 (completion: remove unnecessary
> _get_comp_words_by_ref() invocations, 2011-04-28).  Since then, Felipe
> has done work to make reusing subcommand completion easy again, so you
> can do
>
>         __git_complete gtlg _git_log
>

Thanks very much. by following your advice, it works now.

Ping Yin
