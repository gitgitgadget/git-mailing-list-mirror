From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: add --repository option
Date: Tue, 02 Jun 2009 08:29:10 -0700
Message-ID: <7vskiifyd5.fsf@alter.siamese.dyndns.org>
References: <1241886936-18941-1-git-send-email-srabbelier@gmail.com>
	<20090602195555.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	"Git List" <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:29:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBVvj-0008Gd-Ay
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 17:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756553AbZFBP3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 11:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754190AbZFBP3K
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 11:29:10 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:64037 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbZFBP3J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 11:29:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090602152911.ZNEV18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jun 2009 11:29:11 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id z3VA1b00L4aMwMQ033VA3f; Tue, 02 Jun 2009 11:29:11 -0400
X-Authority-Analysis: v=1.0 c=1 a=BgOODKWLrgwA:10 a=dy3IT6iKRxIA:10
 a=UQnXkbzPAAAA:8 a=pGLkceISAAAA:8 a=GGr4HCQWNNglx_QOfjIA:9
 a=Vg2AGYG0l76VX5rnz5pZN0gBZmYA:4 a=Q21-j9j7q-gA:10 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <20090602195555.6117@nanako3.lavabit.com> (Nanako Shiraishi's message of "Tue\, 02 Jun 2009 19\:55\:55 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120521>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Sverre Rabbelier <srabbelier@gmail.com>:
>
>> This is a shorthand similar to --system but instead uses
>> the config file of the current repository.
>>
>> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
>> ---
>>
>> 	I often want to check what the local value of a config
>> 	entry is, hence this patch.
>>
>>  builtin-config.c |    7 +++++--
>>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> Junio, may I ask what happened to this patch?

Nothing ;-)

I did see it, but simply forgot about it, as nobody else seemed to be
interested nor found anything objectionable in it.

I somehow think --repository is much harder to type than --local, and in
the context of the command, somehow --local would mesh better with other
existing options --system and --global, but that comment falls into the
bikeshedding category.
