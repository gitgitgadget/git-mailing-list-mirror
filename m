From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add the utterly important 'mispel' command
Date: Sun, 4 Oct 2009 02:52:39 -0400
Message-ID: <20091004065239.GA7890@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0910040040180.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 04 09:05:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuLA9-0007tG-IY
	for gcvg-git-2@lo.gmane.org; Sun, 04 Oct 2009 09:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbZJDGxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2009 02:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752296AbZJDGxZ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 02:53:25 -0400
Received: from peff.net ([208.65.91.99]:33010 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847AbZJDGxY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 02:53:24 -0400
Received: (qmail 8994 invoked by uid 107); 4 Oct 2009 06:56:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 04 Oct 2009 02:56:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Oct 2009 02:52:39 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0910040040180.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129510>

On Sun, Oct 04, 2009 at 12:41:55AM +0200, Johannes Schindelin wrote:

> --- a/builtin.h
> +++ b/builtin.h
> @@ -12,6 +12,7 @@ extern const char git_more_info_string[];
>  
>  extern void list_common_cmds_help(void);
>  extern const char *help_unknown_cmd(const char *cmd);
> +const char *help_mispeld_comd(const char *cmd);
>  extern void prune_packed_objects(int);
>  extern int read_line_with_nul(char *buf, int size, FILE *file);
>  extern int fmt_merge_msg(int merge_summary, struct strbuf *in,

Hmph. This hunk doesn't apply to Shawn's master, and your blob sha1 is
not in my repository for a 3-way merge. ;P

Also, I think there is a bug:

  $ git mispel show-branc
  error: You probably meant show-index

Or is it intentional for it to throw the user off track?

Let this be a lesson, kids: don't drink and code.

-Peff
