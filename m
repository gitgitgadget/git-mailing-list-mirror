From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a built-in alias for 'stage' to the 'add' command
Date: Tue, 02 Dec 2008 18:18:25 -0800
Message-ID: <7vmyfehuha.fsf@gitster.siamese.dyndns.org>
References: <20081202061455.GA48848@agadorsparticus>
 <fcaeb9bf0812020436n69a21c96g4c13976e493372d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Scott Chacon" <schacon@gmail.com>, git@vger.kernel.org,
	peff@peff.net
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 03:19:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7hLH-0000KG-Pu
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 03:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbYLCCSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 21:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754783AbYLCCSi
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 21:18:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407AbYLCCSh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 21:18:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A70783B35;
	Tue,  2 Dec 2008 21:18:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0356C83B31; Tue,
  2 Dec 2008 21:18:31 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B16D6EF6-C0E0-11DD-99FC-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102204>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 12/2/08, Scott Chacon <schacon@gmail.com> wrote:
>>  diff --git a/git.c b/git.c
>>  index 89feb0b..9e5813c 100644
>>  --- a/git.c
>>  +++ b/git.c
>>  @@ -266,6 +266,7 @@ static void handle_internal_command(int argc, const char **argv)
>>         const char *cmd = argv[0];
>>         static struct cmd_struct commands[] = {
>>                 { "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>>  +               { "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>>                 { "annotate", cmd_annotate, RUN_SETUP },
>>                 { "apply", cmd_apply },
>>                 { "archive", cmd_archive },
>
> Nit-picking. There are some references to "git add" in builtin-add.c,
> like help usage or error message ("Maybe you wanted to say 'git add
> .'?\n"). Should it refer to "git stage" instead as well?

I do not think that is necessary.  As git-stage(1) makes it clear, it is
an alias to "add", not the other way around.
