From: =?UTF-8?Q?Daniel?= <mjucde@o2.pl>
Subject: =?UTF-8?Q?Re:_[PATCH_v2_1/2]_user-manual:_general_quoting_improvements?=
	=?UTF-8?Q?_(p1)?=
Date: Sat, 23 Jan 2010 20:52:33 +0100
Message-ID: <251dfe4a.62d52a63.4b5b5381.c5497@o2.pl>
References: <1264205935-19203-1-git-send-email-felipe.contreras@gmail.com> <1264205935-19203-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: =?UTF-8?Q?Nanako_Shiraishi?= <nanako3@lavabit.com>,
	=?UTF-8?Q?Junio_C_Hamano?= <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Contreras?= <felipe.contreras@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?Q?Felipe_Contreras?= <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 20:52:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYm2G-0000xq-7Q
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 20:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab0AWTwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 14:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905Ab0AWTwk
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 14:52:40 -0500
Received: from rekin26.go2.pl ([193.17.41.76]:51364 "EHLO rekin26.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657Ab0AWTwj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jan 2010 14:52:39 -0500
Received: from rekin26.go2.pl (rekin26.go2.pl [127.0.0.1])
	by rekin26.go2.pl (Postfix) with ESMTP id DDEDA35D7F5;
	Sat, 23 Jan 2010 20:52:33 +0100 (CET)
Received: from o2.pl (unknown [10.0.0.33])
	by rekin26.go2.pl (Postfix) with SMTP;
	Sat, 23 Jan 2010 20:52:33 +0100 (CET)
In-Reply-To: <1264205935-19203-2-git-send-email-felipe.contreras@gmail.com>
X-Originator: 94.78.177.232
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137854>

> This standarizes the way quotes are handled following semantic rules,
> that make the final text easier to read.
> 
> Here are the general rules:
> 
>  * A command (something that the user must type), goes in backticks. So
>    that the final text appears in monospaced text. e.g. `git clone
>    <repo>`
> 
>  * A common concept (or git lingo), also goes in backticks. So that it
>    appears uniquely different from the rest of the text. e.g. `HEAD`
> 
>  * An example (something that can be easily replaced), goes into
>    typewriter quotes. The final text is not formatted further, so they
>    still appear as typewriter quotes. e.g. "linux-2.6"
> 
>  * A text that can be confused with normal text also goes into
>    typewriter quotes. e.g. "path/to/file" "A"
> 
>  * Text that needs to be emphasized goes in single typewriter quotes. So
>    that it's not confused as normal text. e.g. we often just use the
>    term 'branch'.
> 
>  * Something that needs proper quotation goes into proper double quotes.
>    So that it gets a dramatic effect, as in sombody is using his four
>    quoting fingers. e.g. ``the index''
> 
>  * Something that needs strong emphasis so that the reader can't
>    possibly miss it goes enclosed in asterisks. e.g. *not* tracking
> 
> These rules are not automatic, which one to use depends on the context,
> and often they can be used together. For example, consider this:
> 
> 	The branch 'test' is short for '"refs/heads/test"'
> 
> In this case we want to highligh 'test' and 'refs/heads/test' so they go
> in single typewriter quotes, but also, we want to make clear the full
> refname is not confused as multiple words, so it goes inside double
> typewriter quotes.
> 
> Also, sometimes a text can be both a command, and an example, but only
> one quoting format must be chosen.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Maybe [regardless of its meritorical corectness) this is worth putting
in a separate file in Documentation/ so that people sending patches to
documentation will at least have a chance to read quoting rules and not
use quotes randomly.

-- Daniel
