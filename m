From: Michael Loeffler <zvpunry@zvpunry.de>
Subject: Re: [PATCH 1/2] Suggest use of "git add file1 file2" when there is
	nothing to commit.
Date: Fri, 05 Jan 2007 21:44:51 +0100
Message-ID: <1168029891.11130.18.camel@ibook.zvpunry.de>
References: <20061216025309.GA19955@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 22:31:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2wer-0001KA-2T
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 22:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbXAEVbW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 16:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbXAEVbW
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 16:31:22 -0500
Received: from mx01.ap-wdsl.de ([88.198.184.82]:50535 "EHLO mx01.ap-wdsl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbXAEVbV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 16:31:21 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061216025309.GA19955@spearce.org>
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36026>

Hi,

Am Freitag, den 15.12.2006, 21:53 -0500 schrieb Shawn O. Pearce:
...
> @@ -292,7 +291,9 @@ void wt_status_print(struct wt_status *s)
>  	if (s->verbose && !s->is_initial)
>  		wt_status_print_verbose(s);
>  	if (!s->commitable)
> -		printf("%s\n", s->amend ? "# No changes" : "nothing to commit");
> +		printf("%s (%s)\n",
> +			s->amend ? "# No changes" : "nothing to commit",
> +			use_add_msg);
>  }
I don't like the new 'nothing to commit (use "git add ... message")'
message. I use git status very often to see if there is something to
commit, but now there is always this annoying "use git add ..." message.
I just want to see on what the branch is and if there is something to
commit.

If there is something to commit I get the list of untracked or modified
files with the use_add_msg and if I try to commit an empty tree as
initial commit I get the message from git-commit.sh.


bye
